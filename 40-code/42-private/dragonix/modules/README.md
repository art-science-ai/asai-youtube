# Modules

## Overview

### About
- Reusable NixOS and Home Manager modules organized by system type
- Provides shared functionality imported by hosts and home configurations
- Three-layer organization: common, home, hosts

### Key features
- Platform-conditional imports (darwin/linux detection)
- Centralized secrets registry in common/
- Composable modules for flexible configuration

### Technology / architecture
- **Home modules:** Home Manager options and packages
- **Hosts modules:** nix-darwin and NixOS system configuration
- **Pattern:** `lib.optional` for platform-specific imports


## User guide

### Directory map

```
modules/
├── common/                    # Shared utilities
│   └── secrets-registry.nix   # Centralized SOPS secrets definitions
├── home/                      # Home Manager modules (user environments)
│   ├── base.nix               # Universal home-manager settings
│   ├── ai/                    # Claude, Gemini, voice dictation
│   ├── auth/                  # SSH, 1Password, git auth
│   ├── browsing/              # Firefox, Zen browser
│   ├── cli/                   # Shell tools (fzf, bat, ripgrep)
│   ├── cloud-storage/         # Syncthing, Google Drive
│   ├── desktop-apps/          # Obsidian, messaging
│   ├── ide/                   # Neovim, VSCode
│   ├── keyboard/              # Kanata, keybindings
│   ├── terminal/              # WezTerm, tmux, Zellij
│   ├── themes/                # Stylix, Catppuccin, fonts
│   └── window-managers/       # Hyprland, Niri
└── hosts/                     # System modules (nix-darwin, NixOS)
    ├── base/                  # Core system settings
    ├── desktop/               # Desktop environments
    │   ├── darwin/            # Homebrew, macOS settings
    │   └── nixos/             # GNOME, Hyprland, sddm, flatpak
    ├── nix-settings/          # Nix configuration (flakes, caches)
    ├── nixos-server/          # Server-specific modules
    ├── sops/                  # Secrets decryption
    └── users-shells/          # User definitions, shell config
```

### Usage examples

Importing modules in a home configuration:
```nix
# home/nikhilmaddirala-vermax.nix
{
  imports = [
    ../modules/home/base.nix
    ../modules/home/cli
    ../modules/home/terminal
    ../modules/home/ai
  ];
}
```

Importing modules in a host configuration:
```nix
# hosts/vermax/default.nix
{
  imports = [
    ../../modules/hosts/base
    ../../modules/hosts/nix-settings
    ../../modules/hosts/sops
    ../../modules/hosts/users-shells
    ../../modules/hosts/desktop/nixos
  ];
}
```


## Developer guide

### Platform-conditional imports

Modules use platform detection to load the right configuration:

```nix
# modules/hosts/base/default.nix
{ config, lib, system, ... }:
let
  isLinux = lib.hasSuffix "-linux" system;
  isDarwin = lib.hasSuffix "-darwin" system;
in
{
  imports = [
    ./common.nix
  ] ++ lib.optional isDarwin ./darwin.nix
    ++ lib.optional isLinux ./linux.nix;
}
```

This pattern appears in `base/`, `desktop/`, `nix-settings/`, and `sops/`.

### Creating a new module

1. Create directory under appropriate path:
   ```bash
   mkdir -p modules/home/<module-name>
   ```

2. Create `default.nix` with standard structure:
   ```nix
   { config, lib, pkgs, ... }:
   {
     # Options (if needed)
     options.<module-name> = {
       enable = lib.mkEnableOption "module description";
     };

     # Configuration
     config = lib.mkIf config.<module-name>.enable {
       # Module implementation
     };
   }
   ```

3. For platform-specific modules, use the conditional import pattern

4. Import the module in relevant home or hosts configurations

### Module breakdown

#### Hosts modules

| Module | Purpose | Platform |
|--------|---------|----------|
| `base/` | Core system settings, networking, locale | Both |
| `desktop/darwin/` | Homebrew, macOS defaults, Aerospace | macOS |
| `desktop/nixos/` | Display managers, window managers, flatpak | NixOS |
| `nix-settings/` | Flakes, nix-community cache, GC | Both |
| `nixos-server/` | Server-specific services, Tailscale | NixOS |
| `sops/` | SOPS-nix secrets decryption setup | Both |
| `users-shells/` | User accounts, shell configuration | Both |

#### Home modules

| Module | Purpose | Desktop only |
|--------|---------|--------------|
| `base.nix` | Universal settings, allowUnfree | No |
| `ai/` | AI coding assistants and voice tools | Partial |
| `auth/` | SSH, 1Password, git credentials | No |
| `browsing/` | Web browsers | Yes |
| `cli/` | Terminal utilities | No |
| `cloud-storage/` | File sync services | No |
| `desktop-apps/` | GUI applications | Yes |
| `ide/` | Code editors | Partial |
| `keyboard/` | Key remapping | Yes |
| `terminal/` | Terminal emulators | No |
| `themes/` | Visual theming | Partial |
| `window-managers/` | Tiling WMs | Yes |


## References

- [home/ai/README.md](home/ai/README.md) - AI tools configuration
- [home/terminal/README.md](home/terminal/README.md) - Terminal setup
- [home/themes/README.md](home/themes/README.md) - Theming system
- [../home/README.md](../home/README.md) - Home configuration usage
- [../hosts/README.md](../hosts/README.md) - Host configuration usage


## Appendix

### Common module

The `common/secrets-registry.nix` provides centralized secret definitions:

```nix
secretDefinitions = {
  github-token = {
    sopsPath = "github/token";
    filePath = "/run/secrets/github/token";
    envVar = "GITHUB_TOKEN";
    owner = "nikhilmaddirala";
    mode = "0400";
  };
  # ... more secrets
};
```

This ensures consistency between SOPS configuration, file paths, and environment variables across all modules that need secrets access.
