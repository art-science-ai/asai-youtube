# nvim-dragon

## Introduction

Nikhil's personal Neovim configuration built from scratch, borrowing the best ideas from LazyVim, Kickstart, Mini-Max, and other configs:

- LazyVim's comprehensive plugin ecosystem
- Kickstart's educational, readable approach
- Mini-Max's clean directory structure using Neovim's native loading
- https://github.com/radleylewis/nvim

Philosophy:
- Fully declarative - config as code
- Every line readable and documented
- Modular with clear separation
- Minimal - only what you need
- Nix-integrated LSPs (no Mason)

## Structure

```
.
├── init.lua              Entry point
├── lua/
│   ├── config/          Core configuration
│   │   ├── options.lua  Vim options
│   │   ├── keymaps.lua  Key mappings
│   │   └── lazy.lua     Plugin manager setup
│   └── plugins/         Plugin specs (one per file)
├── after/                Loads last
│   ├── ftplugin/        Filetype configs
│   ├── lsp/             LSP server configs
│   └── snippets/        Language snippets
└── snippets/             Global snippets
```

Core config is explicitly loaded via `require()` in `init.lua`. Plugins are loaded by lazy.nvim from `lua/plugins/`. The `after/` directory loads last, perfect for overrides and language-specific configs. Adding new things:
- Core config → `lua/config/<name>.lua` (add to init.lua)
- New plugin → `lua/plugins/<name>.lua` (auto-loaded by lazy)
- Filetype-specific → `after/ftplugin/<filetype>.lua`
- LSP customization → `after/lsp/<server_name>.lua`
- Language snippets → `after/snippets/<language>.json`


## Configuration and plugin choices 

IMPORTANT: Before adding new plugins, follow this process:
- Map the desired plugin to a category and ensure the category is included in this list 
- Add multiple options under that category and make a decision based on tradeoffs.
- Make sure to include the options from LazyVim, MiniMax, and Kickstart for comparison and make sure to note that option is part of the distro.
- Update this readme with the decision and reasoning first, then implement in code.
- ALWAYS start with minimal configs and plugins to accomplish the goal at hand; use defaults where possible. Add complexity only when absolutely necessary - this can be done later.

Legend
- Choice categories
  - ✅ implemented and satisfied
  - ⚠️ implemented but can be improved
  - 🤖 decided and ready for implementation
  - 📝 to be decided
- Options 
  - 🟢 promising
  - 🟡 maybe
  - 🔴 unlikely
  - ⚪ unknown
  - ❌ rejected


## Core configs: keymaps, options, autocmds

Simple configs are mostly self documented in `lua/config/` with comments. More complex choices that span multiple configs and plugins are explained below. 

### Integration: AI agents, auto-save, and reload
I work with AI agents like Claude Code, Opencode, etc. in a split wezterm terminal alongside Neovim. I want external edits to be visible immediately, and I want to avoid losing work if I forget to save.

Implementation:
- Auto-reload watches for external file changes via `autoread` + `checktime` autocmds (FocusGained, BufEnter, CursorHold)
- Auto-save triggers on focus loss and after 250ms inactivity (CursorHold)
- Visual feedback: mini.notify notifications for reloads, statusline [●] indicator for unsaved changes

Rationale:
- ✅ `autoread` + `checktime` + autocmds: comprehensive detection without heavy file watchers
  - FileChangedShellPost autocmd shows non-intrusive notification when file reloads
  - Debounced (2s cooldown) to prevent notification spam
  - Uses mini.notify for bottom-right corner notifications that auto-dismiss
- ✅ Statusline save indicator: persistent, visible feedback without being intrusive
  - Shows [●] when buffer is modified, disappears when saved
  - Updates immediately on TextChanged via redrawstatus
  - Integrated into mini.statusline custom content function
- ✅ Auto-save timing: balance between safety and disruption
  - FocusLost saves all buffers when switching to AI agent terminal
  - CursorHold/CursorHoldI saves after 250ms inactivity (updatetime setting)
  - Only saves normal file buffers, excludes terminals/help/etc
