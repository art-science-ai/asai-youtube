# Shell color configuration analysis

Date: 2025-10-07

## Issues identified

### Problem 1: Bash colors not visible in unconfigured terminals

Bash works fine in WezTerm and Ghostty but colors are not properly visible on unconfigured terminals like default Terminal.app and iTerm2.

### Problem 2: Fish autosuggestion text hard to read

Fish autosuggestions are often too hard to read versus the background color in configured terminals.

## Root causes

### Bash color source

What's setting bash colors:
- Bash has NO built-in color configuration in ~/.bashrc
- ALL bash colors come from Starship prompt (home/common/programs.nix:98-113)
- Starship uses ANSI escape codes with truecolor RGB values
- Starship checks: `if [[ $TERM != "dumb" ]]` then initializes

Why it fails in default Terminal.app and iTerm:
- Starship prompt uses 24-bit truecolor RGB values
- Configured terminals (WezTerm, Ghostty) properly set:
  - `TERM=xterm-256color`
  - `COLORTERM=truecolor`
- Unconfigured terminals may not:
  - Support truecolor properly even with TERM=xterm-256color
  - Have COLORTERM=truecolor set
  - Properly interpret 24-bit color escape sequences

Starship colors used:
```
[1;33m = bold yellow (username)
[1;2;32m = bold dim green (hostname)
[1;36m = bold cyan (directory)
[1;35m = bold magenta (git branch)
```

### Fish color source

What's setting fish colors:
- Fish uses universal variables stored in ~/.local/share/fish/fish_variables
- These are SEPARATE from Nix configuration
- Current state:
  - `fish_color_autosuggestion` is EMPTY (0 elements)
  - `fish_color_comment = 313244` (RGB: 49,50,68 - very dark gray)
  - `fish_color_param = 585b70` (RGB: 88,91,112 - dark gray)

Why autosuggestions are hard to read:
- Empty autosuggestion color means fish uses default (usually dark gray)
- Catppuccin colors like 313244 and 585b70 are designed for dark text on light backgrounds
- Terminals (WezTerm, Ghostty) use DARK backgrounds (Catppuccin Macchiato/Mocha)
- Result: dark text on dark background = invisible or very low contrast

## Solutions

### Fix 1: Bash colors in unconfigured terminals

#### Option A - Fallback to 256-color mode

Add to home/common/shells.nix:
```nix
programs.bash = {
  enable = true;
  shellAliases = commonShellAliases;
  initExtra = ''
    # Ensure proper color support detection
    if [[ -z "$COLORTERM" ]] && [[ "$TERM" == "xterm-256color" ]]; then
      # Fallback for terminals that don't set COLORTERM
      export COLORTERM=256color
    fi
  '';
};
```

#### Option B - Configure iTerm2 and Terminal.app properly

iTerm2:
- Preferences → Profiles → Terminal → Report Terminal Type → `xterm-256color`
- Preferences → Profiles → Terminal → Set locale environment variables on startup
- Import a Catppuccin colorscheme for the terminal background

Terminal.app:
- Preferences → Profiles → Advanced → Declare terminal as → `xterm-256color`
- Import a Catppuccin colorscheme for the terminal background

#### Option C - Use simpler Starship configuration

Add to home/common/programs.nix starship settings:
```nix
starship = {
  enable = true;
  settings = {
    # Existing settings...

    # Force 256-color mode instead of truecolor
    palette = "catppuccin_macchiato";

    format = lib.concatStrings [
      "$username"
      "$hostname"
      "$directory"
      "$git_branch"
      "$git_status"
      "$nix_shell"
      "$shell"
      "$character"
    ];
  };
};
```

### Fix 2: Fish autosuggestion colors

#### Option A - Quick fix via command (immediate)

```bash
fish -c "set -U fish_color_autosuggestion brblack"
```

Or for better visibility on dark backgrounds:
```bash
fish -c "set -U fish_color_autosuggestion 6c7086"  # Catppuccin overlay1 - medium gray
```

#### Option B - Configure in Nix (permanent)

Add to home/common/shells.nix:
```nix
programs.fish = {
  enable = true;
  shellAbbrs = commonShellAliases;
  interactiveShellInit = ''
    set fish_greeting # Disable greeting

    # Fix autosuggestion color for dark backgrounds
    set -g fish_color_autosuggestion 6c7086  # Catppuccin overlay1

    # Alternative: use fish's brblack for better compatibility
    # set -g fish_color_autosuggestion brblack
  '';
  plugins = [
    # Enable a plugin (here grc for colorized command output) from nixpkgs
  ];
};
```

#### Option C - Use fish theme matching terminal

```bash
# List available themes
fish -c "fish_config theme show"

# Choose one that matches your terminal background
fish -c "fish_config theme choose 'Dracula'"  # Good for dark backgrounds
# or
fish -c "fish_config theme choose 'Nord'"     # Also good for dark backgrounds
# or
fish -c "fish_config theme choose 'Tomorrow Night'"
```

#### Option D - Fix all colors with Stylix (comprehensive)

Enable Stylix in home/common/stylix.nix:
```nix
stylix = {
  enable = true;
  autoEnable = true;
  targets.fish.enable = true;
  targets.bash.enable = true;

  # Colors: Catppuccin Mocha (Base16)
  base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  # ... rest of config
}
```

This will automatically set all fish colors to match your terminal background.

## Recommended approach

For quickest fix:

1. Fix fish autosuggestions immediately:
```bash
fish -c "set -U fish_color_autosuggestion 6c7086"
```

2. For bash in unconfigured terminals:
   - Configure those terminals properly (Option B)
   - OR enable Stylix for unified theming (Option D)

3. After making nix changes:
```bash
home-manager switch
```

## Important notes

Fish stores color preferences in universal variables (~/.local/share/fish/fish_variables), which persist across sessions but are SEPARATE from your Nix configuration. This is why fish colors don't match your terminal theme - they were set manually at some point and are now stale. Nix can override these, but only if you explicitly set them in interactiveShellInit.

## Related files

- home/common/shells.nix:40-70 - bash and fish configuration
- home/common/programs.nix:98-113 - starship configuration
- home/common/stylix.nix - stylix theming (currently disabled)
- dotfiles/wezterm/.wezterm.lua:66-90 - wezterm color config
- dotfiles/ghostty/.config/ghostty/config:1-4 - ghostty color config
- ~/.bashrc - generated by home-manager
- ~/.config/fish/config.fish - generated by home-manager
- ~/.local/share/fish/fish_variables - fish universal variables (persistent)

## Terminal configurations

### WezTerm (working)
- Location: dotfiles/wezterm/.wezterm.lua:66-76
- Color scheme: "Catppuccin Macchiato" (dark), "Catppuccin Frappe" (light)
- TERM: xterm-256color
- COLORTERM: truecolor (set automatically)

### Ghostty (working)
- Location: dotfiles/ghostty/.config/ghostty/config:1,4
- Theme: light:catppuccin-macchiato,dark:catppuccin-mocha
- TERM: xterm-256color
- COLORTERM: truecolor (set automatically)

### Kitty (enabled but not configured)
- Location: home/common/programs.nix:65-67
- No explicit theme configured in nix config
- May need manual configuration

## Environment variables

Current environment in WezTerm:
```
TERM=xterm-256color
COLORTERM=truecolor
```

No LS_COLORS set (BSD ls on macOS has limited color support).
