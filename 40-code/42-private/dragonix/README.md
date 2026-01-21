# Dragonix

## Overview

### About
- Complete Nix-based configuration for personal computing infrastructure
- Manages macOS (nix-darwin), NixOS servers/desktops, and user environments (home-manager)
- Embraces declarative, reproducible, version-controlled infrastructure

### Key features
- Multi-platform support: macOS and NixOS from a single codebase
- User-host pair pattern: Independent configurations per user per machine
- SOPS secrets management: Encrypted secrets with Age/SSH key derivation
- Layered module composition: Platform → Role → User → Host

### Technology / architecture
- **Core:** Nix, Flakes, Home Manager
- **Systems:** nix-darwin (macOS), NixOS (Linux)
- **Secrets:** SOPS-Nix with Age encryption
- **Deployment:** deploy-rs, nixos-anywhere


## User guide

### Quick start
```bash
# Clone and symlink
git clone git@github.com:nikhilmaddirala/dragonix.git ~/repos/dragonix
ln -s ~/repos/dragonix ~/.config/dragonix

# Apply configuration
just darwin <hostname>    # macOS
just nixos <hostname>     # NixOS local
just nixos-ssh <hostname> # NixOS remote
```

### Prerequisites
- macOS or Linux system
- GitHub SSH key configured
- 1Password (for desktop secrets)
- Nix with flakes enabled

### Installation
- **Nix (macOS):** Use [Determinate Systems Nix Installer](https://github.com/DeterminateSystems/nix-installer)
- **Nix (NixOS):** Pre-installed
- **Clone:** `git clone git@github.com:nikhilmaddirala/dragonix.git ~/repos/dragonix`
- **Symlink:** `ln -s ~/repos/dragonix ~/.config/dragonix`

### Configuration
- **Secrets:** Set `SOPS_AGE_KEY_FILE=~/.config/sops/age/keys.txt`
- **Host selection:** Replace `<hostname>` with your machine name (meleys, moondancer, seasmoke, vermax)

### Usage examples
```bash
# Validate all configurations
just nh-check

# Build and switch macOS system
just darwin moondancer

# Build and switch NixOS desktop
just nixos vermax

# Deploy to remote NixOS server
just nixos-ssh seasmoke

# Update all flake inputs
just nh-update
```


## Developer guide

### Developer cheatsheet
- **Check:** `just nh-check` - Validate all flake configurations
- **Build home:** `just nh-home` - Switch home-manager config
- **Build darwin:** `just nh-darwin` - Switch macOS system
- **Build nixos:** `just nh-os` - Switch NixOS system
- **Clean:** `just nh-clean` - Garbage collect nix store
- **Update:** `just nh-update` - Update flake inputs

### Architecture
- **Design pattern:** Layered module composition with platform-conditional imports
- **Composition flow:** Platform (darwin/linux) → Role (desktop/server) → User → Host

### Directory map
| Directory | Purpose | Documentation |
|-----------|---------|---------------|
| [hosts/](hosts/) | Machine configurations | [hosts/README.md](hosts/README.md) |
| [home/](home/) | User-host pair configs | [home/README.md](home/README.md) |
| [modules/](modules/) | Reusable modules | [modules/README.md](modules/README.md) |
| [vars/](vars/) | SOPS secrets | [vars/README.md](vars/README.md) |
| `overlays/` | Custom Nix overlays | - |
| `pkgs/` | Custom Nix packages | - |
| `references/` | Docs, scripts, assets | - |

### Development standards
- **Style:** nixfmt-rfc-style formatting
- **Naming:** camelCase for Nix attributes, kebab-case for files
- **Commits:** Conventional commits with scopes (feat, fix, docs, refactor)
- **Workflow:** Direct commits to main, validation via `just nh-check`

### Contributing guidelines
- **Hosts:** Add new machines in `hosts/<hostname>/` with appropriate module imports
- **Users:** Create user-host pairs in `home/<user>-<host>.nix`
- **Modules:** Add reusable functionality in `modules/home/` or `modules/hosts/`
- **Secrets:** Add encrypted values in `vars/secrets.yaml`, register in `modules/common/secrets-registry.nix`


## References

- [AGENTS.md](AGENTS.md) - AI agent guidelines for this repository
- `references/docs/` - Comprehensive guides and notes
- `references/_scripts/` - Utility scripts
- `references/TODO.md` - Task tracking


## Appendix

### Infrastructure
- GitHub: Code hosting and CI
- Cloudflare: DNS management
- Hetzner: VPS hosting and backups
- Cachix: Nix binary caches
- Tailscale: VPN mesh networking

### Host summary
| Host | Platform | Type | Status |
|------|----------|------|--------|
| Moondancer | macOS | Desktop | Active |
| Vermax | NixOS | Desktop | Active |
| Seasmoke | NixOS | Server | Active |
| Meleys | macOS | Desktop | Archived |

See [hosts/README.md](hosts/README.md) for detailed host profiles.
