# Fixing nix-darwin linux-builder SSH Issues in Corporate Environments

## TL;DR

**Root Problem**: `nix-darwin`’s `linux-builder` fails in corporate setups due to strict SSH controls, hardcoded host keys, and ignored user SSH configs.

**Key Barriers**:

*   `ssh-ng://` ignores `~/.ssh/config`
*   Hardcoded host key in `nix-darwin`
*   Private key perms too open (`0640` vs `0600`)
*   `nix.buildMachines` appends, not replaces
*   `nix.settings.builders = ""` disables all builders

**Partial Fix**: Override `/etc/nix/machines` via activation script, fix key perms, disable duplicate builders.

**Fundamental Limitation**: Nix remote builders ignore SSH configs and `NIX_SSHOPTS`, making host key issues unfixable without root hacks.

**Recommendation**: Drop `linux-builder` and use local QEMU emulation:

```nix
boot.binfmt.emulatedSystems = [ "x86_64-linux" ];
```

Reliable, corporate-friendly, but slower.

## Problem

On macOS, `nix-darwin`’s `linux-builder` VM fails to connect in corporate environments:

```text
cannot build on 'ssh-ng://builder@linux-builder': failed to start SSH connection
```

Chef-managed SSH config prevents overrides for `linux-builder` and its host key.

## Key Fix Attempts & Discoveries

*   **Hostname resolution** ✅
    *   Add `linux-builder` to `/etc/hosts` in activation script.

*   **Protocol switch** ✅
    *   Use `ssh://` instead of `ssh-ng://` + custom `programs.ssh.matchBlocks`.

*   **Host key mismatch** ❌
    *   Hardcoded in `nix-darwin`; can’t override.

*   **Private key permissions** ✅
    *   Change `/etc/nix/builder_ed25519` to `0600`.

*   **Duplicate builders** ❌
    *   `nix.buildMachines` appends to defaults.

*   **builders = ""** ❌
    *   Disables all builders.

## Working Partial Solution

**Config Highlights**:

```nix
nix.linux-builder = {
  enable = true;
  protocol = "ssh";
  systems = [ "aarch64-linux" "x86_64-linux" ];
};
nix.buildMachines = [];

system.activationScripts.postActivation.text = ''
  echo "127.0.0.1 linux-builder" >> /etc/hosts
  chmod 600 /etc/nix/builder_ed25519
  sleep 2
  echo "ssh://builder@localhost aarch64-linux,x86_64-linux /etc/nix/builder_ed25519 1 1 benchmark,big-parallel,kvm - -" > /etc/nix/machines
'';
```

*   Keeps VM management
*   Prevents duplicate machine entries
*   Controls `/etc/nix/machines` content

**Limitations**:

*   Regular users can’t access the SSH key (root-only), so cross-compilation needs `sudo`.

## Final Discovery: Fundamental Limitation

Nix remote builder SSH calls ignore:

*   `~/.ssh/config`
*   `NIX_SSHOPTS`

Always enforces strict host key checking.

This makes corporate host key issues unresolvable without root-level hacks.

## Recommended Alternative: Local Emulation

```nix
boot.binfmt.emulatedSystems = [ "x86_64-linux" ];
```

*   ✅ No SSH/host key problems
*   ✅ Works in corporate environments
*   ⚠️ Slower than VM

**After switch**:

```bash
nix build --system x86_64-linux .#package
```