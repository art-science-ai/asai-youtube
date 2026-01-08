---
tags: [software, tool]
status: active
type: service
---

# Syncthing

> **TL;DR:** Continuous file synchronization program that syncs files between devices in real-time using peer-to-peer architecture without requiring a central server.

## Overview
- **Source:** https://github.com/syncthing/syncthing
- **Category:** Service (File Synchronization)
- **Key Features:**
    - Peer-to-peer sync (no central server required)
    - Real-time continuous synchronization
    - Cross-platform support
    - Web UI for configuration
    - Encrypted transfer
    - Conflict detection and resolution

## Personal context
- **Why / how I am using:**
    - Syncing the unified monorepo across multiple machines (desktop, laptop)
    - Used for cross-machine backup of code + knowledge
    - Git remains for version control and collaboration, Syncthing for sync only
    - Serialized workflow: close one machine before opening another to avoid .git conflicts
    - Local-first architecture appeals to me (no cloud service required)
    - Peer-to-peer model provides no single point of failure
- **Projects / hosts:**
    - **Primary use:** Monorepo synchronization (~/repos/monorepo)
    - **Hosts:** NixOS desktop, macOS laptop (via nix-shell or systemd)

## Setup and configuration
- **Installation (Declarative via Nix):**
    ```bash
    # Add to home.nix or configuration.nix
    services.syncthing.enable = true;
    
    # Rebuild
    sudo nixos-rebuild switch
    ```
- **Configuration:**
    - Web UI: http://localhost:8384
    - Config file: `~/.config/syncthing/config.xml`
    - Monorepo folder: /home/nikhilmaddirala/repos/monorepo
    - .stignore for monorepo:
        ```
        node_modules/
        target/
        dist/
        .sync-conflict-*
        .git/*.lock
        .obsidian/workspace.json
        ```

## Workflows & operations
- **Start Syncthing (NixOS):**
    ```bash
    # Using systemd (autostart on login)
    systemctl --user enable syncthing
    systemctl --user start syncthing
    ```
- **Add Monorepo Folder (Web UI):**
    1. Click "Add Folder"
    2. Folder Path: /home/nikhilmaddirala/repos/monorepo
    3. Folder Label: monorepo
    4. Configure .stignore patterns (see Setup section)
- **Connect Devices for Monorepo Sync:**
    1. On Device A: Web UI → Actions → Show ID → Copy device ID
    2. On Device B: Web UI → Add Remote Device → Paste device ID
    3. On Device A: Accept connection when prompted
    4. On Device B: Add monorepo folder and accept share on Device A
- **Verify Sync Status:**
    - Check web UI for green checkmarks
    - Both machines should show "Up to Date" for monorepo folder
- **Golden Rule (Critical):**
    - Never run Git commands on two machines simultaneously
    - Save/Close Machine A before opening Machine B
    - Prevents .git folder corruption and conflicts

## Alternatives and related tools
- **CouchDB LiveSync:** Real-time simultaneous editing, designed for documents. Future candidate for hybrid approach (knowledge sync via CouchDB, code via Git). Not using now because current serialized workflow is sufficient.
- **Resilio Sync:** More features and native UI, but proprietary and closed-source. Not using due to open-source preference.
- **rsync + cron:** Simple and reliable, but manual and not continuous. No conflict detection. Not using because I want automated sync.
- **Nextcloud/ownCloud:** Self-hosted with more features, but heavier setup. Not using because Syncthing is simpler for my use case.

## References
- [Official Documentation](https://docs.syncthing.net/)
- [GitHub Repository](https://github.com/syncthing/syncthing)
- [Syncthing Forum](https://forum.syncthing.net/)
