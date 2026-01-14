# Vermax

Mini-PC (x86_64-linux) serving as desktop and server.

## Storage architecture

### Btrfs subvolumes

Vermax uses btrfs with separate subvolumes for logical isolation and independent snapshot management:

- `@root` – Root filesystem (currently persistent, will become ephemeral when impermanence is re-enabled)
- `@nix` – Nix store (always persistent)
- `@persist` – System state and service data (always persistent)
- `@home` – User home directories (always persistent)

### Current state

Impermanence is currently DISABLED (see line 15 in `default.nix`). This means:
- Root filesystem persists across reboots (standard NixOS behavior)
- All data in /var, /etc, /tmp stays between boots
- When re-enabled, root will be wiped on each boot and restored from a blank snapshot

### Directory structure standards

This table defines where different types of data should live, both now (impermanence disabled) and in the future (when re-enabled):

| Data type | Current location | With impermanence | Subvolume | Snapshots |
|-----------|-----------------|-------------------|-----------|-----------|
| User files | /home/[user] | /home/[user] | @home | Yes (Snapper) |
| Service data | /var/lib/[service] | /persist/var/lib/[service] | @persist | Yes (Snapper) |
| System state | /var/lib/systemd, /var/lib/nixos | /persist/var/lib/systemd, etc. | @persist | Yes (Snapper) |
| Nix packages | /nix/store | /nix/store | @nix | No (reproducible) |
| Temporary files | /tmp, /var/tmp | /tmp, /var/tmp | @root | No (ephemeral) |
| System config | /etc | /etc (regenerated from impermanence) | @root | No (declarative) |

Key principles:
- User data lives in /home
- Service data lives in /var/lib/[service-name] (NixOS convention)
- When impermanence is active, persistent service data must be declared in impermanence.nix
- Avoid using /opt or /srv (not standard in NixOS)

### Snapshot strategy with Snapper

Snapper provides automatic btrfs snapshots with configurable retention policies:

**@home snapshots** (user data protection)
- Hourly: Last 24 (1 day)
- Daily: Last 7 (1 week)
- Weekly: Last 4 (1 month)
- Monthly: Last 12 (1 year)
- Users can browse /home/.snapshots to restore files

**@persist snapshots** (service data and system state)
- Hourly: Last 12 (half day)
- Daily: Last 7 (1 week)
- Weekly: Last 4 (1 month)
- Monthly: Last 6 (half year)
- Root can browse /persist/.snapshots to restore service data

**Not snapshotted:**
- @root – Ephemeral (wiped on boot) or reproducible (regenerated from config)
- @nix – Reproducible (rebuilt from flake.nix)

This allows you to:
- Restore individual user files without affecting services
- Roll back service data independently
- Recover from accidental deletions or misconfigurations
- Maintain different retention policies based on importance

### Migration checklist for re-enabling impermanence

Before uncommenting impermanence.nix, ensure service data is properly persisted:

- [x] Add /var/lib/couchdb to impermanence.nix (Obsidian LiveSync)
- [ ] Add any other service directories from /var/lib/[service]
- [ ] Test that services start correctly after enabling impermanence
- [x] Verify Snapper snapshots exist for @persist before making @root ephemeral

### Managing snapshots with Snapper

After deployment, Snapper will automatically create snapshots every hour. You can manage snapshots using these commands:

List all snapshots for home:
```bash
sudo snapper -c home list
```

List all snapshots for persist:
```bash
sudo snapper -c persist list
```

Compare current state with a snapshot:
```bash
sudo snapper -c home status 1..0  # Compare snapshot 1 with current
```

Browse snapshot files:
```bash
ls /home/.snapshots/1/snapshot/  # Browse home snapshot 1
ls /persist/.snapshots/1/snapshot/  # Browse persist snapshot 1
```

Restore a file from snapshot:
```bash
# Copy a file from snapshot back to current location
sudo cp /home/.snapshots/5/snapshot/nikhilmaddirala/important-file.txt /home/nikhilmaddirala/
```

Restore entire subvolume (ADVANCED - use with caution):
```bash
# This rolls back the entire @home subvolume to snapshot 10
sudo snapper -c home undochange 1..10
```

Delete a specific snapshot:
```bash
sudo snapper -c home delete 5
```

Check snapshot disk usage:
```bash
sudo btrfs filesystem df /home
sudo btrfs filesystem df /persist
```

