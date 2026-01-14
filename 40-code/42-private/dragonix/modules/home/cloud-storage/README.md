# Cloud Storage Module

This module provides cloud storage and file synchronization services via Home Manager.

## Architecture: Declarative vs Imperative

This module uses a hybrid approach:

- **Syncthing:** Mostly declarative (folder structure, ignore patterns) with imperative device pairing
- **Google Drive:** Fully imperative (OAuth tokens are runtime state that cannot be managed declaratively)

**Why this split?**
- Syncthing stores its state in a separate database, keeping config files pure
- rclone writes OAuth tokens directly to config files, which conflicts with Home Manager's declarative model
- See [Home Manager Issue #8334](https://github.com/nix-community/home-manager/issues/8334)

## Components

### Syncthing (all platforms)

Continuous file synchronization using peer-to-peer architecture. Enabled on all hosts (vermax, seasmoke, meleys, moondancer).

**Configuration:** `syncthing.nix`

**Features:**
- User service via Home Manager (runs as your user, not root)
- Automatically starts after configuration changes
- Monorepo folder declaratively configured
- Cross-platform support (NixOS and macOS)

**Web UI:** http://127.0.0.1:8384

### Google Drive (Linux only)

Google Drive integration using rclone. Only enabled on Linux systems (NixOS).

**Configuration:** `google-drive.nix`

**Features:**
- Mounts Google Drive to `~/GDrive`
- VFS caching for improved performance
- OAuth authentication via browser
- Systemd user service managed by Home Manager (imperative rclone config)

## Google Drive Setup (Fully Imperative)

### Overview

**Declarative (via Home Manager):**
- rclone package installation
- systemd user service definition

**Imperative (manual setup):**
- rclone remote configuration
- OAuth authentication (one-time)

Why? rclone writes OAuth tokens to `~/.config/rclone/rclone.conf` as runtime state. Home Manager cannot manage these tokens declaratively.

### Step 1: Create rclone remote (one-time, per machine)

Run `rclone config` and follow the prompts:

```bash
rclone config
```

1. **New remote:** `n` (new remote)
2. **Name:** `gdrive`
3. **Storage type:** `drive` (Google Drive)
4. **client_id:** Leave blank (uses rclone's default)
5. **client_secret:** Leave blank (uses rclone's default)
6. **scope:** `drive` (Full access to all files)
7. **root_folder_id:** Leave blank
8. **service_account_file:** Leave blank
9. **Edit advanced config:** `n`
10. **Use web browser for auth:** `y`
    - Browser opens for Google OAuth
    - Grant permissions to rclone
11. **Shared Drive (Team Drive):** `n`
12. **Quit config:** `q`

Result: OAuth tokens are saved to `~/.config/rclone/rclone.conf`

### Step 2: Apply Home Manager configuration

```bash
# NixOS
sudo nixos-rebuild switch

# macOS
home-manager switch
```

This enables and starts the `rclone-gdrive` systemd user service.

### Mount Configuration

The systemd service uses these settings (defined in `google-drive.nix`):

| Setting | Value | Purpose |
|---------|-------|---------|
| **Mount point** | `~/GDrive` | Root of Google Drive |
| **Log level** | INFO | Standard logging |
| **VFS cache mode** | full | Caches files and metadata locally |
| **VFS cache max age** | 24h | Cache expiration time |
| **VFS cache max size** | 10G | Maximum cache size |
| **VFS read ahead** | 128M | Pre-read buffer for streaming |

**Why these settings?**
- `vfs-cache-mode full`: Required for Google Drive to handle file operations reliably
- `vfs-read-ahead 128M`: Improves performance for media files and large documents
- `vfs-cache-max-size 10G`: Balances disk usage with performance for frequently accessed files

### Step 3: Verification

```bash
# Check mount
ls ~/GDrive

# Check service status
systemctl --user status rclone-gdrive

# View logs
journalctl --user -u rclone-gdrive -f
```

## Syncthing Setup (Hybrid)

### Overview

**Declarative (via Home Manager):**
- Folder structure (paths, labels)
- Ignore patterns
- Service management

**Imperative (via Web UI):**
- Device discovery and pairing
- Accepting device connections
- Optional: Device ID capture for future declarative config

Why? Device IDs are discovered at runtime and require manual acceptance. After initial pairing, you can optionally make device connections declarative.

### Step 1: Apply configuration on all hosts

**Declarative step** - Apply the Nix configuration:

```bash
# NixOS
sudo nixos-rebuild switch

# macOS
home-manager switch
```

Syncthing starts automatically. The monorepo folder is pre-configured with:

- **Path:** `~/repos/monorepo`
- **Label:** `monorepo`
- **Ignore patterns:**
  - `node_modules/` - Node.js dependencies
  - `target/` - Rust build artifacts
  - `dist/` - Distribution builds
  - `.sync-conflict-*` - Syncthing conflict files
  - `.git/*.lock` - Git lock files
  - `.obsidian/workspace.json` - Obsidian workspace settings (machine-specific)

### Step 2: Access Web UI on each device

**Imperative step** - Access the Syncthing web interface:

1. Open browser: http://127.0.0.1:8384
2. Repeat on each device (vermax, seasmoke, meleys, moondancer)

### Step 3: Get device IDs

**Imperative step** - Discover and copy device IDs:

On each device:
1. Web UI → Actions → Show ID
2. Copy the device ID (looks like: `P56IOI7-MZJNU2Y-IQGDREY-DM2MGTI-MGL3BXN-PQ6W5BM-TBBZ4TJ-XZWICQ2`)

### Step 4: Pair devices via Web UI

**Imperative step** - Establish connections between devices:

For each pair of devices (A and B):
1. On Device A's Web UI: Add Remote Device → Paste Device B's ID
2. On Device B's Web UI: Accept the connection request when prompted
3. Repeat for all device pairs

After pairing, the monorepo folder will automatically be shared between connected devices.

### Step 5: Optional - Make device pairing declarative

Once all devices are paired, you can optionally capture device IDs to make future setup fully declarative.

**Why this is optional:** Device pairing is a one-time operation. Making it declarative is useful for:
- Quick device recovery/reinstallation
- Documentation of your sync topology
- Preventing accidental device disconnections

Update `syncthing.nix` to include discovered device IDs:

```nix
settings = {
  devices = {
    "vermax" = { id = "DEVICE-ID-VERMAX"; };
    "seasmoke" = { id = "DEVICE-ID-SEASMOKE"; };
    "meleys" = { id = "DEVICE-ID-MELEYS"; };
    "moondancer" = { id = "DEVICE-ID-MOONDANCER"; };
  };

  folders = {
    "monorepo" = {
      path = "${config.home.homeDirectory}/repos/monorepo";
      label = "monorepo";
      ignorePatterns = [ ... ];
      devices = [ "vermax" "seasmoke" "meleys" "moondancer" ];
    };
  };
};
```

### Important: Git Safety

**Golden Rule:** Never run Git commands on two machines simultaneously.

Save/close work on one machine before opening on another to prevent:
- `.git` folder corruption
- Conflicting object writes
- Lost commits

Syncthing synchronizes `.git` files, but Git is not designed for concurrent repository access from multiple machines.

## Verification

### Syncthing
```bash
# Check service status (NixOS)
systemctl --user status syncthing

# Check Web UI accessibility
curl -I http://127.0.0.1:8384
```

### Google Drive
```bash
# Check mount
ls ~/GDrive

# Check rclone service
systemctl --user status rclone-gdrive
```

## References

- [Syncthing Documentation](https://docs.syncthing.net/)
- [NixOS Wiki - Syncthing](https://wiki.nixos.org/wiki/Syncthing)
- [Home Manager - Syncthing Options](https://mynixos.com/home-manager/options/services.syncthing)
- [Project Syncthing Docs](/home/nikhilmaddirala/repos/monorepo/00-inbox/syncthing.md)
- [Rclone Documentation](https://rclone.org/)
