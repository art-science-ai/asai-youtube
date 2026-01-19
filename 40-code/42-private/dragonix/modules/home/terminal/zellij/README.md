# Zellij configuration

Terminal workspace and multiplexer with vim-zellij-navigator integration.

## Important: Terminal Compatibility

Zellij's vim-zellij-navigator plugin does NOT work in WezTerm due to WezTerm-specific bugs. To use Zellij:

- Use Ghostty (recommended), Kitty, or Alacritty
- See ../README.md for full comparison of WezTerm vs Zellij workflows

## Project Overview & Current Status

This configuration was recently overhauled to maximize vertical space, improve discoverability, and explore automated tab management.

### Original Goals
1.  **Maximize Space**: Remove the bulky default bottom bar.
2.  **Unified UI**: Consolidate status, mode, and tabs into a single minimal top bar.
3.  **Discoverability**: Add a `which-key` style menu for custom bindings.
4.  **Smart Tabs**: Automatically name tabs after the Current Working Directory (CWD) and apply a 70/30 split layout.

### What is Working ✅
- **Unified Top Bar**: Uses the `zjstatus` plugin to show Mode, Session, Tabs, Git branch (with icon ``), and Time in one line.
- **Maximized Real Estate**: The bottom bar is disabled.
- **Which-Key Menu (`Alt + /`)**: Launches a clean, floating cheat sheet of custom bindings using the `zellij-forgot` plugin.
- **Zen Mode (`Alt + z`)**: Toggles pane frames (borders) for a minimal look.
- **Default Layout**: 70/30 split (Main/Sidebar) is configured as the default for startup and new tabs.
- **Stability**: Reverted to standard `NewTab` behavior to eliminate glitches.

### What is NOT Working / Deprecated ❌
- **Automatic CWD Tab Renaming**:
    - **Attempt 1 (Shell Hooks)**: Tried `precmd` and `chpwd` hooks to rename tabs. This caused a "doubling" glitch (e.g., `folderfolder`) due to race conditions.
    - **Attempt 2 (Custom Scripts)**: Tried custom wrappers using `zoxide`, `fzf`, and `yazi` to proactively create named tabs. These proved brittle due to pathing issues in Nix and UX friction (e.g., non-closable floating panes, layout application errors).
- **Current State**: Tabs are now created with standard Zellij names (e.g., `Tab #1`). Users should manually rename important tabs using `Alt + r`.

## Quick Reference

Starting zellij:
```bash
zellij                    # Start with default 70/30 layout
zellij attach [name]      # Named session
zellij list-sessions      # List all sessions
```

CLI Interaction (Control from other terminals):
```bash
zellij -s [name] action dump-layout  # Inspect current session UI state
zellij -s [name] action [command]    # Send actions (e.g., rename-tab)
```

## Keybindings (Curated)

| Action | Key |
| :--- | :--- |
| **Which-Key Menu** | `Alt + /` |
| **New Tab** | `Alt + t` |
| **Close Tab** | `Alt + T` |
| **Rename Tab** | `Alt + r` |
| **New Pane** | `Alt + n` |
| **Close Pane** | `Alt + x` |
| **Toggle Floating** | `Alt + f` |
| **Zen Mode** | `Alt + z` |
| **Navigation** | `Ctrl + h/j/k/l` |
| **Resize** | `Alt + h/j/k/l` |

## Future Improvements

- **Declarative Plugins**: Move `zjstatus` and `zellij-forgot` to `pkgs.fetchurl` in `zellij.nix` for offline/pure builds (partially documented in Git history).
- **Tab Overflow**: Add logic to `zjstatus` to shorten inactive tab formats when many are open.
- **Smart Naming**: Re-explore Yazi/Zoxide integration once a more robust method for passing layouts to `new-tab` actions is found.