# Neovim Kickstart Configuration

A clean, modular Neovim configuration built on `kickstart.nvim` with `NixCats` integration. Started with kickstart.nvim and adapted for personal use.

## Philosophy

This configuration is designed to be:
- **Understandable**: Readable and well-documented
- **Modular**: Organized into clear, separate files
- **Minimal**: Only what's essential
- **Nix-integrated**: LSP servers managed declaratively via Nix

## Structure

```
.
├── init.lua              # Entry point - loads core config & plugins
└── lua/
    ├── core/             # Core Neovim settings (options, keymaps, autocommands)
    └── plugins/          # All plugin configurations
```

## Key Features

-   **Plugin Manager**: `lazy.nvim` with automatic lazy loading
-   **LSP**: Full language server support via `nvim-lspconfig`
-   **Completion**: `blink.cmp` with LSP, path, and snippet sources
-   **Formatting**: `conform.nvim` with format-on-save
-   **Fuzzy Finding**: `telescope.nvim`
-   **File Explorer**: `neo-tree.nvim`
-   **Git Integration**: `gitsigns.nvim`
-   **Syntax Highlighting**: Treesitter with auto-install
-   **UI**: Mini.statusline + Which-key for keybinding discovery

## Plugin Management

-   `:Lazy` - View plugin status
-   `:Lazy update` - Update all plugins
-   `:Lazy clean` - Remove unused plugins

## Resources

-   [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
-   [lazy.nvim docs](https://github.com/folke/lazy.nvim)
-   [Neovim Lua guide](https://neovim.io/doc/user/lua-guide.html)
