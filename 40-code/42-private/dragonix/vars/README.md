# SOPS-Nix Secrets Management

Quick reference for managing secrets with SOPS-Nix in your Nix configuration. This guide covers adding new secrets, editing existing ones, and updating the configuration files needed to make them available in your environment.

## Decision Tree: Adding a New Host

- Desktop/local machine with 1Password? → Use Desktop Workflow
- Server/remote machine without 1Password? → Use Server Workflow

## Desktop Workflow (with 1Password)

Work directly on the new desktop machine.

### Setup Age key for decryption

```bash
mkdir -p ~/.config/sops/age
ssh-to-age -private-key -i ~/.ssh/nikhilmaddirala@meleys > ~/.config/sops/age/keys.txt
chmod 600 ~/.config/sops/age/keys.txt
```

### Add new host

```sh
# 1. Generate SSH host keys (macOS only)
sudo ssh-keygen -A

# 2. Get host SSH key
sudo cat /etc/ssh/ssh_host_ed25519_key.pub

# 3. Convert to Age format
echo "ssh-ed25519 AAAA..." | ssh-to-age

# 4. Update vars/.sops.yaml - add both keys:
#   - &newhost_ssh_to_age age1...
#   - &newhost_ssh ssh-ed25519 AAAA...
# Add to creation_rules > key_groups > age

# 5. Re-encrypt secrets
sops --config vars/.sops.yaml updatekeys vars/secrets.yaml

# 6. Commit and deploy
git add vars/.sops.yaml && git commit -m "Add newhost keys to SOPS"
darwin-rebuild switch --flake .#newhost  # or nixos-rebuild
```

## Server Workflow (without 1Password)

Work from your local machine with Age key.

```bash
# 1. Get server SSH key (from local machine)
ssh newserver "sudo cat /etc/ssh/ssh_host_ed25519_key.pub"

# 2. Convert to Age (on local machine)
echo "ssh-ed25519 AAAA..." | ssh-to-age

# 3. Update vars/.sops.yaml on local machine
# Same as desktop: add &newserver_ssh_to_age and &newserver_ssh

# 4. Re-encrypt on local machine
sops --config vars/.sops.yaml updatekeys vars/secrets.yaml

# 5. Commit, push, deploy
git add vars/.sops.yaml && git commit -m "Add newserver keys"
git push
ssh newserver "cd /path/to/nix-config && git pull && sudo nixos-rebuild switch --flake .#newserver"
```

## Required Environment Variable

**Critical**: SOPS requires this environment variable. Add to `~/.zshrc` or `~/.bashrc`:

```bash
export SOPS_AGE_KEY_FILE=~/.config/sops/age/keys.txt
```

Without this, SOPS fails with "no identity matched any of the recipients".

## Managing Secrets

### Adding New Secrets

To add a new secret to your configuration, follow these steps:

#### 1. Edit the secrets file
```bash
sops vars/secrets.yaml
```

Add your new secret in YAML format:
```yaml
github:
  token: "your_token_here"
  username: "your_username"
  email: "your@email.com"
openai:
  api_key: "your_api_key_here"
# Add your new secret here:
new_service:
  api_key: "your_new_api_key_here"
  username: "your_new_username"
```

#### 2. Update the centralized secrets registry
Edit `modules/common/secrets-registry.nix` to add your secret to the `secretDefinitions`. Add one entry for each secret:

```nix
# In the secretDefinitions section, add:
new-service-api-key = {
  sopsPath = "new_service/api_key";
  filePath = "/run/secrets/new_service/api_key";
  envVar = "NEW_SERVICE_API_KEY";
  owner = "nikhilmaddirala";
  mode = "0400";
};
```

### Understanding Each Field

When adding secrets, here's how to determine each field:

**sopsPath** - Path in `vars/secrets.yaml`
- Mirrors your YAML structure: `service/secret_name`
- Examples: `github/token`, `openai/api_key`, `zai/api_key`
- Decide by: How you organize it in the encrypted file

