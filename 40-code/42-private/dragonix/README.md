# Dragonix: Declarative Nix Configurations

## Overview

This repository ("dragonix") contains the complete Nix-based configuration for personal systems. It manages macOS (via `nix-darwin`), NixOS servers, and user environments (via `home-manager`), embracing the principles of declarative, reproducible, and version-controlled infrastructure.

Key components:
- **System Configurations**: Declarative setups for each machine (hosts/).
- **User Environments**: Standalone Home Manager configurations for consistent packages, dotfiles (home/).
- **Modules**: Reusable modules for shared functionality (modules/).
- **Secrets**: SOPS-Nix-based encrypted secrets (vars/).
- **Custom Packages/Overlays**: Nix overlays and packages (overlays/, pkgs/).
- **References**: Documentation, scripts, configs, assets (references/).

Core principles: Declarative and reproducible, Infrastructure as Code, GitOps and CI/CD.

### Repository Structure

```
.
├── flake.nix                      # Thin wiring layer (system & user configurations)
├── modules/                       # Reusable modules by system type
│   ├── common/                    # Shared utilities and secrets registry
│   ├── home/                      # Home-manager modules (shell, tools, themes, auth)
│   └── hosts/                     # System modules (base, nix-settings, sops, users-shells, nixos-server/desktop, darwin-desktop)
├── hosts/                         # Self-contained host configurations
│   ├── meleys/                    # macOS single-user (dev)
│   ├── moondancer/                # macOS multi-user (dev)
│   ├── seasmoke/                  # NixOS server (dev/non-dev)
│   └── vermax/                    # NixOS desktop (dev)
├── home/                          # Self-contained user-host pair configurations
│   ├── nikhilmaddirala-meleys.nix
│   ├── nikhilmaddirala-moondancer.nix
│   ├── nikhilmaddirala-seasmoke.nix
│   ├── nikhilmaddirala-vermax.nix
│   ├── tyrion-seasmoke.nix
│   └── aegon-seasmoke.nix
├── vars/                          # SOPS secrets and sensitive config
├── overlays/                      # Custom Nix overlays (e.g., whisper-diarization.nix)
├── pkgs/                          # Custom Nix packages (e.g., whisper-diarization/)
├── references/                    # Docs, scripts, configs, assets
│   ├── docs/                      # Documentation
│   ├── scratchpad/                # Experiments and notes
│   ├── _scripts/                  # Utility scripts
│   ├── tailscale_acl.jsonc        # Tailscale ACL config
│   ├── TODO.md                    # Task list
│   └── wallpapers/                # Wallpaper assets
└── README.md                      # This file
```

### Architecture and Design

#### Core Concepts

- **System Configuration**: Managed via darwinConfigurations (macOS) and nixosConfigurations (NixOS) in flake.nix.
- **User Configuration**: Independent homeConfigurations for user environments.
- **Package Management**: Nix + Homebrew (macOS) + Mac App Store (macOS).
- **Composition Pattern**: Layered imports (platform → role → user → host) ensure minimal duplication and predictable overrides.

#### User-Host Pair Management

Users are defined in modules/hosts/users-shells/; hosts activate via `myUsers.<username>.enable = true`. Home configs use self-contained files (e.g., `nikhilmaddirala-meleys.nix`) with imports and overrides.

#### Philosophy

- Explicit over implicit: All configs listed in flake.nix.
- 4-layer architecture: Platform → Role → User → Host for clear composition.
- Direct module composition: No YAML/registry logic.
- Clear naming: Maps to directory structure.

## Getting Started

### Prerequisites and Setup

Prerequisites: macOS/Linux system, 1Password (for secrets on desktops), GitHub SSH key.

