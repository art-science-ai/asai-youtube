# Vars

## Overview

### About
- SOPS-encrypted secrets and configuration variables
- Age encryption with keys derived from SSH keys
- Centralized registry ensures consistent paths and environment variables

### Key features
- Encrypted at rest, decrypted at system activation
- Multi-key support: user SSH keys and host SSH keys
- Automatic environment variable loading in shell init

### Technology / architecture
- **Encryption:** SOPS with Age backend
- **Key derivation:** SSH ed25519 keys converted to Age format
- **Decryption:** sops-nix module at system activation
- **Registry:** `modules/common/secrets-registry.nix`


## User guide

### Files

| File | Purpose |
|------|---------|
| `.sops.yaml` | Encryption rules and authorized keys |
| `secrets.yaml` | Encrypted secrets (API tokens, credentials) |
| `secrets.yaml.example` | Template showing secrets structure |
| `vars.yaml` | Non-sensitive configuration variables |

### Usage examples

View decrypted secrets (requires authorized key):
```bash
cd vars
sops secrets.yaml
```

Check if secrets are available after system rebuild:
```bash
# File exists and has correct permissions
ls -la /run/secrets/

# Read a secret (if you have permission)
cat /run/secrets/github/token

# Verify environment variable is set
echo $GITHUB_TOKEN
```

### Configuration

Set Age key path for SOPS operations:
```bash
export SOPS_AGE_KEY_FILE=~/.config/sops/age/keys.txt
```


## Developer guide

### Setup

#### Desktop (interactive Age key)

1. Generate or convert your Age key:
   ```bash
   # Generate new key
   age-keygen -o ~/.config/sops/age/keys.txt

   # Or convert existing SSH key to Age
   ssh-to-age -private-key -i ~/.ssh/id_ed25519 > ~/.config/sops/age/keys.txt
   ```

2. Set environment variable (add to shell profile):
   ```bash
   export SOPS_AGE_KEY_FILE=~/.config/sops/age/keys.txt
   ```

3. Add your Age public key to `.sops.yaml` under `keys:`

#### Server (automatic from host SSH key)

NixOS servers automatically convert their SSH host key to Age format. The `sops` module handles this via `sops.age.sshKeyPaths`.

### Managing secrets

#### Add a new secret

1. Edit encrypted file:
   ```bash
   sops secrets.yaml
   ```

2. Add the secret in YAML format:
   ```yaml
   service-name:
     api_key: "secret_value"
   ```

3. Register in `modules/common/secrets-registry.nix`:
   ```nix
   service-api-key = {
     sopsPath = "service-name/api_key";
     filePath = "/run/secrets/service-name/api_key";
     envVar = "SERVICE_API_KEY";
     owner = "nikhilmaddirala";
     mode = "0400";
   };
   ```

4. Rebuild the system to deploy

#### Re-encrypt for new keys

When adding a new host or user key:

1. Add the key to `.sops.yaml`
2. Re-encrypt:
   ```bash
   sops updatekeys secrets.yaml
   ```

#### Remove a secret

1. Remove from `secrets.yaml`
2. Remove from `modules/common/secrets-registry.nix`
3. Rebuild affected systems

### How it works

```
secrets.yaml (encrypted)
    ↓ sops-nix module decrypts at activation
/run/secrets/<path> (0400 permissions)
    ↓ shell init reads file
$ENV_VAR (available in shell)
```

The secrets registry defines each secret's:
- SOPS path (location in secrets.yaml)
- File path (where decrypted file appears)
- Environment variable name
- Owner and permissions


## References

- [../modules/common/secrets-registry.nix](../modules/common/secrets-registry.nix) - Secret definitions
- [../modules/hosts/sops/](../modules/hosts/sops/) - SOPS-nix system configuration
- [SOPS documentation](https://github.com/getsops/sops)
- [sops-nix](https://github.com/Mic92/sops-nix)


## Appendix

### Current secrets

| Secret | Environment Variable | Owner |
|--------|---------------------|-------|
| `github/token` | `GITHUB_TOKEN` | nikhilmaddirala |
| `github/username` | `GITHUB_USERNAME` | nikhilmaddirala |
| `github/email` | `GITHUB_EMAIL` | nikhilmaddirala |
| `openai/api_key` | `OPENAI_API_KEY` | nikhilmaddirala |
| `openrouter/api_key` | `OPENROUTER_API_KEY` | nikhilmaddirala |
| `todoist/api_token` | `TODOIST_API_TOKEN` | nikhilmaddirala |
| `cloudflare/api_token_seasmoke` | `CLOUDFLARE_API_TOKEN` | root |
| `zai/api_key` | `ZAI_API_KEY` | nikhilmaddirala |

### Key naming convention

Keys in `.sops.yaml` follow this pattern:
- `<hostname>_host_ssh` - SSH public key of the host
- `<hostname>_host_ssh_to_age` - Age key derived from host SSH
- `<hostname>_<user>_ssh` - User SSH public key
- `<hostname>_<user>_ssh_to_age` - Age key derived from user SSH

All listed keys can decrypt the secrets, enabling both user editing and automated system decryption.