**filePath** - Where the decrypted secret lives at runtime
- Always starts with `/run/secrets/` (tmpfs, not persisted to disk)
- Format: `/run/secrets/service/secret_name`
- Should match your `sopsPath` structure
- Example: `/run/secrets/zai/api_key` for `sopsPath = "zai/api_key"`

**envVar** - Environment variable name in your shells
- Format: `UPPERCASE_WITH_UNDERSCORES`
- Include service prefix to avoid conflicts: `ZAI_API_KEY` not just `API_KEY`
- Check the tool's documentation for standard variable names
- Examples: `GITHUB_TOKEN`, `OPENAI_API_KEY`, `ZAI_API_KEY`

**owner** - Which user owns the decrypted file
- For your personal tools/scripts: `"nikhilmaddirala"` (your username)
- For system services: `"root"`
- For specific service users: the service username
- Decide by: Who needs to read this secret?

**mode** - File permissions (octal)
- Always `"0400"` for secrets (owner read-only)
- This is the secure default
- Don't change this

### Special Case: Secrets Needed by Both User and System

If a secret is needed by both a system service (root) and your user, create two separate entries that decrypt the same secret:

```nix
# System service access
service-token-root = {
  sopsPath = "service/token";              # Same secret source
  filePath = "/run/secrets/service/token";
  envVar = "SERVICE_TOKEN";
  owner = "root";
  mode = "0400";
};

# User access
service-token-user = {
  sopsPath = "service/token";              # Same secret source
  filePath = "/run/secrets/service/token_user";  # Different location
  envVar = "SERVICE_TOKEN_USER";           # Optional: different var name
  owner = "nikhilmaddirala";
  mode = "0400";
};
```

sops-nix will decrypt the same secret twice with different ownership and file locations.

That's it! The secrets will automatically be:
- Created by sops-nix in `/run/secrets/` with proper permissions
- Loaded into all shells (bash, zsh, fish, nushell) as environment variables

#### 3. Deploy the changes
```bash
# For macOS
darwin-rebuild switch --flake .#hostname

# For NixOS
sudo nixos-rebuild switch --flake .#hostname
```

### Editing Existing Secrets

#### 1. Edit the encrypted secrets file
```bash
sops vars/secrets.yaml
```

Make your changes and save the file. SOPS will automatically re-encrypt it.

#### 2. Rebuild your system to apply changes
```bash
# macOS
darwin-rebuild switch --flake .#hostname

# NixOS
sudo nixos-rebuild switch --flake .#hostname
```

### Removing Secrets

#### 1. Remove from secrets registry
Delete the secret entry from the `secretDefinitions` section in `modules/common/secrets-registry.nix`.

#### 2. Remove from secrets file
```bash
sops vars/secrets.yaml
# Delete the secret entries and save
```

That's it! The shell environment variables will automatically be removed since they're generated from the centralized definitions.

#### 3. Rebuild and clean up
```bash
# Rebuild system
darwin-rebuild switch --flake .#hostname  # or nixos-rebuild

# Clean up any leftover secret files (optional)
sudo rm -rf /run/secrets/removed_service/
```

## Common Operations

### Edit secrets
```bash
sops vars/secrets.yaml
```

### View secrets (read-only)
```bash
sops -d vars/secrets.yaml
```

### Re-encrypt after updating .sops.yaml
```bash
sops --config vars/.sops.yaml updatekeys vars/secrets.yaml
```

### Convert SSH to Age
```bash
echo "ssh-ed25519 AAAA..." | ssh-to-age
```

### Rebuild system
```bash
darwin-rebuild switch --flake .#hostname       # macOS
sudo nixos-rebuild switch --flake .#hostname   # NixOS
```

### Verify secrets are available
```bash
# Check that secrets are decrypted to /run/secrets/
ls -la /run/secrets/

# Verify specific secret exists
cat /run/secrets/github/token
echo $GITHUB_TOKEN  # Should match the token above
```

## Troubleshooting

### "no identity matched any of the recipients"

