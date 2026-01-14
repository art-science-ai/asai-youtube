# Terminal module

This module provides terminal emulators and multiplexers with integrated navigation workflows.

## Terminal workflow

**WezTerm (primary terminal):**
- Uses WezTerm's native pane system with smart-splits.nvim
- CTRL+hjkl: Navigate between neovim splits (via smart-splits.nvim)
- ALT+hjkl: Resize neovim splits (via smart-splits.nvim)
- IS_NVIM variable is NOT used (smart-splits handles all neovim navigation)
- WezTerm handles pane management (splits, tabs, etc.)

**Ghostty (when using Zellij):**
- Uses zellij's pane system with vim-zellij-navigator plugin
- CTRL+hjkl: Navigate between zellij panes or neovim splits (automatic detection)
- ALT+hjkl: Resize zellij panes or neovim splits (automatic detection)
- Same keybindings work seamlessly across neovim and zellij boundaries
- Works perfectly in Ghostty (vim-zellij-navigator has WezTerm-specific bugs)

## Components

- **wezterm/**: Modern GPU-accelerated terminal emulator with native pane management
- **zellij/**: Terminal workspace and multiplexer with vim-zellij-navigator integration
- **misc/**: Additional terminal emulators (ghostty, kitty)

## Configuration philosophy

The terminal workflow is designed around consistent keybindings:
- CTRL+hjkl always navigates (within neovim splits or terminal panes)
- ALT+hjkl always resizes (neovim windows or terminal panes)
- Seamless navigation between neovim and terminal boundaries
- No modal mode-switching for common actions

See individual component directories for detailed configuration.
