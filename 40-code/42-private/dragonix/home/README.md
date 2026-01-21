# Home

## Overview

### About
- Self-contained Home Manager configurations for user-host pairs
- Each file represents a unique user on a specific machine
- Enables different users on the same host to have distinct configurations

### Key features
- User-host pair naming convention: `<username>-<hostname>.nix`
- Module composition via imports from `modules/home/`
- Desktop vs server distinction via `isDesktop` flag

### Technology / architecture
- **Core:** Home Manager with Nix flakes
- **Pattern:** Self-contained files importing shared modules
- **Identity:** username, homeDirectory, stateVersion per config


## User guide

### User configurations

| File | User | Host | Platform | Notes |
|------|------|------|----------|-------|
| `nikhilmaddirala-vermax.nix` | nikhilmaddirala | vermax | NixOS desktop | Primary dev environment |
| `nikhilmaddirala-moondancer.nix` | nikhilmaddirala | moondancer | macOS | Personal laptop |
| `nikhilmaddirala-seasmoke.nix` | nikhilmaddirala | seasmoke | NixOS server | Headless server |
| `nikhilmaddirala-meleys.nix` | nikhilmaddirala | meleys | macOS | Archived |
| `tyrion-seasmoke.nix` | tyrion | seasmoke | NixOS server | Secondary user |
| `aegon-seasmoke.nix` | aegon | seasmoke | NixOS server | Secondary user |
| `rukmasen-vermax.nix` | rukmasen | vermax | NixOS desktop | Secondary user |
| `guest-vermax.nix` | guest | vermax | NixOS desktop | Guest access |

### Usage examples

```bash
# Switch home-manager configuration (auto-detects user@host)
just nh-home

# Or specify explicitly
home-manager switch --flake ~/.config/dragonix#nikhilmaddirala-vermax
```

### Configuration

Desktop vs server configurations:
```nix
isDesktop = true;   # Enables GUI apps, window managers
isDesktop = false;  # Minimal CLI-only configuration
```


## Developer guide

### Configuration structure

Each file follows this pattern:

```nix
# Home configuration for <user>@<host> (<platform>)
{ config, pkgs, lib, inputs, ... }:
{
  imports = [
    ../modules/home/base.nix        # Required: universal settings
    ../modules/home/auth            # SSH, 1Password, git auth
    ../modules/home/cli             # Shell tools (fzf, bat, ripgrep, eza)
    ../modules/home/terminal        # Terminal emulators (WezTerm, tmux)
    ../modules/home/themes          # Stylix, Catppuccin, fonts
    # Optional desktop modules:
    ../modules/home/browsing        # Firefox, Zen browser
    ../modules/home/desktop-apps    # Obsidian, messaging
    ../modules/home/ide             # Neovim, VSCode
    ../modules/home/ai              # Claude, Gemini, voice tools
    ../modules/home/window-managers # Hyprland, Niri
    ../modules/home/keyboard        # Kanata, keybindings
  ];

  # Identity
  home.username = "<username>";
  home.homeDirectory = "/home/<username>";  # /Users/<username> on macOS
  home.stateVersion = "23.05";

  # Host-specific options
  isDesktop = true;
}
```

### Adding a new user

1. Create the configuration file:
   ```bash
   cp nikhilmaddirala-vermax.nix <newuser>-<host>.nix
   ```

2. Update identity and imports:
   ```nix
   home.username = "<newuser>";
   home.homeDirectory = "/home/<newuser>";
   # Adjust imports based on user needs
   ```

3. Define the user in system configuration:
   - Add user to `modules/hosts/users-shells/users-shells.nix`
   - Enable user in the host's `configuration.nix`

4. Add to `flake.nix` under `homeConfigurations`:
   ```nix
   "<newuser>-<host>" = home-manager.lib.homeManagerConfiguration {
     pkgs = pkgsFor.<system>;
     extraSpecialArgs = { inherit inputs; };
     modules = [ ./home/<newuser>-<host>.nix ];
   };
   ```

5. Validate and apply:
   ```bash
   just nh-check
   just nh-home
   ```


## References

- [../modules/home/](../modules/home/) - Available home-manager modules
- [../modules/home/ai/README.md](../modules/home/ai/README.md) - AI tools configuration


## Appendix

### Available modules

| Module | Purpose | Desktop only |
|--------|---------|--------------|
| `base.nix` | Universal settings, allowUnfree | No |
| `ai/` | Claude Code, Gemini, nerd-dictation | Partial |
| `auth/` | SSH, 1Password, git credentials | No |
| `browsing/` | Firefox, Zen browser, finicky | Yes |
| `cli/` | fzf, bat, ripgrep, eza, btop, yazi, just | No |
| `cloud-storage/` | Syncthing, Google Drive | No |
| `desktop-apps/` | Obsidian, messaging apps | Yes |
| `ide/` | Neovim (nixvim), VSCode | Partial |
| `keyboard/` | Kanata remapping, keybindings | Yes |
| `terminal/` | WezTerm, tmux, Zellij | No |
| `themes/` | Stylix theming, Catppuccin, fonts | Partial |
| `window-managers/` | Hyprland, Niri | Yes |