- 🟡 Future: Diff view of AI changes using neogit/diffview for reviewing external edits before accepting

Rejected alternatives:
- ❌ `vim.o.autoread = true` only: requires manual triggers, not automatic enough
- ❌ File watcher plugins: heavier, overkill for this use case
- ❌ Manual reload workflow (`:e`): too manual, doesn't fit AI agent workflow
- ❌ Save on every change: too aggressive, performance impact on large files
- ❌ Manual save only: risk of data loss when switching focus

### Keymapping and command palette
I want to discover and run commands easily, especially for plugins I don't use often. I want keybinding hints when I start typing a key sequence, so I can discover available commands. A command palette like VSCode would be ideal for this workflow.
- ✅ Keybinding hints
  - ✅ mini.clue: lightweight, fits mini ecosystem, shows hints after 500ms delay with built-in clue generators
  - ❌ which-key.nvim: more popular but heavier, overkill for our needs
  - ❌ disabled: manual discovery is too slow
- ⚠️ Command palette
  - ✅ mini.pick: simpler picker with command support, pure Lua, no external deps, includes files/grep/buffers/commands
  - ❌ telescope command palette: more features but heavier, can migrate later if needed
  - ❌ fzf-lua: fast but requires external binary, breaks Nix philosophy
  - ❌ none: CLI-only workflow is inefficient


## Plugins 

Principles for choosing plugins:
- Popular, well-maintained, active community, well documented
- Consider if the plugin is included in popular distros like LazyVim, Kickstart, MiniMax
- Rich ecosystem of extensions and configurations where relevant
- Lua-native preferred over vimscript or external binaries
- Favor mini.nvim ecosystem for consistency where appropriate
- For LSP, formatters, linters: Favor all-in-one tools (LSP that formats and lints) when quality is high; choose opinionated formatters with good defaults; configurable is a bonus

#### Core
- ✅ Plugin manager
  - ✅ lazy.nvim: modern standard
  - 🟢 vim-pack: new native plugin manager in nvim; migrate to this in future
  - ❌ mini-deps: used in minimax; superseded by vim-pack
- ✅ Directory structure:
  - ✅ lua/config + lua/plugins + after/

#### Editor
- ✅ Keybinding hints
  - 🟢 which-key.nvim: essential for discoverability
  - ✅ mini.clue: lightweight which-key alternative from mini ecosystem
- ✅ Fuzzy finder
  - 🟢 telescope.nvim: extensible, lua-native, great UX
  - 🟡 telescope-fzf-native.nvim: faster sorter extension for Telescope
  - ✅ mini.pick with mini.extras
  - 🟡 fzf-lua: faster but requires external binary
- ✅ File explorer
  - 🟡 oil.nvim: edit filesystem like a buffer
  - ✅ mini.files: minimal, fits mini ecosystem
  - 🔴 neo-tree.nvim: too heavy, vscode-like
- 📝 Enhanced motions
  - 🟢 flash.nvim: modern, actively maintained
  - 🔴 hop.nvim: unmaintained
  - 🔴 leap.nvim: superseded by flash
  - 🟡 snacks.nvim words/scope: optional modern motions and UI helpers
- 📝 Session management
  - 🟢 persistence.nvim: auto-saves, well-maintained
  - 🔴 mini.sessions: too basic
- Project roots & jumping
  - 🟢 project.nvim: detect roots; Telescope integration. 
  - 🟡 harpoon: quick file marks for hyper-fast hopping. 
- Integrated terminal
  - ✅ toggleterm.nvim: sane multiple terminals, direction presets.

#### LSP, formatting, linting, syntax
- 📝 LSP config
  - 🟢 nvim-lspconfig: official, use Nix servers
- 📝 Diagnostic UI
  - 🟢 trouble.nvim: beautiful, essential
  - 🔴 mini.extra: less polished
- 📝 Code context
  - 🟡 nvim-navic: breadcrumbs in winbar
  - 🟡 aerial.nvim: sidebar outline view
