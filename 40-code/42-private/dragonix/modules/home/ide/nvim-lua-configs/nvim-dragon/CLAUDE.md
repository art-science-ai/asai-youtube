# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is **nvim-dragon**, a personal Neovim configuration built from scratch with a focus on:
- **AI agent workflows**: Auto-reload/auto-save for seamless split-terminal collaboration
- **Minimalism**: Only essential plugins, carefully chosen
- **Mini.nvim ecosystem**: Heavy use of mini.nvim suite for consistency
- **Nix integration**: LSPs, formatters, and linters managed via Nix (no Mason)
- **Declarative & documented**: Every line readable with clear comments

## Architecture

### Entry Point & Loading Order

1. **`init.lua`** - Entry point that loads core configs in sequence:
   ```lua
   require("config.options")   -- Vim editor settings
   require("config.keymaps")   -- All keybindings (centralized)
   require("config.autocmds")  -- Auto-reload and auto-save logic
   require("config.lazy")      -- Plugin manager bootstrap
   ```

2. **`lua/plugins/`** - Plugin specifications (one file per plugin)
   - Auto-loaded by lazy.nvim via `{ import = "plugins" }`
   - Each file returns a lazy.nvim spec table

3. **`after/`** - Loads last (overrides and language-specific configs)
   - `after/ftplugin/<filetype>.lua` - Filetype-specific settings
   - `after/lsp/<server_name>.lua` - LSP server customization
   - `after/snippets/<language>.json` - Language snippets

### Directory Structure

```
.config/nvim-dragon/
├── init.lua                 # Entry point
├── lazy-lock.json          # Plugin versions lockfile
├── lua/
│   ├── config/             # Core configs (explicitly loaded)
│   │   ├── options.lua     # Vim settings (spaces, line numbers, etc.)
│   │   ├── keymaps.lua     # All keybindings + leader group definitions
│   │   ├── autocmds.lua    # Auto-reload/auto-save for AI workflows
│   │   └── lazy.lua        # Plugin manager bootstrap
│   └── plugins/            # Plugin specs (auto-loaded by lazy.nvim)
│       ├── catppuccin.lua  # Colorscheme (syncs with macOS theme)
│       ├── mini-*.lua      # Mini.nvim plugins (10 plugins)
│       └── obsidian.lua    # Obsidian note-taking integration
├── after/
│   ├── ftplugin/
│   │   └── markdown.lua    # Markdown-specific settings
│   ├── lsp/
│   │   └── lua_ls.lua      # LSP server-specific config
│   └── snippets/
│       └── lua.json        # Language-specific snippets
└── snippets/
    └── global.json         # Global snippets (TODO, FIXME, NOTE)
```

## Key Configuration Details

### AI Agent Workflow Integration

This config is optimized for working with AI agents (like Claude Code) in split terminals. Key features:

**Auto-reload** (`lua/config/autocmds.lua:15-34`):
- Watches for external file changes via `autoread` + `checktime` autocmds
- Triggers on: `FocusGained`, `BufEnter`, `CursorHold` (250ms)
- Shows non-intrusive notification via mini.notify when file reloads
- Debounced (2s cooldown) to prevent spam

**Auto-save** (`lua/config/autocmds.lua:36-58`):
- Saves on `FocusLost` (when switching to terminal)
- Saves on `CursorHold`/`CursorHoldI` (after 250ms inactivity)
- Only affects normal file buffers (excludes terminals, help, etc.)

**Visual feedback**:
- Statusline shows `[●]` when buffer is modified (disappears when saved)
- mini.notify shows bottom-right notifications for reloads

### Keybinding System

**Leader key**: Space

**Pattern**: Two-key semantic groups `<Leader>[group][action]`
- Lowercase = global/workspace-wide actions
- Uppercase = buffer-local/document-specific actions

**Leader groups** (defined in `_G.Config.leader_group_clues`):
```
<Leader>b  →  Buffer operations
<Leader>e  →  File explorer with mini.files (e = current file, E = cwd)
<Leader>f  →  Fuzzy finding (files, grep, buffers, help, etc.)
<Leader>o  →  Obsidian notes
<Leader>q  →  Quit/session management
<Leader>t  →  Toggles (placeholder for future features)
```

**Single-key mappings**:
```
<Leader>y  →  Yazi terminal file manager (current file)
<Leader>Y  →  Yazi terminal file manager (cwd)
```

**Key mappings** (`lua/config/keymaps.lua:60-140`):
- `<Leader>bn/bp` - Next/previous buffer
- `<Leader>e/E` - Open file explorer with mini.files (current file / cwd)
- `<Leader>ff/fg/fb/fh/fk/fc/fr` - Find files/grep/buffers/help/keymaps/commands/resume
- `<Leader>oo/on/os/ot/oy/oT` - Obsidian open/new/search/today/yesterday/template
- `<Leader>y/Y` - Open yazi terminal file manager (current file / cwd)
- `<Leader>qq/qQ/qw/qd/qr/qR` - Quit all/force/save+quit/quit no-save/reload/reload+notify

**Keybinding hints**: Press `<Leader>` and wait 500ms to see available commands (via mini.clue)

### Plugin Ecosystem

All plugins managed via **lazy.nvim**. The config heavily favors the **mini.nvim ecosystem** for consistency and minimalism.