Setup:
1. Clone: `git clone git@github.com:nikhilmaddirala/dragonix.git ~/repos/dragonix && cd ~/repos/dragonix`.
2. Symlink: `ln -s ~/repos/dragonix ~/.config/dragonix`.
3. Install Nix: Use [Determinate Systems Nix Installer](https://github.com/DeterminateSystems/nix-installer) on macOS; pre-installed on NixOS.
4. Apply config:
   - macOS: `sudo darwin-rebuild switch --flake ~/.config/dragonix#<hostname>`.
   - NixOS: `sudo nixos-rebuild switch --flake ~/.config/dragonix#<hostname>` or `nix run github:serokell/deploy-rs .#<hostname>`.

## Configuration

### Host and User Management

#### Host Profiles and Operations

| Host | Architecture | OS | Location | Type | Description | Status |
|------|--------------|----|----------|------|-------------|--------|
| Meleys | aarch64-darwin | macOS | On-premise | Desktop | Daily driver for dev/work. | Archived |
| Moondancer | aarch64-darwin | macOS | On-premise | Desktop | Personal macOS machine. | Active |
| Seasmoke | x86_64-linux | NixOS | Cloud | Server | Hosts apps (n8n, Obsidian, Home Assistant). | Active |
| Vermax | x86_64-linux | NixOS | On-premise | Desktop | Dev/testing with containers. | Active |
| Sheepstealer | x86_64-linux | NixOS | Cloud | Server | Torrenting/media (qbittorrent, Jellyfin). | Active |

Bootstrapping new hosts: Non-NixOS install Nix (vanilla/Determinate), clone repo, generate SSH, apply. NixOS use nixos-anywhere from modules/nixos-anywhere/.

Daily operations: macOS `darwin-rebuild`, NixOS `deploy-rs`.

Adding hosts: Create hosts/<hostname>/default.nix importing needed modules, add to flake.nix, create home files, run `nix flake check`.

Quick reference: Where to edit (table from original hosts/README).

Multi-user macOS: Separates system (nix-darwin, shared Homebrew) from user (home-manager). Primary user manages system; others manual.

#### Home Manager Modules

- **Base**: Universal settings (home-manager, allowUnfree).
- **Configuration**: shell-config (bash/zsh/starship/direnv), cli-tools (fzf/bat/ripgrep/eza/btop/yazi), dev-environment (neovim/git/tmux), desktop/ (GUI apps), themes/ (Stylix/Catppuccin/fonts), npm-config, auth/ (1Password/git/SSH), user-nikhilmaddirala, macos-user-settings, dotfiles-stow.

Composition example:
```nix
# home/nikhilmaddirala-meleys.nix
{
  imports = [
    ../modules/home/base.nix
    ../modules/home/shell-config.nix
    # ... others
  ];
  home.username = "nikhilmaddirala";
  home.homeDirectory = "/Users/nikhilmaddirala";
  home.stateVersion = "24.11";
}
```

Home management: Adding users (create <username>-<hostname>.nix, import modules, set username/homeDirectory/stateVersion), modifying (rebuild host), quick reference table.

#### Modules and Secrets

Modules structure: common/ (shared, secrets registry), home/, hosts/ (base, nix-settings, sops, users-shells, nixos-server/desktop, darwin-desktop).

Platform conditional logic: hosts/ modules use default.nix with lib.optional for darwin/linux imports.

User management: Centralized in modules/hosts/users-shells/; profiles defined, activated per host.

Secrets management: SOPS-Nix with Age encryption via SSH keys. Secrets in vars/secrets.yaml, registry in modules/common/secrets-registry.nix.

Workflows:
- Desktops: Manual Age key setup, edit/add secrets, re-encrypt.
- Servers: Auto-convert SSH host key.
- Adding: Edit vars/secrets.yaml, update registry, rebuild.
- Managing: Edit, remove, re-encrypt; env vars auto-loaded.

Required setup: `export SOPS_AGE_KEY_FILE=~/.config/sops/age/keys.txt`; convert SSH to Age: `echo "ssh-ed25519 ..." | ssh-to-age`.

Best practices: Group secrets (e.g., github/), 0400 perms, test via /run/secrets/.

### Custom Packages and Overlays

Overlays: overlays/ contains custom Nix overlays, e.g., whisper-diarization.nix for audio processing extensions.

Packages: pkgs/ contains custom packages, e.g., whisper-diarization/ for a diarization tool package.

Use these for non-standard software not in Nixpkgs.

## Resources

### Documentation and Assets

Documentation: references/docs/ - comprehensive guides and notes.

Scripts and configs: _scripts/ (utility scripts), tailscale_acl.jsonc (Tailscale ACL), TODO.md (task tracking).

Assets: scratchpad/ (experiments and temporary notes), wallpapers/ (desktop backgrounds).

### Host Details and Infrastructure

Host details: Meleys (archived dev), Seasmoke (active server), etc.

Infrastructure:
- GitHub: Code/CI.
- Cloudflare: DNS.
- Cachix: Binary caches.
- Hetzner: VPS/backups.
- Google Drive: Sync.
- AI APIs: Tools.

References: Docs on topics, reference repos that inspired this setup.

## Future Splitting

If the single README becomes too large, consider splitting sections back into subdir READMEs (e.g., move Host and User Management to hosts/README.md, etc.) and update root to link to them.