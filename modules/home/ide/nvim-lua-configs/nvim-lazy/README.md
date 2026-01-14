# LazyVim Configuration

This is a Neovim configuration built on LazyVim, designed for an efficient development environment. It uses Nix for Language Server Protocol (LSP) management instead of Mason.

## Installation

1.  Place this directory into your Neovim configuration path (e.g., `~/.config/nvim`).
2.  Launch Neovim; LazyVim will handle plugin installation.

## Key Features & Conventions

*   **Plugin Management:** Handled by LazyVim (`lua/config/lazy.lua`).
*   **Configuration:** Core settings in `lua/config/`, individual plugin configs in `lua/plugins/`.
*   **Keybindings:** Custom keymaps in `lua/config/keymaps.lua`.
*   **LSP Management:** Managed via Nix.

## Quick Reference

*   `:Lazy`: Manage plugins.
*   `:LazyExtras`: Install language packs.
*   `:checkhealth`: Run diagnostics.
*   `<leader>?`: Search keymaps.
*   `<leader>ff`: Find files.

## Maintenance

*   Update plugins: `:Lazy sync`
*   Format config: `stylua .`