**Current plugins**: See `lua/plugins/` directory
- Heavy use of mini.nvim ecosystem (consistency and minimalism)
- Plus: `catppuccin`, `yazi.nvim`, `obsidian.nvim`, and git suite (`neogit`, `diffview`, `gitsigns`)

**For comprehensive plugin list, selection rationale, and future planned plugins**: See [README.md → Plugins](./README.md#plugins)

### LSP, Formatting, Linting Strategy

**Philosophy**: All tools managed via Nix, not Mason plugin.

**Pattern**:
1. Language servers installed via Nix flake
2. Server-specific configs go in `after/lsp/<server_name>.lua`
3. Example: `after/lsp/lua_ls.lua` (currently placeholder)

**For language server recommendations and tool selections**: See [README.md → Language servers, formatters, linters](./README.md#language-servers-formatters-linters)

## Common Development Tasks

### Adding New Features

**New core config**:
1. Create `lua/config/<name>.lua`
2. Add `require("config.<name>")` to `init.lua`

**New plugin**:
1. Create `lua/plugins/<name>.lua`
2. Return a lazy.nvim spec table:
   ```lua
   return {
     "author/plugin-name",
     event = "VeryLazy",  -- or other lazy-loading event
     config = function()
       -- Plugin setup here
     end,
   }
   ```
3. Auto-loaded by lazy.nvim (no manual import needed)

**Language-specific settings**:
1. Create `after/ftplugin/<filetype>.lua`
2. Auto-loads when opening files of that type

**LSP server customization**:
1. Create `after/lsp/<server_name>.lua`
2. Example pattern:
   ```lua
   local client = vim.lsp.get_clients({ name = 'lua_ls' })[1]
   if client then
     -- Customize settings here
   end
   ```

**New keybinding group**:
1. Add mappings to `lua/config/keymaps.lua`
2. Register group in `_G.Config.leader_group_clues` table
3. mini.clue will automatically show hints

### Plugin Management Commands

- `:Lazy` - Open plugin manager UI
- `:Lazy update` - Update all plugins
- `:Lazy sync` - Install missing and update plugins
- `:Lazy clean` - Remove unused plugins
- `:Lazy restore` - Restore plugins to lockfile versions

### Important Configuration Files

When modifying behavior, check these files first:

**Vim settings**: `lua/config/options.lua`
- Line numbers, indentation, search behavior, splits, etc.
- `updatetime = 250` controls CursorHold trigger timing
- `timeoutlen = 300` controls leader key sequence timing

**Keybindings**: `lua/config/keymaps.lua`
- All keybindings in one file (centralized)
- Leader group definitions in `_G.Config.leader_group_clues`
- Helper functions: `nmap_leader()`, `xmap_leader()`

**Auto-reload/save**: `lua/config/autocmds.lua`
- AutoReload group: external change detection
- AutoSave group: prevent data loss on focus loss or idle

**Colorscheme**: `lua/plugins/catppuccin.lua`
- Auto-syncs with macOS light/dark mode
- `frappe` for dark mode, `macchiato` for light mode

**Statusline**: `lua/plugins/mini-statusline.lua`
- Custom save indicator function: `save_indicator()`
- Shows `[●]` when buffer is modified

**File explorer**: `lua/plugins/mini-files.lua`
- `<Leader>e` opens at current file location
- `<Leader>E` opens at current working directory
- Lightweight, GUI-based file navigation

**Terminal file manager**: `lua/plugins/yazi.lua`
- `<Leader>y` opens at current file directory
- `<Leader>Y` opens at current working directory
- Fast, feature-rich alternative to mini.files for terminal-based browsing

**Fuzzy finder**: `lua/plugins/mini-pick.lua`
- Custom picker: `files_hidden` (includes hidden files via ripgrep)
- Standard pickers: files, grep, buffers, help, etc.

## Decision-Making Process

Before adding new plugins:

1. Map the plugin to a category in README.md
2. Document decision and rationale in README.md **first**
3. Include options from LazyVim, MiniMax, Kickstart for comparison
4. Then implement in code

**For detailed process and selection criteria**: See [README.md → Configuration and plugin choices](./README.md#configuration-and-plugin-choices)

## Notes for Claude Code

When working in this codebase:

1. **Respect the minimal philosophy**: Don't add plugins unless absolutely necessary. Check if mini.nvim has an alternative first.

2. **Update README.md first**: Before implementing new features, document the decision-making process in README.md with options and rationale.

3. **Follow the architecture patterns**:
   - Core configs go in `lua/config/`
   - Plugins go in `lua/plugins/` (one file per plugin)
   - Language-specific overrides go in `after/ftplugin/`
   - LSP customization goes in `after/lsp/`

4. **Maintain documentation**: Every file has clear headers explaining purpose. Keep this standard.

5. **Test auto-reload/save**: When making changes, verify that the AI workflow integration (auto-reload, auto-save, notifications) still works correctly.

6. **Leader key organization**: When adding keybindings, use semantic two-key groups and update `_G.Config.leader_group_clues`.

7. **Lazy loading**: Use event-based lazy loading for plugins (`event = "VeryLazy"`, `event = "InsertEnter"`, etc.) to maintain fast startup.

8. **Nix integration**: Remember that LSPs, formatters, and linters are managed via Nix, not Mason. Don't add Mason-related plugins.
