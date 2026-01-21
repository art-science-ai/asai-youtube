# SSH Infrastructure

Multi-layered SSH architecture supporting secure access, secret management, remote builds, and deployments across all dragonix hosts.

## Architecture overview

```
┌─────────────────────────────────────────────────────────────────────────┐
│                           SSH Infrastructure                            │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  ┌─────────────┐     Tailscale SSH      ┌─────────────┐                │
│  │   vermax    │◄────────────────────►  │  seasmoke   │                │
│  │  (desktop)  │                        │  (server)   │                │
│  └──────┬──────┘                        └──────┬──────┘                │
│         │                                      │                        │
│         │ 1Password Agent                      │ Host SSH Key           │
│         ▼                                      ▼                        │
│  ┌─────────────┐                        ┌─────────────┐                │
│  │ SSH Agent   │                        │ SOPS Decrypt│                │
│  │ Forwarding  │                        │ (age keys)  │                │
│  └─────────────┘                        └─────────────┘                │
│                                                                         │
│  ┌─────────────────────────────────────────────────────────────────┐   │
│  │                    Remote Build Pipeline                         │   │
│  │  vermax ──SSH──► seasmoke (build) ──SSH──► vermax (result)      │   │
│  └─────────────────────────────────────────────────────────────────┘   │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

## Components

### 1. Tailscale SSH

Tailscale provides mesh VPN connectivity with built-in SSH access.

**Server configuration** (`modules/hosts/nixos-server/tailscale.nix`):
```nix
services.tailscale = {
  enable = true;
  extraSetFlags = [ "--ssh" ];  # Enable Tailscale SSH
};

networking.firewall.trustedInterfaces = [ "tailscale0" ];
```

**ACL rules** (`references/tailscale_acl.jsonc`):
- SSH access based on device ownership (`autogroup:self`)
- All tailnet members can SSH to their own devices
- Tag-based restrictions for untrusted devices

### 2. 1Password SSH agent

Smart agent routing based on connection context.

**Configuration** (`modules/home/auth/user-nikhilmaddirala.nix`):
```nix
programs.ssh = {
  extraConfig = ''
    # When connected via SSH (forwarded agent available)
    Match exec "test -n \"$SSH_CONNECTION\" -a -S \"$SSH_AUTH_SOCK\""
      IdentityAgent $SSH_AUTH_SOCK

    # Local access - use 1Password agent
    Match all
      IdentityAgent ~/.1password/agent.sock  # Linux
      # IdentityAgent ~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock  # macOS
  '';
};
```

**Behavior**:
- Local session: Uses 1Password agent for key access
- SSH session: Uses forwarded agent from source machine
- Git signing: Ready to enable via `op-ssh-sign`

### 3. SSH and SOPS integration

Host SSH keys enable SOPS secret decryption at boot.

**Key derivation** (`vars/.sops.yaml`):
```yaml
keys:
  - &seasmoke_host_ssh age1...  # Derived from SSH host key
  - &vermax_host_ssh age1...

creation_rules:
  - path_regex: secrets\.yaml$
    key_groups:
      - age:
        - *seasmoke_host_ssh
        - *vermax_host_ssh
```

**Linux SOPS config** (`modules/hosts/sops/linux.nix`):
```nix
sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
```

**Key conversion**: Use `ssh-to-age` to derive age keys from SSH host keys:
```bash
ssh-keyscan seasmoke | ssh-to-age
```

### 4. SSH for remote builds

Root SSH key enables nix daemon to delegate builds to remote hosts.

**Setup** (performed manually, then declaratively managed):
```bash
# Generate dedicated build key (passwordless)
sudo ssh-keygen -t ed25519 -f /root/.ssh/id_ed25519_nix_build -N "" -C "nix-remote-build@vermax"

