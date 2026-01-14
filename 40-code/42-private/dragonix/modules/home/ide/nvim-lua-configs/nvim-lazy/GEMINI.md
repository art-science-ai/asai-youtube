# General guidelines

This directory contains a Neovim configuration based on LazyVim, designed to provide a personalized and efficient development environment. It integrates with Nix for Language Server Protocol (LSP) management.

## Project Overview

This project is a Neovim configuration that leverages LazyVim for plugin management and a structured approach to Neovim customization. It aims to offer a robust and tailored editing experience, with specific attention to keybindings, editor options, and plugin configurations. A notable feature is its integration with Nix for managing Language Server Protocols (LSPs), diverging from the more common Mason approach.

## Building and Running

This is a Neovim configuration, not a traditional application that is "built" or "run" in the conventional sense. To use this configuration:

*   **Installation:** Place this directory (the parent directory of `lua/` and `init.lua`) into your Neovim configuration path, typically `~/.config/nvim`.
*   **Launch Neovim:** Open Neovim from your terminal. LazyVim will automatically handle plugin installation and setup on the first launch.

## Development Conventions

*   **Plugin Management:** Plugins are managed using LazyVim. Plugin specifications and language extras are defined in `lua/config/lazy.lua`.
*   **Configuration Structure:**
    *   `lua/config/`: Contains core configuration files such as `autocmds.lua` (auto-save/reload behavior), `keymaps.lua` (custom keybindings), `lazy.lua` (plugin specs & language extras), and `options.lua` (Neovim options).
    *   `lua/plugins/`: Houses individual plugin configurations, with each plugin typically having its own `.lua` file (e.g., `colorscheme.lua`, `lualine.lua`).
*   **Keybindings:** Custom keymaps are primarily defined in `lua/config/keymaps.lua`. Plugin-specific keymaps can also be found within the `keys` table of individual plugin configuration files in `lua/plugins/*.lua`.
*   **Formatting:** The configuration uses `stylua` for Lua code formatting. The `stylua.toml` file in the root directory specifies formatting rules.
*   **LSP Management:** Language Server Protocols are managed via Nix, not through Neovim's built-in Mason.
*   **Maintenance:**
    *   Update plugins: Run `:Lazy sync` within Neovim.
    *   Format configuration: Run `stylua .` in the project root.
    *   Troubleshoot: Run `:checkhealth` within Neovim.

## Quick Reference

### Essential Neovim Commands

*   `:Lazy`: Manage plugins (update, clean, sync).
*   `:LazyExtras`: Install language packs and features interactively.
*   `:checkhealth`: Run diagnostics for Neovim and plugins.
*   `:messages`: View Neovim errors and logs.
*   `:LspInfo`: Check active Language Server Protocol servers.

### Finding Information

*   `<leader>?`: Search all keymaps for the current buffer.
*   `<leader>ff`: Find files.
*   `<leader>sg`: Search in files (grep).
*   `<leader>` then wait: See all leader key options (which-key popup).

### Understanding Keymaps

Keymaps are sourced from:
1.  `lua/config/keymaps.lua` (custom keymaps).
2.  `lua/plugins/*.lua` (plugin-specific keymaps in `keys` table).
3.  LazyVim defaults.

To inspect keymaps:
*   `<leader>?`: Show all active keymaps for the current buffer.
*   `:map`: List all mappings.
*   `:map <key>`: Check what a specific key does (e.g., `:map <leader>sk`).
*   `:verbose map <key>`: See where a keymap was defined.