## Installation

### Prerequisites
- NixOS minimal ISO on USB drive
- Physical access to target machine
- Network connectivity

### 1. Boot and Connect

1. Boot target machine from NixOS ISO
2. On the target machine, find its IP address:
   ```bash
   ip a  # Look for the wired interface (usually enp*)
   ```
3. Set a password on target machine using `passwd`
- Test network from target: `ping 8.8.8.8` (DHCP is usually active by default)
   - If needed: `sudo dhcpcd enp2s0`
4. From your Mac, SSH to the target with agent forwarding (no password required):
   ```bash
   ssh -A nixos@<target-ip>
   ```

### 2. Get Flake and Partition

```bash
git clone git@github.com:nikhilmaddirala/nix-config.git /tmp/flake && cd /tmp/flake

# Clean up any existing installations
sudo umount -R /mnt 2>/dev/null || true && \
    sudo swapoff -a 2>/dev/null || true && \
    sudo dmsetup remove_all --force 2>/dev/null || true && \
    sleep 3

# Partition disk with disko
sudo nix --experimental-features 'nix-command flakes' run \
    github:nix-community/disko -- \
    --mode disko \
    hosts/vermax/disk-config.nix
```

### 3. Generate Hardware Config and Install

```bash
# Generate hardware configuration (without filesystems - disko handles those)
sudo nixos-generate-config --no-filesystems --root /mnt
sudo cp /mnt/etc/nixos/hardware-configuration.nix hosts/vermax/hardware-configuration.nix

git add hosts/vermax/hardware-configuration.nix && \
    git commit -m "Add hardware configuration for Vermax" && \
    git push

# Install NixOS with full configuration and reboot
sudo nixos-install --root /mnt --flake .#vermax && sudo reboot
```

### 4. Post-Installation Setup

After the system boots and you can SSH in, perform these essential setup steps.

#### 4a. Configure Swap and Hibernation

After the system boots, get the swap partition UUID and wire it up for hibernation:

```bash
ssh -A nikhilmaddirala@vermax

# Get the swap UUID
sudo lsblk -f | grep swap

# In your local repo, edit hosts/vermax/default.nix and uncomment/update:
# swapDevices = [
#   { device = "/dev/disk/by-uuid/<swap-uuid-here>"; }
# ];
# boot.resumeDevice = "/dev/disk/by-uuid/<swap-uuid-here>";

# Push the change, then rebuild on the system
sudo nixos-rebuild switch --flake /path/to/nix-config#vermax
```

#### 4b. Activate Home-Manager for Users (Using deploy-rs)

The recommended approach is to use deploy-rs, which automatically handles system rebuild and home-manager activation for all configured users in a single command:

```bash
# From your Mac, deploy system and all home environments
nix run deploy -- --flake .#vermax
```

This single command will:
1. Build the NixOS system configuration
2. Build and activate home-manager for nikhilmaddirala
3. Build and activate home-manager for rukmasen

Deploy-rs handles user switching and permissions automatically.