# Add to remote host
ssh seasmoke "cat >> ~/.ssh/authorized_keys" < /root/.ssh/id_ed25519_nix_build.pub
```

**Usage via builders file** (`/tmp/nix-builders.conf`):
```
ssh://nikhilmaddirala@91.99.176.80 x86_64-linux /root/.ssh/id_ed25519_nix_build 8 2 big-parallel
```

**Build command**:
```bash
nix build --builders @/tmp/nix-builders.conf --max-jobs 0 .#package
```

**Declarative config** (planned for `modules/hosts/nix-settings/distributed-builds.nix`):
```nix
nix.buildMachines = [{
  hostName = "seasmoke";
  systems = [ "x86_64-linux" ];
  protocol = "ssh-ng";
  maxJobs = 8;
  speedFactor = 2;
  sshUser = "nikhilmaddirala";
  sshKey = "/root/.ssh/id_ed25519_nix_build";
}];

nix.distributedBuilds = true;
nix.settings.builders-use-substitutes = true;
```

### 5. Deploy-rs SSH deployments

Remote NixOS deployments via SSH.

**Configuration** (`flake.nix`):
```nix
deploy.nodes.seasmoke = {
  hostname = "seasmoke";
  sshUser = "nikhilmaddirala";
  remoteBuild = true;
  autoRollback = true;
  magicRollback = true;
  confirmTimeout = 300;
};
```

**Usage**:
```bash
deploy .#seasmoke        # Deploy system + home
deploy .#seasmoke.system # Deploy system only
```

## Host configurations

**SSH matchBlocks** (`modules/home/auth/user-nikhilmaddirala.nix`):

| Host | IP | User | Agent Forward |
|------|-----|------|---------------|
| seasmoke | 91.99.176.80 | nikhilmaddirala | Yes |
| vermax | 192.168.1.19 | nikhilmaddirala | Yes |
| sheepstealer | 15.lw.itsby.design | box_ring_fence | Yes |

**Global defaults** (`modules/home/cli/miscellaneous/programs.nix`):
```nix
programs.ssh.matchBlocks."*" = {
  forwardAgent = false;      # Disabled globally, enabled per-host
  addKeysToAgent = "no";
  serverAliveCountMax = 3;
};
```

## Files

| Purpose | Path |
|---------|------|
| SSH host config | `modules/home/auth/user-nikhilmaddirala.nix` |
| SSH defaults | `modules/home/cli/miscellaneous/programs.nix` |
| SOPS key config | `vars/.sops.yaml` |
| SOPS secrets | `vars/secrets.yaml` |
| Tailscale ACLs | `references/tailscale_acl.jsonc` |
| Tailscale (desktop) | `modules/hosts/desktop/tailscale.nix` |
| Tailscale (server) | `modules/hosts/nixos-server/tailscale.nix` |
| Deploy-rs config | `flake.nix` (deploy.nodes section) |

## Troubleshooting

### Remote build fails with "failed to start SSH connection"

**Cause**: Nix daemon runs as root but lacks SSH access to remote host.

**Solution**:
```bash
# Generate root SSH key
sudo ssh-keygen -t ed25519 -f /root/.ssh/id_ed25519_nix_build -N ""

# Add to remote authorized_keys
sudo cat /root/.ssh/id_ed25519_nix_build.pub | ssh seasmoke "cat >> ~/.ssh/authorized_keys"

# Test
sudo ssh -i /root/.ssh/id_ed25519_nix_build nikhilmaddirala@seasmoke hostname
```

### SOPS decryption fails on new host

**Cause**: Host SSH key not added to `.sops.yaml`.

**Solution**:
```bash
# Get age key from SSH host key
ssh-keyscan newhost | ssh-to-age

# Add to vars/.sops.yaml under keys section
# Re-encrypt secrets:
sops updatekeys vars/secrets.yaml
```

### 1Password agent not found

**Cause**: 1Password app not running or agent socket path changed.

**Solution**:
- Ensure 1Password is running with SSH agent enabled
- Check socket path: `ls -la ~/.1password/agent.sock` (Linux) or `~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock` (macOS)
- Verify with: `SSH_AUTH_SOCK=~/.1password/agent.sock ssh-add -l`
