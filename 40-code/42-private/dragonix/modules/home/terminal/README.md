# Terminal module

This module provides terminal emulators and multiplexers with integrated navigation workflows.

## Architecture: Choosing between WezTerm and Zellij

You have two options for pane management, each optimized for different terminals:

### Option 1: WezTerm (default)
- **Terminal**: WezTerm
- **Pane system**: WezTerm's native panes
- **Neovim integration**: smart-splits.nvim plugin
- **Keybindings**:
  - CTRL+hjkl: Navigate between neovim splits
  - ALT+hjkl: Resize neovim splits
  - WezTerm handles pane management (splits, tabs, etc.)
- **Best for**: GPU acceleration, native pane performance, tab management
- **Limitation**: Cannot use Zellij's vim-zellij-navigator (WezTerm has bugs with the plugin)

### Option 2: Zellij + Alternative Terminal
- **Terminals**: Ghostty, Kitty, Alacritty (NOT WezTerm)
- **Pane system**: Zellij's multiplexer
- **Neovim integration**: vim-zellij-navigator plugin + smart-splits.nvim
- **Keybindings**:
  - CTRL+hjkl: Navigate neovim splits OR zellij panes (automatic detection)
  - ALT+hjkl: Resize neovim windows OR zellij panes (automatic detection)
  - Same keybindings work seamlessly across neovim and zellij boundaries
- **Best for**: Terminal-agnostic workflow, session persistence, advanced multiplexer features
- **Limitation**: WezTerm specifically has bugs with vim-zellij-navigator (use Ghostty/Kitty/Alacritty instead)

## Key Differences

| Feature | WezTerm Native | Zellij + Alternative Terminal |
|---------|---------------|------------------------------|
| Terminal | WezTerm only | Ghostty, Kitty, Alacritty |
| Pane management | WezTerm built-in | Zellij multiplexer |
| Session persistence | Limited | Full (with linger enabled) |
| Neovim integration | smart-splits.nvim only | smart-splits + vim-zellij-navigator |
| Cross-boundary navigation | No (neovim only) | Yes (neovim ↔ zellij) |
| Terminal-agnostic | No | Yes (works in any terminal) |

## Current Setup

Your system has WezTerm configured as the default. To use Zellij instead:

1. Install an alternative terminal: Ghostty (recommended), Kitty, or Alacritta
2. Start Zellij manually: `zellij`
3. Use CTRL+hjkl/ALT+hjkl for seamless navigation

## Components

- **wezterm/**: WezTerm terminal configuration
- **zellij/**: Zellij multiplexer configuration
- **misc/**: Additional terminal emulators (ghostty, kitty)

## Configuration philosophy

The terminal workflow is designed around consistent keybindings:
- CTRL+hjkl always navigates (within neovim splits or terminal panes)
- ALT+hjkl always resizes (neovim windows or terminal panes)
- Seamless navigation between neovim and terminal boundaries
- No modal mode-switching for common actions

See individual component directories for detailed configuration.
