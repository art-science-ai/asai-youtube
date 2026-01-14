# Nix Dragons

## Introduction

This repository contains the complete Nix-based configuration for my personal systems, codenamed "dragons." It manages macOS (via `nix-darwin`), NixOS servers, and user environments (via `home-manager`), embracing the principles of declarative, reproducible, and version-controlled infrastructure.

The key components are:
- **System Configurations**: Declarative setups for each machine.
- **User Environments**: Standalone Home Manager configurations for consistent user-level packages and dotfiles.
- **Dotfiles**: Symlinked configurations for various tools, managed with a combination of Home Manager and Stow.

## Core Principles

- **Declarative and Reproducible**: Every aspect of the system should be defined in code to ensure it can be recreated reliably.
- **Infrastructure as Code**: Treat system configuration as a software project, applying best practices like version control, code review, and automation.
- **GitOps and CI/CD**: Use Git as the single source of truth and automate build/deployment processes.

## Quick Start

### Initial Setup

1. **Clone the repository:**
   ```bash
   git clone git@github.com:nikhilmaddirala/nix-config.git ~/repos/nix-config
   cd ~/repos/nix-config
   ```

2. **Create a symlink for portable paths:**
   ```bash
   ln -s ~/repos/nix-config ~/.config/nix-config
   ```

   This symlink allows all configurations to reference `~/.config/nix-config`, making your setup portable across different machines and directory locations.