- 📝 Linting
  - 🟢 nvim-lint: async, Nix-managed linters
- 📝 Formatting
  - 🟢 conform.nvim: async, Nix-managed formatters
- 📝 Syntax highlighting
  - 🟢 nvim-treesitter: industry standard, AST-based
  - 🟡 nvim-ts-autotag: auto close/rename HTML/JSX tags

#### UI
- ✅ Icon provider:
  - ✅ mini.icons: lua-based, fast, extensible
  - 📝 nvim-web-devicons: older standard
- ✅ Status line
  - 🟢 lualine.nvim: feature-rich, good defaults
  - ✅ mini.statusline: simpler, fits mini ecosystem, custom save indicator
- ✅ Buffer/tab line
  - 🟡 bufferline.nvim: polished but heavyweight
  - ✅ mini.tabline: minimal alternative
- 📝 Indent guides
  - 🟢 mini.indentscope: animated, shows scope
  - 🔴 indent-blankline.nvim: just static lines
- ✅ Notifications
  - ✅ mini.notify: lightweight, lua-native, used for auto-reload feedback
  - 🟡 noice.nvim: complete UI redesign, more comprehensive but heavier
  - 🔴 nvim-notify: redundant with mini.notify
- 📝 UI improvements
  - 🟢 dressing.nvim: small plugin, big UX win
  - 🟡 nui.nvim: UI component library used by many plugins
- ✅ Colorscheme
  - ✅ catppuccin: auto-sync with system theme with light/dark modes frappe/macchiato

#### Coding
- ✅ Auto-pairs
  - ✅ mini.pairs: minimal, consistent with mini ecosystem
  - 🟡 nvim-autopairs: more features but heavier
- ✅ Surround operations
  - ✅ mini.surround: lua-native, fits mini pattern
  - 🟡 nvim-surround: community standard, more complex
- ✅ Commenting
  - ✅ mini.comment: simple, treesitter-aware
  - 🟡 ts-comments.nvim: treesitter-powered comments used by LazyVim
  - 🔴 Comment.nvim: redundant if using mini
- 📝 Text objects
  - 🟢 mini.ai: powerful, extends builtin a/i
  - 🟡 nvim-treesitter-textobjects: alternative approach
- 📝 Completion engine
  - 🟢 nvim-cmp: de facto standard, extensible
  - 🔴 coq_nvim: opinionated, less flexible
- 📝 Completion sources (for nvim-cmp)
  - 🟢 cmp-nvim-lsp: required for LSP
  - 🟢 cmp-buffer: useful fallback
  - 🟢 cmp-path: essential for file paths
- 📝 Snippet engine
  - 🟢 LuaSnip: powerful, vscode compatible
  - 🔴 snippy: too minimal
  - 🔴 vim-vsnip: outdated vimscript
- 📝 Snippet source (for nvim-cmp)
  - 🟢 cmp_luasnip: pairs with LuaSnip
  - 🔴 cmp-snippy: not needed
- ✅ Git UI
  - ✅ neogit: Magit-inspired, Lua-native, intuitive git workflows
  - 🟢 lazygit.nvim: best git TUI, familiar terminal interface
- ✅ Git signs
  - ✅ gitsigns.nvim: Line-level git status, hunk staging/preview
- ✅ Diff viewing
  - ✅ diffview.nvim: Tabpage-based diff interface for all changes
- 📝 Todo highlighting
  - 🟢 todo-comments.nvim: colorful, searchable

#### Notes, Markdown & docs
- 📝 In-editor Markdown rendering
  - 🟢 render-markdown.nvim: prettified Markdown in Neovim buffers.
  - ⚪ markview.nvim
- 📝 Browser preview
  - 🟡 markdown-preview.nvim: mature live preview (Node dep).
- ✅ Obsidian workflows
  - ✅ obsidian.nvim: Obsidian 🤝 Neovim

