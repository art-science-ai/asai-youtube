# Hosts

## Overview

### About
- Self-contained machine configurations for macOS (nix-darwin) and NixOS systems
- Each host directory contains all hardware and system-specific settings
- Imported modules provide shared functionality across platforms

### Key features
- Platform-agnostic module imports with conditional darwin/linux loading
- Bootstrap templates for nixos-anywhere deployments
- Per-host service configurations (ports, disks, snapshots)

### Technology / architecture
- **macOS:** nix-darwin with Homebrew integration
- **NixOS:** nixosConfigurations with disko disk management
- **Deployment:** deploy-rs for remote, nixos-anywhere for bootstrap


## User guide

### Host profiles

| Host | Arch | OS | Location | Type | Description | Status |
|------|------|----|----------|------|-------------|--------|
| Meleys | aarch64-darwin | macOS | On-premise | Desktop | Daily driver for dev/work | Archived |
| Moondancer | aarch64-darwin | macOS | On-premise | Desktop | Personal macOS machine | Active |
| Seasmoke | x86_64-linux | NixOS | Cloud | Server | Hosts apps (n8n, Obsidian, HA) | Active |
| Vermax | x86_64-linux | NixOS | On-premise | Desktop | Dev/testing with containers | Active |
| Sheepstealer | x86_64-linux | NixOS | Cloud | Server | Media server (qbittorrent, Jellyfin) | Planned |

### Usage examples

```bash
# macOS (nix-darwin)
just darwin moondancer
# or: darwin-rebuild switch --flake ~/.config/dragonix#moondancer

# NixOS local
just nixos vermax
# or: nixos-rebuild switch --flake ~/.config/dragonix#vermax

# NixOS remote (via deploy-rs)
just nixos-ssh seasmoke
```

### Configuration
Each host directory contains:
- `default.nix` - Entry point that imports modules and sets options
- `configuration.nix` - Host-specific system configuration
- `disk-config.nix` - Disk partitioning (NixOS, uses disko)
- `hardware-configuration.nix` - Auto-generated hardware settings (NixOS)

Optional host-specific files:
- `ports.nix` - Port mappings for services
- `snapper.nix` - Btrfs snapshot configuration
- `hibernate.nix` - Hibernate/suspend settings


## Developer guide

### Directory map
```
hosts/
├── _nixos-anywhere-template/   # Bootstrap template for new NixOS installs
├── meleys/                     # macOS mini-pro (archived)
├── moondancer/                 # macOS air (active)
├── seasmoke/                   # NixOS cloud server (active)
│   ├── dev/                    # Development services
│   └── prod/                   # Production services
└── vermax/                     # NixOS desktop mini-PC (active)
    ├── jellyfin/               # Media server config
    ├── obsidian/               # Obsidian sync
    └── remote-desktop/         # RDP/RustDesk/Sunshine
```

### Adding a new host

1. Create host directory with entry point:
   ```nix
   # hosts/<hostname>/default.nix
   { config, lib, ... }:
   {
     imports = [
       ./configuration.nix
       ../../modules/hosts/base
       ../../modules/hosts/nix-settings
       ../../modules/hosts/sops
       ../../modules/hosts/users-shells
       # Platform-specific:
       ../../modules/hosts/nixos-server  # or nixos-desktop, darwin-desktop
     ];
   }
   ```

2. Add to `flake.nix` under appropriate configuration type

3. Create user home config in `home/<username>-<hostname>.nix`

4. Validate: `just nh-check`

### Bootstrapping NixOS hosts

For new NixOS servers, use nixos-anywhere with the template:
- See `_nixos-anywhere-template/quickstart.md` for step-by-step instructions
- Each host has a `_nixos-anywhere-*` subdirectory with bootstrap-specific docs

For non-NixOS systems:
1. Install Nix (vanilla or Determinate Systems installer)
2. Clone repo and symlink: `ln -s ~/repos/dragonix ~/.config/dragonix`
3. Generate SSH keys
4. Apply configuration


## References

- [vermax/README.md](vermax/README.md) - Storage architecture, snapper, multi-user setup
- [_nixos-anywhere-template/](_nixos-anywhere-template/) - Bootstrap template with quickstart guide
- [../modules/hosts/](../modules/hosts/) - System modules imported by hosts


## Appendix

### Quick reference

| Task | Location |
|------|----------|
| Add host | `hosts/<hostname>/default.nix` + `flake.nix` |
| Modify host config | `hosts/<hostname>/configuration.nix` |
| Add user to host | `modules/hosts/users-shells/` + `home/<user>-<host>.nix` |
| Change disk layout | `hosts/<hostname>/disk-config.nix` |
| Platform modules | `modules/hosts/darwin-desktop/` or `modules/hosts/nixos-*/` |

### Multi-user macOS

macOS hosts separate system from user configuration:
- **System:** nix-darwin manages system settings, shared Homebrew
- **User:** home-manager manages per-user packages and dotfiles
- Primary user manages system configuration; secondary users are home-manager only