3. **Install Nix (if not already installed):**
   - **macOS**: Use the [Determinate Systems Nix Installer](https://github.com/DeterminateSystems/nix-installer)
     ```bash
     curl --proto '=https' --tlsv1.2 -sSf https://install.determinate.systems/nix | sh -s -- install
     ```
   - **NixOS**: The Nix package manager is already installed

4. **Apply the configuration:**
   ```bash
   # macOS
   sudo darwin-rebuild switch --flake ~/.config/nix-config#<hostname>

   # NixOS
   sudo nixos-rebuild switch --flake ~/.config/nix-config#<hostname>
   ```

See the [Host Configuration](hosts/README.md) documentation for detailed installation instructions.

## Repository Structure

The repository follows **Pattern 1 — Style B** architecture, where each host and user file is self-contained. Shared functionality is extracted into reusable modules, and flake.nix acts as thin wiring:

```
.
├── flake.nix                      # Thin wiring layer (system & user configuration)
├── modules/                       # Reusable modules organized by system type
│   ├── nixos/                     # NixOS-specific modules
│   │   ├── base.nix               # Core NixOS settings (nix config, packages, SOPS)
│   │   ├── desktop-environment.nix # GUI environment
│   │   ├── server-core.nix        # Server baseline (SSH, firewall, sudo)
│   │   ├── docker-support.nix     # Container runtime
│   │   └── users.nix              # User account definitions
│   ├── nix-darwin/                # macOS-specific modules
│   │   ├── base.nix               # Core macOS settings
│   │   ├── homebrew.nix           # Homebrew package management
│   │   ├── macos-settings.nix     # System preferences
│   │   └── users.nix              # macOS user definitions
│   ├── home/              # User environment modules
│   │   ├── base.nix               # Universal home settings (home-manager enable, allowUnfree)
│   │   ├── shell-config.nix       # Shell configurations
│   │   ├── cli-tools.nix          # Terminal utilities
│   │   ├── dev-environment.nix    # Developer tools
│   │   ├── desktop/                # GUI applications
│   │   ├── theming.nix            # Visual customization
│   │   ├── npm-config.nix         # Node.js configuration
│   │   ├── user-nikhilmaddirala.nix # User-specific settings
│   │   ├── macos-user-settings.nix # macOS user preferences
│   │   └── dotfiles-stow.nix      # Stow-style dotfile management
│   └── nixos-anywhere/            # NixOS bootstrap templates for bare-metal provisioning
│       ├── README.md              # Bootstrap workflow and instructions
│       ├── template/              # Template for new NixOS hosts
│       └── vermax/                # Vermax-specific bootstrap configuration
├── hosts/                         # Self-contained host configurations
│   ├── meleys/                    # macOS single-user
│   │   └── default.nix
│   ├── moondancer/                # macOS multi-user
│   │   └── default.nix
│   ├── seasmoke/                  # NixOS server with services
│   │   ├── default.nix
│   │   ├── containers/
│   │   ├── services/
│   │   └── hardware-configuration.nix
│   └── vermax/                    # NixOS desktop (Hyprland)
│       ├── default.nix
│       ├── containers.nix
│       └── hardware-configuration.nix
├── home/                          # Self-contained user-host pair configurations
│   ├── nikhilmaddirala-meleys.nix
│   ├── nikhilmaddirala-moondancer.nix
│   ├── nikhilmaddirala-seasmoke.nix
│   ├── nikhilmaddirala-vermax.nix
│   ├── tyrion-seasmoke.nix
│   └── aegon-seasmoke.nix
├── dotfiles/                      # Stow-managed dotfiles
├── references/                    # Documentation, templates, and external references
│   ├── omarchy-archive/           # Archived old configurations
│   └── docs/                      # Documentation directory
├── vars/                          # Secrets and sensitive configuration (SOPS)
└── README.md                      # This file
```

## Architecture Overview

This repository follows **Pattern 1 — Style B**, where:
- Each **host configuration** is self-contained (e.g., `hosts/meleys/default.nix`) and imports only the modules it needs
- Each **user configuration** is self-contained (e.g., `home/nikhilmaddirala-meleys.nix`) and imports only the modules it needs
- **Shared functionality** is extracted into reusable modules (`modules/`)
- **flake.nix** acts as a thin wiring layer that assembles these components

This approach maximizes code reuse without creating complex hierarchies. Adding a new host or user is as simple as creating a new file that imports the appropriate modules.

For detailed information on the architecture, see:
- **Host Configuration**: [hosts/README.md](./hosts/README.md)
- **User Configuration**: [home/README.md](./home/README.md)
- **Vermax (NixOS Desktop)**: [hosts/vermax/README.md](./hosts/vermax/README.md)

## Self-Contained Configuration Pattern

System configurations and home-manager setups are built by composing reusable modules. Each host or user file only imports the modules it needs, keeping configurations lean and discoverable:

### Host Configuration Example

Each host is self-contained and imports only the modules it needs:

```nix
# hosts/meleys/default.nix
{
  imports = [
    ../modules/nix-darwin/base.nix
    ../modules/nix-darwin/homebrew.nix
    ../modules/nix-darwin/macos-settings.nix
    ../modules/nix-darwin/users.nix
  ];

  # Host-specific overrides only
  ids.gids.nixbld = 350;
  environment.variables.PATH = "/opt/facebook/bin:$PATH";
}
```

### User Configuration Example

Each user-host pair is self-contained and imports only the modules it needs:

```nix
# home/nikhilmaddirala-meleys.nix
{
  imports = [
    ../modules/home/base.nix
    ../modules/home/shell-config.nix
    ../modules/home/cli-tools.nix
    ../modules/home/dev-environment.nix
    ../modules/home/desktop
    ../modules/home/theming.nix
    ../modules/home/npm-config.nix
    ../modules/home/user-nikhilmaddirala.nix
    ../modules/home/macos-user-settings.nix
  ];

  home.username = "nikhilmaddirala";
  home.homeDirectory = "/Users/nikhilmaddirala";
  home.stateVersion = "23.05";
}
```

### Import Order Matters: Why This Structure?

Both system and home configurations follow a layered pattern that creates a clear hierarchy of specificity:

1. **Layer 1 (Platform profile)**: Adds platform-specific features. These modules are free to override common-all settings using `lib.mkDefault`, `lib.mkForce`, etc.

2. **Layer 2 (User role)**: Role templates (common-dev or common-nondev) shared across multiple users.

3. **Layer 3 (User-specific)**: Personal tweaks for individual users.

4. **Layer 4 (Host-specific)**: Machine-specific overrides that supersede all previous layers.

This ordering ensures:
- No circular dependencies
- Predictable override behavior
- Easy to trace where a setting comes from
- Minimal duplication of code
- Explicit configurations in flake.nix

### File Naming Convention

Consistent file names across layers make the structure self-documenting:

- `default.nix`: Entry point that imports other modules
- `base.nix`: Core settings (in common dirs) or host-specific overrides (in host dirs)
- `<feature>.nix`: Feature-specific modules (e.g., `homebrew.nix`, `programs.nix`)

### Adding New Configurations

To add a new host or user:

1. Create `hosts/<new-hostname>/default.nix` and import `../common-macos` or `../common-linux`
2. Create `home/hosts/<new-hostname>/default.nix` if host-specific home settings are needed
3. For Home Manager users, add entries to `home/users/user-data.yaml` and `home/users/registry.nix` (no manual `homeConfigurations` entry needed)

The import layering happens automatically through the file structure!

### Management Workflows

The configuration supports independent management of system and user environments using a `justfile`.

#### System Management
```bash
# Build and switch system configurations
just meleys      # macOS system configuration
just seasmoke    # Linux server configuration
```

#### Home Manager (User Environment)
```bash
# Build and switch user configurations independently
just home-meleys     # nikhil@meleys home environment
just home-seasmoke   # nikhil@seasmoke home environment
```

## Dragons

This repository manages the following systems. For detailed descriptions and setup instructions, see [hosts/hosts.md](./hosts/hosts.md).

- **Meleys**: My primary development machine, a MacBook Pro.
- **Seasmoke**: A VPS server for hosting personal applications and services.
- **Sheepstealer**: A seedbox for managing media.

## Dotfiles

Dotfiles are managed using a hybrid approach:
- **Home Manager**: For immutable, declaratively managed configurations.
- **GNU Stow**: For mutable configurations on my main machine, allowing direct editing.

For a detailed explanation of the dotfile management strategy, including special cases for tools like Obsidian, see [dotfiles/dotfiles.md](./dotfiles/dotfiles.md).

## Home Manager

User-specific environments, including packages, programs, and shell configurations, are managed via Home Manager. The setup is modular, allowing for shared settings across all users, with user- and host-specific overrides.

For more details, see [home/home.md](./home/home.md).

## Infrastructure

The primary infrastructure consists of the systems described above. Additionally, the following services are used:
- **GitHub**: For code hosting and CI/CD.
- **Cloudflare**: For DNS management.
- **Nix Binary Caches**: Cachix for storing build artifacts.
- **Hetzner**: For VPS hosting and backup storage.
- **Google Drive**: For file synchronization.
- **AI APIs**: For various AI-powered tools and agents.

## References
- Docs on various topics like installation, setup, etc.
- Reference repos which inspired me