1. Check environment variable: `echo $SOPS_AGE_KEY_FILE`
2. Verify file exists: `cat ~/.config/sops/age/keys.txt`
3. Check permissions: `chmod 600 ~/.config/sops/age/keys.txt`
4. Verify key matches one in `.sops.yaml`
5. Re-encrypt if `.sops.yaml` was updated

### Secrets not updating

1. Verify file saved after `sops vars/secrets.yaml`
2. Rebuild system: `darwin-rebuild switch --flake .#hostname`
3. Check secret declared in Nix configuration

## Centralized Secrets Management

Since November 2025, all secrets are centrally defined in `modules/common/secrets-registry.nix` in the `secretDefinitions` data structure. This is the single source of truth for:

- Secret file paths (`/run/secrets/...`)
- Environment variable names (`GITHUB_TOKEN`, etc.)
- File ownership and permissions
- Integration with all shells (bash, zsh, fish, nushell)

When you add a secret to `secretDefinitions`, it automatically:
1. Gets created by sops-nix with correct permissions
2. Gets loaded as environment variables in all shells
3. Works on both NixOS and macOS (with platform-specific groups: `wheel` vs `staff`)

No need to update `shell-config.nix` - both system (`sops.nix`) and home-manager (`shell-config.nix`) modules import the centralized registry independently and consume the definitions via helper functions.

## Best Practices

### Secret Organization
- Group related secrets under a service name in `vars/secrets.yaml` (e.g., `github/`, `openai/`)
- Use descriptive names that clearly indicate the purpose
- Add corresponding entries to `secretDefinitions` in `modules/common/secrets-registry.nix`
- Use nested YAML structure for complex services

### Security Considerations
- Always use `mode = "0400"` for sensitive files (owner read-only)
- Set appropriate owner and group (usually your username)
- Secrets are stored in tmpfs (`/run/secrets/`) and not persisted to disk
- Regularly rotate API keys and sensitive credentials
- Never commit unencrypted secrets to version control

### Environment Variable Naming
- Use uppercase names with underscores: `NEW_SERVICE_API_KEY`
- Include service prefix to avoid conflicts
- Follow shell environment variable conventions
- Document what each variable is used for

### Testing Secrets
After adding or updating secrets:
```bash
# Check that the secret file exists
ls -la /run/secrets/new_service/api_key

# Verify permissions
stat /run/secrets/new_service/api_key  # Should be 0400

# Test environment variable
echo $NEW_SERVICE_API_KEY

# Test in your application
# (application-specific testing)
```

## How It Works

### Local Development
- Manual Age key setup at `~/.config/sops/age/keys.txt`
- SOPS uses `SOPS_AGE_KEY_FILE` env var to locate key
- Derived from SSH private key via `ssh-to-age`
- Secrets decrypted to `/run/secrets/` on system activation

### Server Deployment
- sops-nix auto-converts SSH host key to Age during build
- No manual Age setup required
- Secrets decrypted to `/run/secrets/` with permissions 0400
- tmpfs mount, not persisted to disk
- Automatic cleanup on system shutdown

## Security Model

- Age encryption using SSH host keys
- Only machines with matching SSH private keys decrypt
- File permissions 0400 (owner read-only)
- Secrets in `/run/secrets/` (tmpfs)

## Initial Setup (First Host Only)

```bash
# 1. Get SSH keys
sudo cat /etc/ssh/ssh_host_ed25519_key.pub    # host key
cat ~/.ssh/ed25519.pub                         # user key

# 2. Convert to Age
echo "ssh-ed25519 AAAA..." | ssh-to-age

# 3. Create vars/.sops.yaml
# Add keys and creation_rules (see vars-README.md)

# 4. Create secrets file
cp vars/secrets.yaml.example vars/secrets.yaml
# Edit to add secrets
sops --encrypt --in-place vars/secrets.yaml

# 5. Declare secrets in Nix (hosts/common/secrets.nix)
# Set sops.defaultSopsFile and sops.secrets entries

# 6. Deploy
darwin-rebuild switch --flake .#hostname
sudo ls -la /run/secrets/  # verify
```