#### AI helpers (optional, privacy & policy dependent)
- Chat/edit in buffer
  - 🟡 codecompanion.nvim: multi-adapter (OpenAI/Anthropic/Ollama/etc.), inline edits & actions. 
  - 🟡 avante.nvim: Cursor-like "diff-apply" flow in Neovim. 


## Language servers, formatters, linters

### Markdown
- LSP
  - 🟢 marksman: Fast Rust-based LSP
  - 🟢 markdown-oxide 
  - 🟡 markdown-language-server: Feature-rich but Node.js
- Formatter
  - 🟢 prettier: Consistent formatter
- Linter
  - 🟢 markdownlint: Standard linter

### Nix
- LSP
  - 🟢 nil: Fast Rust-based LSP
  - 🟢 nixd: Feature-rich native LSP
- Formatter
  - 🟢 alejandra: Opinionated fast formatter
  - 🟡 nixfmt: Official configurable formatter
- Linter
  - 🟢 statix: Fast linter with suggestions
  - 🟢 deadnix: Finds dead code

### JSON
- LSP
  - 🟢 vscode-json-languageserver: Standard LSP with schema support
- Formatter
  - 🟢 prettier: Consistent formatter
  - 🟡 jq: Powerful but not primary formatter
- Linter
  - 🟢 eslint: Configurable linter

### Python
- LSP
  - 🟢 pyright: Performant type-checking LSP
  - 🟡 pylsp: Python-native but slower
- Formatter
  - 🟢 black: Opinionated formatter
- Linter
  - 🟢 ruff: Fast all-in-one Rust-based tool

### Lua
- LSP
  - 🟢 lua-language-server: Feature-rich native LSP
- Formatter
  - 🟢 stylua: Opinionated fast formatter
- Linter
  - 🟢 luacheck: Standard linter

### JavaScript/TypeScript
- LSP
  - 🟢 typescript-language-server: Official LSP
- Formatter
  - 🟢 prettier: Standard formatter
- Linter
  - 🟢 biome: Fast all-in-one Rust-based tool
  - 🟡 eslint: Powerful but separate

### YAML
- LSP
  - 🟢 yaml-language-server: LSP with schema validation
- Formatter
  - 🟢 yamlfmt: Opinionated Go-based formatter
  - 🟡 prettier: Consistent but Node.js
- Linter
  - 🟢 yamllint: Standard linter

### TOML
- 📝 LSP/Formatter/Linter (All-in-one)
  - 🟢 taplo: Fast all-in-one Rust-based tool

### Shell/Bash
- LSP
  - 🟢 bash-language-server: LSP with autocomplete
- Formatter
  - 🟢 shfmt: Opinionated Go-based formatter
- Linter
  - 🟢 shellcheck: Comprehensive native linter

### HTML
- LSP
  - 🟢 vscode-html-language-server: Standard LSP
- Formatter
  - 🟢 prettier: Consistent formatter
- Linter
  - 🟢 htmlhint: HTML linter

### CSS
- LSP
  - 🟢 vscode-css-language-server: Standard LSP
- Formatter
  - 🟢 prettier: Consistent formatter
- Linter
  - 🟢 stylelint: Modern linter

### Go
- LSP
  - 🟢 gopls: Official, Go-native
- Formatter
  - 🟢 gofmt: Official, opinionated
- Linter
  - 🟢 golangci-lint: Comprehensive, Go-native

### Rust
- LSP
  - 🟢 rust-analyzer: Official, fast
- Formatter
  - 🟢 rustfmt: Official, opinionated
- Linter
  - 🟢 clippy: Official, comprehensive

### C/C++
- LSP
  - 🟢 clangd: Official, native
- Formatter
  - 🟢 clang-format: Official, configurable
- Linter
  - 🟢 clang-tidy: Official, powerful

### Java
- LSP
  - 🟡 jdtls: Official Eclipse, but not directly in Nixpkgs, Java-based
- Formatter
  - 🟡 google-java-format: Opinionated, but Java-based
- Linter
  - 🟡 checkstyle: Standard, but Java-based
