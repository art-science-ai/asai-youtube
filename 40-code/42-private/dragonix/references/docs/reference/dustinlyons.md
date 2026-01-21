# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is Dustin Lyons' general-purpose Nix configuration for both macOS (via nix-darwin) and NixOS. It provides a complete, declarative development environment with consistent tooling across platforms. The configuration emphasizes simplicity, readability, and practical daily use.

## Architecture

**Flake Structure**: Uses Nix flakes with clearly separated concerns:
- `flake.nix` - Main entry point with inputs, outputs, and system configurations
- `hosts/` - Platform-specific host configurations (darwin, nixos)
- `modules/` - Modular configuration split by platform and shared components
- `apps/` - Executable scripts for system management operations
- `templates/` - Starter templates for new users (with/without secrets)
- `overlays/` - Nix package overlays for custom package modifications

**Platform Support**: Configurations for both x86_64 and aarch64 on Darwin and Linux systems.

**Module System**: Three-tier module organization:
- `modules/shared/` - Cross-platform packages and configurations
- `modules/darwin/` - macOS-specific modules (dock, casks, etc.)
- `modules/nixos/` - Linux-specific modules (window manager, display, etc.)

**Home Manager Integration**: Built-in home-manager configuration for user-level settings without requiring separate CLI steps.

## Essential Commands

### Daily Development Workflow

**macOS Systems**:
```bash
# Build without switching (test configuration)
nix run .#build

# Build and switch to new generation  
nix run .#build-switch

# Apply configuration changes (includes user info setup)
nix run .#apply

# Rollback to previous generation
nix run .#rollback
```

**NixOS Systems**:
```bash
# Build and switch to new generation
nix run .#build-switch

# Apply configuration changes
nix run .#apply
```

### Secrets Management (if using starter-with-secrets template)

```bash
# Create/copy SSH keys for secrets access
nix run .#create-keys
nix run .#copy-keys  # from USB drive
nix run .#check-keys # verify keys are properly installed

# Edit secrets (requires agenix setup)
nix run github:ryantm/agenix -- -e <secret>.age
```

### Installation Commands

**macOS Installation**:
```bash
# Initialize starter template (simple)
mkdir -p nixos-config && cd nixos-config && nix flake init -t github:dustinlyons/nixos-config#starter

# Initialize with secrets support
mkdir -p nixos-config && cd nixos-config && nix flake init -t github:dustinlyons/nixos-config#starter-with-secrets

# Make apps executable
find apps/$(uname -m | sed 's/arm64/aarch64/')-darwin -type f -exec chmod +x {} \;
```

**NixOS Installation**:
```bash
# Simple installation
sudo nix run --extra-experimental-features 'nix-command flakes' github:dustinlyons/nixos-config#install

# Installation with secrets
sudo nix run --extra-experimental-features 'nix-command flakes' github:dustinlyons/nixos-config#install-with-secrets
```

## Configuration Structure

### Package Management
- **Shared packages**: `modules/shared/packages.nix` - Cross-platform development tools
- **Darwin packages**: `modules/darwin/packages.nix` - macOS-specific additions  
- **Casks**: `modules/darwin/casks.nix` - macOS applications via Homebrew casks
- **Custom packages**: Python/PHP environments with specific packages in shared/packages.nix

### Key Technologies
- **Secrets**: agenix for age-encrypted secrets management
- **Disk Management**: disko for declarative disk partitioning (NixOS)
- **Homebrew**: nix-homebrew for managed macOS package ecosystem
- **Editor**: Emacs with extensive literate configuration in `modules/shared/config/emacs/`
- **Shell**: Zsh with Powerlevel10k theme and extensive aliases/functions
- **Terminal**: Alacritty with consistent theming across platforms

### System Apps Architecture
Apps in `apps/` directory are platform-specific executable scripts that:
- Use the `mkApp` function from flake.nix to create proper Nix applications
- Are organized by system architecture (aarch64-darwin, x86_64-darwin, etc.)
- Handle system-specific operations like building, switching, and key management
- Include interactive user setup (apply script) for initial configuration

## Development Patterns

### Making Changes
1. Edit configuration files in modules/
2. For macOS: `nix run .#build` (test) then `nix run .#build-switch` (apply)
3. For NixOS: `nix run .#build-switch` (build and apply)
4. Use `nix run .#rollback` to revert if needed

### Adding Packages
- Cross-platform tools: Add to `modules/shared/packages.nix`
- macOS apps: Add to `modules/darwin/casks.nix` for App Store apps
- Custom environments: Follow the myPython/myPHP pattern in shared/packages.nix

### Template System
- `templates/starter/` - Basic configuration without secrets
- `templates/starter-with-secrets/` - Full configuration with agenix secrets
- Templates are used by new users via `nix flake init`

### Secrets Workflow (Advanced)
1. Create private GitHub repo for secrets storage
2. Generate age keys with create-keys or copy-keys
3. Configure secrets.nix in your secrets repo
4. Edit secrets with `nix run github:ryantm/agenix`
5. Reference secrets in Nix configuration files

## Testing and Development

### Quick Package Testing
```bash
# Try packages without installing
nix shell nixpkgs#<package-name>

# Development shell with all tools
nix develop
```

### Platform-Specific Notes
- **Cross-platform compatibility**: Uses lib.mkIf for platform-specific settings
- **Font handling**: Custom font packages in modules/shared/fonts.nix
- **Path management**: Consistent PATH setup across Darwin/Linux in home-manager config
- **SSH configuration**: Platform-aware SSH config paths and key locations