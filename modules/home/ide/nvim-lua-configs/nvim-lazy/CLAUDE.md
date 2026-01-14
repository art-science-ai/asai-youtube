# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a LazyVim starter configuration with custom modifications. LazyVim is a Neovim setup powered by lazy.nvim that provides a complete IDE experience.

## Architecture

### Configuration Structure

- `init.lua` - Entry point that bootstraps lazy.nvim and loads config
- `lua/config/` - Core configuration modules
  - `lazy.lua` - lazy.nvim setup and plugin specifications
  - `options.lua` - Neovim options (extends LazyVim defaults)
  - `keymaps.lua` - Custom keymaps (extends LazyVim defaults)
  - `autocmds.lua` - Custom autocommands
- `lua/plugins/` - Custom plugin specifications that extend/override LazyVim

### Plugin System

LazyVim uses lazy.nvim's spec-based plugin management:
- Plugins are loaded from `lua/plugins/*.lua` files
- Each file can add new plugins, disable LazyVim plugins, or override configurations
- Plugin specs support opts tables/functions that are merged with or replace defaults
- The `example.lua` file is disabled (returns empty table) but contains comprehensive examples

**LazyVim Extras**: Language packs and feature sets are managed declaratively in `lua/plugins/extras.lua`. While `:LazyExtras` command can install extras interactively (tracked in `lazyvim.json`), declaring them in Lua files makes the config self-documenting and reproducible.

### Key Customizations

**Auto-save & Auto-reload (lua/config/autocmds.lua:11-30)**:
- Files auto-save on `InsertLeave` and `TextChanged`
- Files auto-reload when changed externally
- Notifications on external file changes

**Performance (lua/config/lazy.lua:38-52)**:
- Disabled runtime plugins: gzip, tarPlugin, tohtml, tutor, zipPlugin
- Plugin update checking enabled but notifications disabled
- All custom plugins load at startup (not lazy-loaded) unless explicitly configured

## Development Commands

### Code Formatting
```bash
# Format Lua files using stylua
stylua .
```

Configuration: 2-space indentation, 120 column width (stylua.toml)

### LSP & Development
This config uses:
- `mason.nvim` for LSP/tool installation
- `neoconf.json` for project-specific LSP settings
- `lua_ls` enabled for Lua development with neodev library support

LazyVim provides built-in commands via `:Lazy` for plugin management and `:Mason` for tool installation.
