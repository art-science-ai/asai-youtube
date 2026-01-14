# Obsidian Sync on Vermax

## Overview
- Current state
  - Obsidian desktop app on multiple machines
  - GitHub used for sync and version control
  - Mobile app not yet implemented (GitHub sync is poor on iOS)
- Desired state
  - Seamless sync across desktop and mobile via [vrtmrz/obsidian-livesync](https://github.com/vrtmrz/obsidian-livesync)
  - Optional web access to the full desktop UI from a browser

## Status
- LiveSync backend is implemented on `vermax` using NixOS `services.couchdb`.
- Web access setup is pending.

## Server configuration (vermax)

Config: `hosts/vermax/obsidian/obsidian-livesync.nix`

CouchDB (NixOS service)
- Bind: `0.0.0.0:5984` (LAN)
- Data: `/var/lib/couchdb` (currently on @root subvolume)
- View index: `/var/lib/couchdb`
- Config: `/var/lib/couchdb/local.ini`
- Admin: `admin` / `admin`
- LiveSync user: `livesync` / `livesync`
- Config mirrors upstream LiveSync init (auth, CORS, size limits, single-node)

Init service: `obsidian-livesync-init.service` (creates system DBs + `obsidian`, LiveSync user, and DB security; no external scripts)

### Data persistence note

Currently impermanence is disabled, so CouchDB data persists normally in /var/lib/couchdb.

When impermanence is re-enabled in the future:
- CouchDB data must be added to impermanence.nix to survive reboots
- Add `/var/lib/couchdb` to the `environment.persistence."/persist".directories` list
- This moves data to @persist subvolume which is backed up by Snapper
- See main README for directory structure standards

## Setup instructions

### 0) If the old container is still running
If you previously ran the Podman container, stop and remove it so it does not conflict:
```bash
sudo systemctl disable --now podman-obsidian-livesync.service
sudo podman rm -f obsidian-livesync
```

### 1) Apply config
```bash
sudo nixos-rebuild switch --flake .#vermax
```

### 2) Verify CouchDB is running
```bash
systemctl status couchdb.service
```
CouchDB should be listening on `http://<vermax-ip>:5984`.

### 3) Initialize CouchDB (required)
Initialization is handled by a NixOS oneshot service (generated locally, no external scripts) that creates the required system databases and the `obsidian` database.
```bash
systemctl status obsidian-livesync-init.service
```
If it has not run yet (or you want to re-run it):
```bash
sudo systemctl start obsidian-livesync-init.service
sudo journalctl -u obsidian-livesync-init.service -n 50
```

### 4) Generate a LiveSync Setup URI (recommended)
Generate the following passphrase and save it in your password manager first:
- E2EE passphrase: This encrypts your vault data (required, you choose this)
- Setup URI passphrase: This encrypts the setup URI itself (optional, auto-generated if not provided)

Run on a desktop device or the server (requires `deno`).
```bash
# Optional: set a specific setup-URI passphrase (uncomment if needed)
# export uri_passphrase=<your-setup-uri-passphrase> && \

export hostname=http://vermax:5984 && \
export database=obsidian && \
export passphrase=civic-han-honors && \
export username=livesync && \
export password=livesync && \
nix shell nixpkgs#deno -c deno run -A https://raw.githubusercontent.com/vrtmrz/obsidian-livesync/main/utils/flyio/generate_setupuri.ts
```
Save the generated `obsidian://setuplivesync?...` URI and the setup-URI passphrase it prints.

### 5) Configure the first device (desktop)
- Install the **Self-hosted LiveSync** plugin.
- Command palette → **Use the copied setup URI**.
- Paste the setup URI and enter the setup-URI passphrase.
- Choose to set up as a secondary or subsequent device (recommended path).
- When prompted, reload the app without saving.

### 6) Add additional devices

Use the same setup URI flow on other desktops and mobile devices. To avoid conflicts and ensure clean setup, it is recommended to create a fresh Obsidian vault on each new device.

#### For new desktop devices:
1. Create a new empty folder for your vault (e.g., `~/Documents/Obsidian`)
2. Open Obsidian and select "Create new vault" pointing to this folder
3. Install the **Self-hosted LiveSync** plugin from the community plugins settings
4. Enable the plugin
5. Command palette → **Use the copied setup URI**
6. Paste the setup URI from step 4
7. Enter the setup-URI passphrase (same one generated for all devices)
8. Choose to set up as a secondary or subsequent device
9. LiveSync will automatically pull all vault content from the server
10. When prompted, reload the app without saving

#### For mobile devices (iOS/Android):
1. Install Obsidian from the App Store/Google Play
2. Create a new vault (you can name it anything)
3. Enable community plugins in settings
4. Install and enable **Self-hosted LiveSync**
5. Command palette → **Use the copied setup URI**
6. Paste the setup URI and enter the setup-URI passphrase
7. Choose secondary/subsequent device setup
8. LiveSync will sync all content automatically

#### Important notes:
- All devices must use the same setup URI and setup-URI passphrase
- The E2EE passphrase should be stored in your password manager for recovery
- LiveSync handles all file synchronization - no need to manually copy files
- The vault structure will be replicated across all devices automatically

#### Should we exclude .git from LiveSync?
Yes, you should exclude the `.git` directory from LiveSync. Here is why:
- LiveSync is designed to sync vault content (Markdown files, attachments, etc.)
- The `.git` directory contains version control metadata that should not be synced
- Having multiple devices sync the same `.git` folder can cause conflicts and corruption
- Git operations (commits, branches) should be performed on a single device (the primary)

Recommended exclusions in LiveSync settings:
- `.git/` - entire Git repository
- `.obsidian/plugins/obsidian-livesync/` - LiveSync plugin data (already excluded)
- `.obsidian/workspace` - per-device workspace settings

Add these to LiveSync plugin settings under "Exclude files" or use the ignore patterns feature.

## Notes
- Git + LiveSync can co-exist with constraints:
  - Do not sync simultaneously (disable Obsidian Git auto pull/push when LiveSync is active).
  - Exclude LiveSync plugin data in `.gitignore` (see below).
  - Use LiveSync for realtime sync; use Git for history/backup on a primary device.
- LAN-only is fine for desktop devices.
- Admin credentials are only for maintenance (Fauxton/UI); devices should use the `livesync` user.
- For mobile (especially iOS), LiveSync requires HTTPS with a valid certificate.

## Git Ignore
```gitignore
.obsidian/plugins/obsidian-livesync/
.obsidian/plugins/obsidian-livesync/data.json
```

## Future work
- Web access via `sytone/obsidian-remote` (deferred).
- Reverse proxy + TLS for mobile access.

## References
- [LiveSync README](https://github.com/vrtmrz/obsidian-livesync?tab=readme-ov-file)
- [Setup your own server](https://github.com/vrtmrz/obsidian-livesync/blob/main/docs/setup_own_server.md)
- [Quick setup](https://github.com/vrtmrz/obsidian-livesync/blob/main/docs/quick_setup.md)
- [sytone/obsidian-remote](https://github.com/sytone/obsidian-remote)
- [linuxserver/docker-obsidian](https://github.com/linuxserver/docker-obsidian)