**Alternative: Manual activation** (if deploy-rs isn't available)

If you prefer or need to activate home-manager manually:

```bash
# For nikhilmaddirala user
nix run home-manager -- switch --flake .#nikhilmaddirala@vermax

# For rukmasen user (use absolute path due to permission restrictions)
sudo -u rukmasen nix run home-manager -- switch --flake /home/nikhilmaddirala/repos/nix-config#rukmasen@vermax
```

Home-manager enforces that it runs as the target user for security, requiring `sudo -u` when activating for other users.

#### 4c. Login Screen Users and Passwords

Both users are automatically created during `nixos-install` and should appear on the GDM login screen:

- **nikhilmaddirala**: SSH key authentication (no password needed for SSH)
- **rukmasen**: Password authentication for local/desktop login

To change rukmasen's password after installation:

```bash
ssh -A nikhilmaddirala@vermax
sudo passwd rukmasen
```

#### 4d. Selecting a Desktop Session

This system is configured with two desktop environments: GNOME (default) and Hyprland (a tiling window manager). You can choose which one to use at the login screen.

1.  On the GDM login screen, select your user.
2.  Before entering your password, look for a small gear icon (⚙️) in the bottom-right corner of the screen.
3.  Click the gear icon to open the session menu.
4.  Select either "GNOME" or "Hyprland" from the list.
5.  Proceed to log in.

Your choice will be remembered for the next login.

#### 4e. Power Management

Power management is pre-configured for home server use: the system disables suspend/sleep entirely and stays awake for server duties. Display blanking is managed by GNOME settings.

### 6. Optional: Enable SOPS secrets

After first boot stabilizes, enable SOPS for secrets management. SOPS is disabled during initial installation to avoid bootstrap issues. The SSH host key needed for decryption is generated during first boot in `/etc/ssh/`.

#### Current vermax SSH keys

SSH host key:
```
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEJuRIKKEWF5PVvEgzoWTg09JbcqjZvMGYHGn7BahI1H root@vermax
```

Age format (for SOPS):
```
age1xv2amcl5k3v06t0tzejsvrratl89glt56g9l6jthrx7m6trn24aquc02dc
```

#### Setup steps

**Step 1: Add vermax keys to SOPS configuration**

Edit `vars/.sops.yaml` and add the vermax keys to the top of the file:

```yaml
keys:
  # ... existing keys ...
  - &vermax_host_ssh_to_age age1xv2amcl5k3v06t0tzejsvrratl89glt56g9l6jthrx7m6trn24aquc02dc
  - &vermax_host_ssh ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEJuRIKKEWF5PVvEgzoWTg09JbcqjZvMGYHGn7BahI1H root@vermax
```

Then add both keys to the `creation_rules` section:

```yaml
creation_rules:
  - path_regex: secrets\.yaml$
    key_groups:
      - age:
          # ... existing keys ...
          - *vermax_host_ssh
          - *vermax_host_ssh_to_age
```

**Step 2: Re-encrypt secrets to include vermax**

This allows vermax to decrypt the secrets file:

```bash
cd ~/repos/nix-config
sops --config vars/.sops.yaml updatekeys vars/secrets.yaml
```

**Step 3: Enable SOPS in vermax configuration**

Edit `hosts/vermax/configuration.nix` and change line 13:

```nix
# Before:
mySops.enable = lib.mkDefault false;

# After:
mySops.enable = lib.mkDefault true;
```

**Step 4: Commit and deploy**

```bash
git add vars/.sops.yaml hosts/vermax/configuration.nix
git commit -m "Enable SOPS for vermax"
sudo nixos-rebuild switch --flake .#vermax
```

**Step 5: Verify secrets are working**

After rebuild completes:

```bash
# Check that secrets directory exists
ls -la /run/secrets

# Verify secrets are decrypted
sudo ls -la /run/secrets/
sudo ls -la /run/secrets/github/

# Test environment variables are loaded (start new shell)
echo $GITHUB_TOKEN
```

For complete SOPS documentation, see `vars/README.md`.

### 7. Multi-User Flatpak and App Store Experience

The system provides GNOME Software with per-user Flathub remotes for selected users while keeping the primary user fully declarative. The logic lives in `hosts/vermax/gnome.nix`.

#### 7a. Behavior
- System Flatpak is enabled, but the system-wide Flathub remote is removed on boot.
- A per-user Flathub remote is added for `rukmasen` and `guest` (no sudo prompts).
- `nikhilmaddirala` is untouched—no Flathub remote is added unless done manually.
- GNOME remains the default session; Hyprland is still available from the login gear menu.

#### 7b. One-time cleanup (if you added Flathub before)
Run as `nikhilmaddirala`:
```bash
flatpak --user remote-delete flathub || true
flatpak --system remote-delete flathub || true
```

#### 7c. After a `nixos-rebuild switch`
- `rukmasen` / `guest`: `flatpak --user remotes` shows `flathub`; GNOME Software installs per-user apps; Extension Manager/Firefox can add GNOME extensions per-user.
- `nikhilmaddirala`: No Flathub remote; GNOME settings/extensions come from Home Manager.

## Appendix

### Alternative: Remote Installation with nixos-anywhere

If you prefer remote SSH-based installation without needing a USB drive:

```bash
# From your Mac (requires target machine to have SSH access)
nix run github:nix-community/nixos-anywhere -- \
  --flake .#vermax \
  --extra-files /absolute/path/to/ssh/keys \
  root@<target-ip>
```

This automates disk partitioning and NixOS installation remotely. Note: May experience connectivity issues if the target reboots during installation.


### Hardware Reference

Target hardware: Intel N97 NUC with 476GB SSD, wired/wireless networking.
