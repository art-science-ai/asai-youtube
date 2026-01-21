# Neovim Configuration

This document outlines the Neovim configurations used in this repository, focusing on a modular approach with Nix-managed Language Server Protocols (LSPs).

## Common Configuration

### Architecture

This repository uses a multi-config Neovim setup with `NVIM_APPNAME`:

- **Dotfiles Location**: Configs are stored in the `dotfiles/` directory.
- **Deployment**:
  - **macOS**: Symlinked via stow (manual).
  - **Linux**: Automatically deployed via `home/hosts/seasmoke/dotfiles.nix`.
- **Multiple Configurations**: Switch between different configs using `NVIM_APPNAME`.
  - `nvim-lazy` → LazyVim configuration (primary).
  - `nvim-kickstart` → Kickstart.nvim - minimal starting config.
  - `nvim-minimax` → Modern version of Kickstart by creator of Mini.
  - `nvim-meta` → Alternative configuration.

**Shell Aliases** are configured in `home/common/shells.nix`:
- `nvl` → opens `nvim-lazy`.
- `nvk` → opens `nvim-kickstart`.
- `nvm` → opens `nvim-meta`.
- `nvmm` → opens `nvim-minimax`.

### Package Management

- **LSP Servers**: Managed declaratively via Nix in `home/common/packages.nix`.
- **Tools and Formatters**: Also managed in `home/common/packages.nix`.
- **Neovim Plugins**: Managed via various plugin managers within each config's Lua files.

### Adding a New Neovim Configuration

To create a new Neovim configuration:

1.  **Create the config directory structure**:
    ```bash
    mkdir -p dotfiles/nvim-myconfig/.config/nvim-myconfig
    ```

2.  **Add your Neovim configuration files**:
    ```bash
    # Example: copy from an existing config
    cp -r dotfiles/nvim-kickstart/.config/nvim-kickstart/* \
          dotfiles/nvim-myconfig/.config/nvim-myconfig/

    ```
    *Note: Make sure to update this `neovim.md` file and symlink it into the new config directory if applicable.*

3.  **Add a shell alias** in `home/common/shells.nix`:
    ```nix
    nvmy = "NVIM_APPNAME=nvim-myconfig nvim";
    ```

4.  **Rebuild your system**:
    ```bash
    # macOS
    darwin-rebuild switch --flake .

    # Linux (remote)
    deploy .#seasmoke
    ```

5.  **Symlink the dotfiles**:
    -   **macOS**: Use stow manually if needed.
    -   **Linux**: Automatic via `dotfiles.nix`.

6.  **Use your new config**:
    ```bash
    nvmy  # or NVIM_APPNAME=nvim-myconfig nvim
    ```

### Adding LSPs or Tools

To add new LSP servers or development tools:

1.  **Add the package** to `home/common/packages.nix`:
    ```nix
    home.packages = with pkgs; [
      # ... existing packages ...
      rust-analyzer  # Example: add Rust LSP
      taplo          # Example: add TOML LSP
    ];
    ```

2.  **Rebuild your system** (same commands as above).

3.  The LSP will be available to all Neovim configs automatically.

4.  **Configure the LSP** in your Neovim config's Lua files (usually in `lua/plugins/lsp.lua` or similar).

### How NVIM_APPNAME Works

When you run `NVIM_APPNAME=nvim-lazy nvim`, Neovim looks for config files in:
-   `~/.config/nvim-lazy/` instead of `~/.config/nvim/`.
-   `~/.local/share/nvim-lazy/` for data (plugins, state).
-   `~/.local/state/nvim-lazy/` for state files.
-   `~/.cache/nvim-lazy/` for cache.

This allows completely independent Neovim configurations that don't interfere with each other.

### Switching Between Configurations

You can switch configs at any time:

```bash
nvl          # LazyVim (primary config)
nvk          # Kickstart (minimal config)
nvm          # Meta config

# Or use NVIM_APPNAME directly
NVIM_APPNAME=nvim-lazy nvim myfile.txt
```

Each config maintains its own:
-   Plugin installations (via lazy.nvim).
-   Plugin state and data.
-   UI settings and preferences.

All configs share:
-   LSP servers (from Nix packages).
-   System tools (ripgrep, fd, etc.).
-   Node.js and Python providers.

### Benefits of This Approach

-   **Simple and Transparent**: Just `NVIM_APPNAME`, no complex frameworks.
-   **Fast Iteration**: Edit Lua configs and they work immediately.
-   **Reproducible**: LSPs managed by Nix (no Mason).
-   **Isolated**: Each config has its own plugin state.
-   **Easy to Add Configurations**: Just create a directory and add an alias.
-   **Works Everywhere**: Standard Neovim feature, no custom tooling.

## Individual Configurations

### nvim-kickstart Configuration

A clean, modular Neovim configuration built on kickstart.nvim with NixCats integration.

#### Philosophy

This configuration is designed to be:
- **Understandable**: Every line is readable and well-documented
- **Modular**: Organized into clear, separate files
- **Minimal**: Only what you need, nothing more
- **Nix-integrated**: LSP servers managed declaratively via Nix

