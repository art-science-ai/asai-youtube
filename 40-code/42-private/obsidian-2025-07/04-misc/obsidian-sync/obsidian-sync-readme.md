- Current state
	- Obsidian desktop app on multiple machines
	- Use github for sync and version control
	- Mobile app - not yet implemented due to complexity of sync - github sync doesn't work great on ios
- Desired state
	- Obsidian seamlessly syncs between multiple desktop and mobile devices using [vrtmrz/obsidian-livesync](https://github.com/vrtmrz/obsidian-livesync)
	- **Web Access**: Access the full Obsidian desktop interface via a web browser from any device (hosted on a Linux server).
- Questions / decisions
	- Can I still use git for version control together with livesync?
		- **Yes**, but with caveats.
		- **Do not sync simultaneously**: Disable auto-pull/push on Obsidian Git if LiveSync is active to avoid conflicts.
		- **Configuration**: Exclude LiveSync data from Git via `.gitignore` (e.g., `.obsidian/plugins/obsidian-livesync/`).
		- **Workflow**: Use LiveSync for real-time synchronization across devices and Git for version history/backup on a primary device.
	- Which container for web access?
		- **Recommendation**: `sytone/obsidian-remote`. It provides a complete "desktop-in-browser" experience using KasmVNC out of the box, whereas other images are just the application base.

## Implementation Plan

### Phase 1: Preparation
- [ ] **Backup**: Create a full backup of the current Obsidian vault.
- [ ] **Clean up**: Ensure the vault is in a clean state (git committed).
- [ ] **Git Configuration**: Update `.gitignore` to exclude LiveSync specific files to prevent noise and conflicts.
    ```gitignore
    .obsidian/plugins/obsidian-livesync/
    .obsidian/plugins/obsidian-livesync/data.json
    ```

### Phase 2: Server Infrastructure (Linux Server)
- [ ] **Docker Compose**: Create a single `docker-compose.yml` managing both services.
    - **Service 1: Sync Backend (CouchDB)**
        - Image: `oleduc/docker-obsidian-livesync-couchdb` (Pre-configured for LiveSync)
        - Ports: `5984:5984`
        - Volumes: Data persistence.
        - Environment: Admin credentials.
    - **Service 2: Web Client (Obsidian Remote)**
        - Image: `sytone/obsidian-remote`
        - Ports: `3000:3000` (Web Interface)
        - Volumes: Config folder for persistence.
        - **Note**: This instance will act as just another "client" that needs to be synced.
- [ ] **Deploy**: Run `docker compose up -d` on the Linux server.
- [ ] **Reverse Proxy (Optional but Recommended)**: Set up Nginx/Traefik with SSL (Let's Encrypt) to securely access both the Sync Endpoint and the Web Interface remotely.

### Phase 3: Sync Backend Configuration
- [ ] **Initialize CouchDB**:
    - Access `http://your-server-ip:5984/_utils`.
    - Create database `obsidian`.
    - Create a dedicated sync user.
    - **Note**: The `oleduc` image handles most `local.ini` tweaks automatically.

### Phase 4: Web Client Setup (The "Browser" Device)
- [ ] **Access**: Open `http://your-server-ip:3000` in a browser.
- [ ] **Setup**: You will see the Obsidian interface.
- [ ] **Install Plugin**: Install "Self-hosted LiveSync".
- [ ] **Connect**: Connect it to the CouchDB instance running in the *same* Docker stack (use the service name `couchdb` as the host, e.g., `http://couchdb:5984`).
- [ ] **Sync**: This instance now stays always-on and synced.

### Phase 5: Local Devices (Desktop & Mobile)
- [ ] **Desktop (Mac)**: Connect to the remote server `http://your-server-ip:5984`.
- [ ] **Mobile (iOS)**: Connect using the Setup URI generated from the Desktop or Web instance.

## References
- [vrtmrz/obsidian-livesync](https://github.com/vrtmrz/obsidian-livesync)
- [oleduc/docker-obsidian-livesync-couchdb: A docker container for the CouchDB instance required by obsidian-livesync](https://github.com/oleduc/docker-obsidian-livesync-couchdb)
- [sytone/obsidian-remote: Run Obsidian.md in a browser via a docker container.](https://github.com/sytone/obsidian-remote)
- [linuxserver/docker-obsidian](https://github.com/linuxserver/docker-obsidian)