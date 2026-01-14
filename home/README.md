# Home Manager Configuration

This document outlines the structure and management of user-specific dotfiles and configurations using Home Manager following the **Pattern 1 — Style B** architecture.

## Home Configuration Overview

The `home/` directory contains self-contained Home Manager configurations for user-host pairs. Each configuration file is independent and imports only the modules it needs, eliminating duplication and keeping files lean and discoverable.

## Architecture: Self-Contained User-Host Pairs

Instead of layering multiple directories, each user-host combination has its own file:

```
home/
├── nikhilmaddirala-meleys.nix        # macOS single-user (dev)
├── nikhilmaddirala-moondancer.nix    # macOS multi-user (dev)
├── nikhilmaddirala-seasmoke.nix      # NixOS server (dev)
├── nikhilmaddirala-vermax.nix        # NixOS desktop (dev)
├── tyrion-seasmoke.nix               # NixOS server (non-dev)
└── aegon-seasmoke.nix                # NixOS server (non-dev)
```

Each file is self-contained and imports only the modules needed for that user-host pair.

## Home Manager Modules

Reusable modules are organized in `modules/home/`:

-   **Base Module** (`base.nix`)
    -   Universal settings for all users (home-manager CLI, unfree packages policy)

-   **Configuration Modules**
    -   `shell-config.nix`: Shell configurations (bash, zsh, starship, direnv)
    -   `cli-tools.nix`: Terminal utilities (fzf, bat, ripgrep, eza, btop, yazi, etc.)
    -   `dev-environment.nix`: Developer tools (neovim, git, tmux, dev languages)
    -   `desktop/`: GUI applications and desktop utilities
    -   `themes/`: Stylix, Catppuccin, fonts, colors, and document tools
    -   `npm-config.nix`: NPM and Node.js configuration

-   **User-Specific Modules**
    -   `auth/`: Authentication and user identity (1Password integration, git config, SSH hosts, editor preferences)
    -   `macos-user-settings.nix`: macOS system preferences (screencapture, Finder, Dock, keyboard, etc.)
    -   `dotfiles-stow.nix`: Stow-style dotfile management for git-tracked configuration files

### Configuration Composition Example

A user-host pair like `nikhilmaddirala-meleys` is composed by importing modules:

```nix
# home/nikhilmaddirala-meleys.nix
{
  imports = [
    ../modules/home/base.nix                    # Universal settings
    ../modules/home/shell-config.nix
    ../modules/home/cli-tools.nix
    ../modules/home/dev-environment.nix
    ../modules/home/desktop
    ../modules/home/themes
    ../modules/home/npm-config.nix
    ../modules/home/auth                        # User-specific auth/identity
    ../modules/home/macos-user-settings.nix    # macOS-specific
  ];

  home.username = "nikhilmaddirala";
  home.homeDirectory = "/Users/nikhilmaddirala";
  home.stateVersion = "23.05";
}
```

For non-developers like `tyrion-seasmoke`, simply omit dev-environment and npm-config:

```nix
# home/tyrion-seasmoke.nix
{
  imports = [
    ../modules/home/base.nix
    ../modules/home/shell-config.nix
    ../modules/home/cli-tools.nix
    ../modules/home/desktop
    ../modules/home/themes.nix
  ];

  home.username = "tyrion";
  home.homeDirectory = "/home/tyrion";
  home.stateVersion = "23.05";

  programs.bash.bashrcExtra = ''
    echo "Welcome, Tyrion. You drink and you know things, but you don't rule here."
  '';
}
```

**Benefits:**
- No duplication: Common settings in modules only
- Clear composition: See exactly what each user imports
- Easy to extend: Add modules without touching existing configs
- Easy to customize: Override only when needed

## Home Management

### Adding a New User

1. Create a new user-host file `home/<username>-<hostname>.nix`
2. Import the base module and any other needed modules from `modules/home/`
3. Set `home.username`, `home.homeDirectory`, and `home.stateVersion`
4. Add any user-specific or host-specific customizations
5. Register the new configuration in `flake.nix` homeConfigurations
6. Run `nix flake check` to validate

Example for a new developer user:
```nix
# home/alice-meleys.nix
{
  imports = [
    ../modules/home/base.nix
    ../modules/home/shell-config.nix
    ../modules/home/cli-tools.nix
    ../modules/home/dev-environment.nix
    ../modules/home/desktop
    ../modules/home/themes
    ../modules/home/npm-config.nix
    ../modules/home/macos-user-settings.nix
  ];

  home.username = "alice";
  home.homeDirectory = "/Users/alice";
  home.stateVersion = "23.05";
}
```

Then add to flake.nix:
```nix
homeConfigurations = {
  "alice@meleys" = home-manager.lib.homeManagerConfiguration {
    pkgs = nixpkgs.legacyPackages.aarch64-darwin;
    modules = [ ./home/alice-meleys.nix ];
  };
};
```

### Modifying Configurations

To apply changes, simply rebuild the target system using the appropriate command for the host OS.

**macOS**

```bash
# Rebuild from local repository
sudo darwin-rebuild switch --flake .#<hostname>
```

**NixOS**

```bash
# Deploy using deploy-rs
nix run github:serokell/deploy-rs .#<hostname>
```

The `home-manager switch` command is automatically handled by the system-level rebuilds.

### Quick Reference: Where to Edit

| Task | Location |
|------|----------|
| Universal home-manager settings | `modules/home/base.nix` |
| Shell aliases for everyone | `modules/home/shell-config.nix` |
| Terminal tools for everyone | `modules/home/cli-tools.nix` |
| Developer tools | `modules/home/dev-environment.nix` |
| nikhilmaddirala's git/SSH config & 1Password | `modules/home/auth/` |
| macOS user preferences | `modules/home/macos-user-settings.nix` |
| Theming and colors | `modules/home/themes/` |
| User-host config for nikhilmaddirala@meleys | `home/nikhilmaddirala-meleys.nix` |
| User-host config for tyrion@seasmoke | `home/tyrion-seasmoke.nix` |

## Appendix: Design Philosophy

- **Explicit over implicit**: Configurations are spelled out in `flake.nix` so it's always clear what exists.
- **4-layer architecture**: Platform → Role → User → Host provides the right amount of abstraction without overcomplicating.
- **Minimal role profiles**: Two roles (developer and minimal) cover most use cases without needing complex registries.
- **Direct module composition**: No YAML parsing or registry logic - just straightforward Nix module imports.
- **Clear naming**: Layer names map to directory structure, making navigation intuitive.