#### Structure

```
.
├── init.lua              # Entry point - loads core config & plugins
└── lua/
    ├── init.lua          # Loads core configuration modules
    ├── core/             # Core Neovim settings
    │   ├── options.lua   # Vim options (line numbers, clipboard, etc.)
    │   ├── keymaps.lua   # Custom keybindings
    │   └── autocommands.lua  # Auto-commands
    └── plugins/          # All plugin configurations
        ├── init.lua              # Plugin directory index
        ├── auto-save.lua         # Auto-save on changes
        ├── autopairs.lua         # Auto-insert matching pairs
        ├── colorscheme.lua       # Tokyonight theme
        ├── gitsigns.lua          # Git integration
        ├── guess-indent.lua      # Auto indent detection
        ├── lazydev.lua           # Lua development tools
        ├── lsp-autocomplete.lua  # Completion (blink.cmp)
        ├── lsp-autoformat.lua    # Auto formatting (conform.nvim)
        ├── lsp-config.lua        # LSP servers
        ├── mini.lua              # Mini.nvim collection
        ├── neo-tree.lua          # File explorer
        ├── telescope.lua         # Fuzzy finder
        ├── todo-comments.lua     # TODO highlighting
        ├── treesitter.lua        # Syntax highlighting
        └── which-key.lua         # Keybinding helper
```

#### Key Features

##### Core Functionality
- **Plugin Manager**: `lazy.nvim` with automatic lazy loading
- **LSP**: Full language server support via `nvim-lspconfig`
- **Completion**: `blink.cmp` with LSP, path, and snippet sources
- **Formatting**: `conform.nvim` with format-on-save
- **Fuzzy Finding**: `telescope.nvim` with fzf-native
- **File Explorer**: `neo-tree.nvim`
- **Git Integration**: `gitsigns.nvim` with inline blame and hunks
- **Syntax Highlighting**: Treesitter with auto-install
- **UI**: Mini.statusline + Which-key for keybinding discovery

##### Leader Key
The `<space>` key is set as the leader key.

##### Viewing Keymaps
- `<space>sk` - Search keymaps with Telescope
- `<space>` - View available keymaps with Which-key

#### Adding Support for New Languages

Adding a new language involves configuring multiple components. Here's the complete process:

##### 1. LSP Server (Language Intelligence)

Edit `lua/plugins/lsp-config.lua` and add your language server configuration using `vim.lsp.config`:

```lua
-- Add your language server configuration
vim.lsp.config.pyright = {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'setup.py', '.git' },
  capabilities = capabilities,
}

-- With custom settings:
vim.lsp.config.gopls = {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_markers = { 'go.mod', '.git' },
  capabilities = capabilities,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
    },
  },
}

-- Then enable the servers:
vim.lsp.enable({ 'lua_ls', 'pyright', 'gopls' })
```

**Find available servers**: See `:help vim.lsp.config` or [lspconfig server list](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)

**NixCats Integration**: LSP servers should be added to your Nix configuration (e.g., `home/common/nvim.nix`), then configured here. Mason is disabled to prevent conflicts with declarative package management.

##### 2. Treesitter (Syntax Highlighting)

Edit `lua/plugins/treesitter.lua` and add your language to `ensure_installed`:

```lua
opts = {
  ensure_installed = {
    'bash', 'c', 'lua', 'markdown', 'vim', 'vimdoc',
    -- Add your languages:
    'python', 'javascript', 'typescript', 'go', 'rust',
  },
  auto_install = true,  -- Auto-installs missing parsers
}
```

