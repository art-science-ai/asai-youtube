# nixvim-dragon

A Nix-based declarative Neovim configuration, migrating the original nvim-dragon Lua configuration to pure Nix using nixvim. This provides 100% reproducible configurations without any Lua files.

**Recent Updates (2025-01-09):** Major migration progress completed! Added Git integration suite (neogit, gitsigns, diffview), terminal management (toggleterm), window navigation (smart-splits), markdown rendering (render-markdown), and comprehensive leader keymaps. Migration progress now at 57.5% complete.

## Migration Status: nvim-dragon to nixvim-dragon

The migration is **in progress**. Below is a comprehensive comparison organized by plugin categories, showing implementation status across both configurations.

Original config: /Users/nikhilmaddirala/repos/nix-config/dotfiles/nvim-dragon/.config/nvim-dragon

**Legend:**
- ✅ Implemented in both nvim-dragon and nixvim-dragon
- 🔄 Implemented in nvim-dragon only
- 🚧 Partially implemented (basic version in nixvim-dragon)
- ⏭️ Skipped for now (will be added later)
- 📝 Planned for both configurations

## Core Configuration

- ✅ Vim options (indentation, line numbers, search behavior)
- ✅ Leader key configuration (Space as global leader)
- ✅ Basic UI settings (termguicolors, signcolumn, splits)
- ✅ Keymaps (comprehensive leader mappings migrated from original config)
- 🚧 Colorscheme (basic catppuccin support, theme sync pending)

## AI Integration & Auto-workflow

- ✅ Auto-reload/auto-save workflow (AI agent integration with focus detection)
- ✅ Auto-reload (external file change detection with notifications)
- ✅ Auto-save (focus loss and idle-based saving with statusline indicator)
- ✅ Custom autocmds for AI workflow integration

## Mini.nvim Ecosystem

- ✅ `mini-clue` - Keybinding hints with leader groups
- ✅ `mini-comment` - Treesitter-aware commenting
- ✅ `mini-icons` - Icon provider (replaces nvim-web-devicons)
- ✅ `mini-pairs` - Auto-close brackets/quotes
- ✅ `mini-pick` - Fuzzy finder and command palette
- ✅ `mini-statusline` - Minimal statusline with save indicator
- ✅ `mini-surround` - Surround operations (ys/cs/ds)
- ✅ `mini-tabline` - Buffer/tab line
- ✅ `mini-notify` - Notifications (used for auto-reload feedback)
- 🔄 `mini-files` - File explorer (mini.files)
- 🔄 `mini-extra` - Extra mini.nvim utilities

## Git Integration

- ✅ `neogit` - Magit-inspired git workflows
- ✅ `gitsigns.nvim` - Line-level git status, hunk staging
- ✅ `diffview.nvim` - Tab-based diff interface

## LSP & Completion

- 🔄 `nvim-lspconfig` - Language server configuration
- 📝 `nvim-cmp` completion ecosystem with sources
- 📝 `LuaSnip` for snippet expansion

## Markdown & Notes

- ⏭️ `obsidian.nvim` - Obsidian note-taking integration (skipped for now)
- ✅ `render-markdown.nvim` - In-editor Markdown rendering

## Navigation & UI

- ✅ `yazi.nvim` - Terminal file manager integration
- ✅ `toggleterm.nvim` - Integrated terminal management
- ✅ `smart-splits.nvim` - Better window navigation
- 📝 `trouble.nvim` for beautiful diagnostic display
- 📝 `nvim-navic` or `aerial.nvim` for breadcrumbs/code outline

## Language-Specific Configurations

- 🔄 `after/ftplugin/` directory (filetype-specific settings)
- 🔄 `after/lsp/` directory (LSP server customizations)
- 🔄 `after/snippets/` directory (language snippets)

## Planned Features

- 📝 `flash.nvim` or similar for enhanced jump motions
- 📝 `persistence.nvim` or similar for session auto-save
- 📝 `project.nvim` for project root detection and navigation
- 📝 `mini.ai` for enhanced text objects
- 📝 `nvim-lint` for asynchronous linting
- 📝 `conform.nvim` for asynchronous formatting
- 📝 Nix-based integration for all language tools (Nix, Python, JavaScript, etc.)

### Migration Progress

- **Total Features**: ~40 major features/plugin categories
- **Fully Migrated**: 23/40 (57.5%)
- **Partially Migrated**: 1/40 (2.5%)
- **Pending**: 16/40 (40%)

### Next Migration Priorities

1. **LSP Configuration** - Code intelligence features
2. **Complete Colorscheme** with theme sync
3. **Mini.files and Mini.extra** - File explorer and utilities
4. **Obsidian Integration** - Note-taking capabilities
5. **Additional Language Support** - Nix, Python, JavaScript tooling

### Architecture Differences

**nvim-dragon (Lua-based):**
- Entry point: `init.lua`
- Core configs: `lua/config/*.lua`
- Plugins: `lua/plugins/*.lua` (lazy.nvim)
- Language-specific: `after/` directory
- Pros: Flexible, easy to debug
- Cons: Imperative, requires managing dependencies

**nixvim-dragon (Nix-based):**
- Entry point: `default.nix`
- Core configs: `options.nix`, `keymaps.nix`
- Plugins: `plugins/*.nix` (declarative)
- Pros: 100% reproducible, atomic updates
- Cons: More verbose, learning curve

### Getting Started

The nixvim-dragon configuration provides a wrapper script `nxd` that sets the correct `NVIM_APPNAME`:

```bash
# Use the nixvim-dragon configuration
nxd [filename]

# This is equivalent to:
NVIM_APPNAME=nvim-dragon nixvim-dragon [filename]
```

### Notes

- Both configurations share the same philosophy: minimal, documented, AI-workflow optimized
- The nixvim-dragon configuration is designed to be a 1:1 migration where possible
- Some Lua-specific features may need creative Nix solutions
- The `after/` directory structure will be replicated through nixvim's extraConfigLua where needed
