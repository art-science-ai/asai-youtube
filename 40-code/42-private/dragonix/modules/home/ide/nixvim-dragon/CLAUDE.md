# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Nixvim configuration module that provides a declarative Neovim setup using pure Nix. It's part of a larger Nix Home Manager configuration and represents a migration from Lua-based Neovim configuration to Nix-based configuration.

## Architecture

### Module Composition

The configuration uses a dynamic module composition pattern:
- `default.nix` automatically discovers all `.nix` files in `config/`, `plugins/`, and `after/` directories
- Keymaps are collected separately from other configurations using `lib.foldl`
- All modules are merged into a unified configuration for nixvim consumption

### Directory Structure

- `config/` - Core Neovim configuration (options, keymaps, autocmds, colorscheme)
- `plugins/` - Individual plugin configurations (each plugin in its own file)
- `after/` - Filetype-specific and post-configuration modules
- `default.nix` - Main module entry point with dynamic composition logic

### Plugin Configuration Pattern

Each plugin follows this structure:
```nix
{
  plugins.plugin-name.enable = true;
  # Optional custom settings
  # Optional extraConfigLua for complex configurations
  # Optional keymaps specific to the plugin
}
```

## Development Commands

Since this is a Nix module, standard Nix commands apply:

- Build the configuration: `nix build .#nixvim-dragon`
- Test configuration: `nix eval .#nixvim-dragon`
- Apply via Home Manager: `home-manager switch` or `nix run .#activate`

The configuration also provides a wrapper script:
```bash
nxd [filename]  # Launch nixvim-dragon with AI workflow optimizations
```

## Key Features

### AI Workflow Integration
- Auto-reload: Detects external file changes from AI agents
- Auto-save: Saves buffers on focus loss and after 2 seconds of inactivity
- Statusline shows [●] for unsaved changes and [○] for saved state
- `updatetime = 250ms` for responsive AI workflow

### Git Integration Suite
- Neogit: Magit-like git interface
- Gitsigns: Inline git status in gutter
- Diffview: Tab-based git diff viewer

### Mini.nvim Ecosystem
Heavy use of mini.nvim plugins for:
- Statusline and tabline (mini-statusline)
- File picker and fuzzy finding (mini-pick)
- Commenting, text objects, and utilities

## Configuration Patterns

### Keymaps Organization
Keymaps are organized in layers:
- Global keymaps in `config/keymaps.nix`
- Plugin-specific keymaps in each plugin module
- All collected with `lib.concatLists` and merged

### Filetype-Specific Configuration
Uses `afterAttrs` pattern for filetype-specific settings:
```nix
afterAttrs = {
  filetype = "markdown";
  extraConfigLua = '' -- Markdown specific config '';
};
```

### Lua Integration
Complex configurations use `extraConfigLua`:
```nix
extraConfigLua = ''
  -- Lua code here
'';
```

## Migration Status

This module is part of an ongoing migration from nvim-dragon (Lua) to nixvim-dragon (Nix). Current progress: 57.5% complete.

## Integration Context

- This module is imported in the main Home Manager configuration at `./modules/home/ide/nixvim-dragon`
- Shares LSP servers, formatters, and linters with other editor configurations
- Uses `NVIM_APPNAME=nvim-dragon` environment variable for isolation