**Find available parsers**: Run `:TSInstallInfo` or check [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter#supported-languages)

##### 3. Formatter (Code Formatting)

Edit `lua/plugins/lsp-autoformat.lua` and add formatters to `formatters_by_ft`:

```lua
formatters_by_ft = {
  lua = { 'stylua' },
  -- Add formatters for your languages:
  python = { 'isort', 'black' },
  javascript = { 'prettierd', 'prettier', stop_after_first = true },
  go = { 'goimports', 'gofmt' },
  rust = { 'rustfmt' },
}
```

**Find available formatters**: See [conform.nvim formatters](https://github.com/stevearc/conform.nvim#formatters)

**NixCats Integration**: Add formatters to your Nix configuration alongside LSP servers for declarative management.

##### 4. Completion Sources (Optional)

Blink.cmp automatically supports LSP completion. For additional sources, edit `lua/plugins/lsp-autocomplete.lua`:

```lua
sources = {
  default = { 'lsp', 'path', 'snippets', 'lazydev' },
  -- Add language-specific sources if needed
}
```

##### 5. Language-Specific Snippets (Optional)

To enable snippets, uncomment the `friendly-snippets` section in `lua/plugins/lsp-autocomplete.lua`:

```lua
dependencies = {
  {
    'rafamadriz/friendly-snippets',
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
    end,
  },
}
```

##### Example: Adding Python Support

1. **LSP**: Add to `lsp-config.lua`:
   ```lua
   vim.lsp.config.pyright = {
     cmd = { 'pyright-langserver', '--stdio' },
     filetypes = { 'python' },
     root_markers = { 'pyproject.toml', 'setup.py', '.git' },
     capabilities = capabilities,
   }

   -- Then add 'pyright' to the enable list:
   vim.lsp.enable({ 'lua_ls', 'pyright' })
   ```

2. **Treesitter**: Add to `treesitter.lua`:
   ```lua
   ensure_installed = { ..., 'python' }
   ```

3. **Formatter**: Add to `lsp-autoformat.lua`:
   ```lua
   formatters_by_ft = {
     python = { 'isort', 'black' },
   }
   ```
   And add formatters to your Nix configuration.

4. **Restart Neovim** or run `:Lazy sync` to verify installation

##### Verification

After adding language support:
- `:LspInfo` - Check LSP server status
- `:TSInstallInfo` - Verify Treesitter parser
- `:ConformInfo` - View formatter configuration
- `:checkhealth` - Run health checks for all components

#### Adding New Plugins

1. Create a new file in `lua/plugins/` (e.g., `my-plugin.lua`)
2. Return a plugin spec:
   ```lua
   return {
     'owner/repo',
     opts = {
       -- your configuration
     },
   }
   ```
3. It will be automatically loaded via `{ import = 'plugins' }` in `init.lua`

#### Plugin Management

- `:Lazy` - View plugin status
- `:Lazy update` - Update all plugins
- `:Lazy clean` - Remove unused plugins

#### Customization

##### Adding Keymaps
Edit `lua/core/keymaps.lua`:
```lua
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = '[W]rite file' })
```

##### Adding Options
Edit `lua/core/options.lua`:
```lua
vim.opt.relativenumber = true
```

##### Adding Autocommands
Edit `lua/core/autocommands.lua`:
```lua
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    vim.opt_local.tabstop = 4
  end,
})
```

#### Progress Checklist

**Completed:**
- ✅ Fully modular configuration (core + plugins separated)
- ✅ All plugins extracted to individual files
- ✅ Clean 2-directory structure (`core/` + `plugins/`)
- ✅ LSP, completion, and formatting configured
- ✅ Auto-reload on file changes
- ✅ Comprehensive plugin suite (16 plugins)
- ✅ Kickstart dependencies fully integrated

**Next Steps:**
- Add more language servers via NixCats
- Add filetype-specific keymaps
- Profile and optimize startup time
- Explore additional mini.nvim modules

#### Resources

- [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
- [lazy.nvim docs](https://github.com/folke/lazy.nvim)
- [Neovim Lua guide](https://neovim.io/doc/user/lua-guide.html)

### nvim-lazy Configuration

### Neovim Config

LazyVim-based configuration with Nix integration for LSP management.

#### Quick reference

##### Essential commands
- `:Lazy` - Manage plugins (update, clean, sync)
- `:LazyExtras` - Install language packs and features
- `:checkhealth` - Run diagnostics
- `:messages` - View errors/logs
- `:LspInfo` - Check active LSP servers

##### Finding things
- `<leader>?` - Search all keymaps for current buffer
- `<leader>ff` - Find files
- `<leader>sg` - Search in files (grep)
- `<leader>` then wait - See all leader key options (which-key popup)

Full LazyVim defaults: [LazyVim docs](https://www.lazyvim.org/keymaps)

##### Understanding keymaps

Keymaps come from three sources (in order of precedence):
1. Your custom keymaps in `lua/config/keymaps.lua`
2. Plugin-specific keymaps in `lua/plugins/*.lua` (in the `keys` table)
3. LazyVim defaults

To inspect current keymaps:
- `<leader>?` - Show all active keymaps for current buffer
- `:map` - List all mappings
- `:map <leader>sk` - Check what a specific key does
- `:verbose map <leader>sk` - See where a keymap was defined

Example: `<leader>sk` is "Swap buffer up" (from lua/plugins/smart-splits.lua:19), not the LazyVim default

#### Configuration files
```
lua/config/
  ├── lazy.lua      - Plugin specs & language extras
  ├── keymaps.lua   - Custom keybindings
  ├── options.lua   - Neovim options
  └── autocmds.lua  - Auto-save/reload behavior

lua/plugins/
  └── *.lua         - Individual plugin configurations
```

#### Customization

##### Add a plugin
Create `lua/plugins/name.lua`:
```lua
return {
  "author/plugin-name",
  opts = { },
}
```

##### Add language support
Edit `lua/config/lazy.lua`, add to spec:
```lua
{ import = "lazyvim.plugins.extras.lang.go" },
```
Or run `:LazyExtras` interactively.

##### Modify keybindings
Add to `lua/config/keymaps.lua`:
```lua
vim.keymap.set("n", "<leader>x", ":Command<CR>", { desc = "Description" })
```

#### Maintenance
- Update plugins: `:Lazy sync`
- Format config: `stylua .`
- Troubleshoot: `:checkhealth`

#### Notes
- Auto-saves on focus loss and after 4s of inactivity
- LSPs managed via Nix, not Mason
- Theme syncs with macOS appearance
