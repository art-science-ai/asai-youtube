# Neovim Configuration Architecture

Unified documentation for all Neovim configurations in this repository.

## Overview

This setup manages multiple Neovim configurations (both Lua and Nix-based) with:
- **Shared system packages** - All configs use LSPs, formatters, etc. from PATH
- **Unified wrappers** - Consistent CLI interface via wrapper scripts
- **Stylix integration** - Nixvim configs get automatic theming
- **Declarative management** - Everything tracked in the flake.

## Configuration Types

### 1. Lua-based Configs (`nvim-lua-configs/`)

Traditional Neovim configs using Lua, stored as dotfiles and symlinked by home-manager.

**Configs:**
- `nvim-dragon` → `nvd` - Minimal dragon config
- `nvim-lazy` → `nvl` - LazyVim-based config
- `nvim-kickstart` → `nvk` - Kickstart.nvim config
- `nvim-minimax` → `nvm` - Minimax config
- `nvim-meta` → `nvmeta` - Meta config

**How they work:**
```bash
nvd  # Runs: NVIM_APPNAME=nvim-dragon nvim
```
- Uses system `nvim` binary from nixpkgs
- Config read from `~/.config/nvim-dragon/` (symlinked from repo)
- Plugins managed by Lazy.nvim (runtime installation)
- State/data at `~/.local/state/nvim-dragon/`

**Managed by:**
- `nvim-lua-configs/default.nix` - Symlinks configs to `~/.config/`
- `nvim-wrappers.nix` - Creates wrapper scripts (nvd, nvl, nvk, etc.)

### 2. Nixvim Configs (Nix-based)

Declarative Neovim configs using the nixvim framework.

**Configs:**
- `nixvim-dragon` → `nxd` - Dragon config in Nix with stylix integration
- `nixvim-nvchad` → `nxc` - NvChad-like config in Nix

**How they work:**
```bash
nxd  # Runs: NVIM_APPNAME=nixvim-dragon /nix/store/.../nvim
```
- Uses **custom nvim binary** built by nixvim (in Nix store)
- Config **baked into the binary** at build time (no runtime config files)
- Plugins **pre-installed** in Nix store (declarative)
- State at `~/.local/state/nixvim-dragon/` (NVIM_APPNAME isolation)

**Why standalone instead of `programs.nixvim`?**

`programs.nixvim` is a **singleton** - you can only have ONE per home-manager config. We use standalone `makeNixvimWithModule` to support multiple nixvim configs alongside Lua configs.

**Stylix integration:**
```nix
nixvimDragon = nixvimDragonBase.extend config.stylix.targets.nixvim.exportedModule;
```

Standalone nixvim configs get stylix theming via the `exportedModule` option. See [Stylix docs](https://nix-community.github.io/stylix/options/modules/neovim.html).

**Managed by:**
- `nixvim-dragon/default.nix` - Config + wrapper creation
- `nixvim-nvchad.nix` - Config + wrapper creation

## Shared Packages (`packages.nix`)

All configs (Lua and Nixvim) share system packages via PATH:

**LSP Servers:**
- nil, nixd - Nix LSP
- lua-language-server - Lua LSP
- pyright - Python LSP
- typescript-language-server - TypeScript/JavaScript LSP
- rust-analyzer - Rust LSP
- marksman - Markdown LSP
- And more...

**Formatters:**
- nixfmt-rfc-style - Nix
- stylua - Lua
- prettier - JS/TS/JSON/YAML/Markdown
- black - Python
- rustfmt - Rust

**Tools:**
- tree-sitter - Grammar development
- neovim-remote - Remote control
- (ripgrep, fd, etc. from CLI module)

**Why shared packages?**
- No duplication across configs
- Consistent tool versions
- Single source of truth
- Reduced closure size

## Wrapper Scripts

All configs accessed via wrapper scripts for:
- Consistent interface (no brittle shell aliases)
- Work in all contexts (scripts, desktop entries, etc.)
- State isolation via NVIM_APPNAME

**Lua wrappers** (`nvim-wrappers.nix`):
```nix
mkWrapper = name: { appName, description }:
  pkgs.writeShellScriptBin name ''
    export NVIM_APPNAME="${appName}"
    exec ${pkgs.neovim}/bin/nvim "$@"
  '';
```

**Nixvim wrappers** (in their own modules):
```nix
pkgs.writeShellScriptBin "nxd" ''
  export NVIM_APPNAME=nixvim-dragon
  exec ${nixvimDragon}/bin/nvim "$@"
'';
```

## Directory Structure

```
modules/home/ide/
├── neovim.md                    # This file
├── packages.nix                 # Shared LSPs, formatters, tools
├── nvim-lua-configs/            # Lua-based configs
│   ├── default.nix              # Symlinks to ~/.config/
│   ├── nvim-dragon/             # Lua config files
│   ├── nvim-lazy/               # Lua config files
│   ├── nvim-kickstart/          # Lua config files
│   └── nvim-minimax/            # Lua config files
├── nvim-wrappers.nix            # Wrappers for Lua configs
├── nixvim-dragon/               # Nixvim config (Nix)
│   ├── default.nix              # Config + wrapper
│   ├── config/                  # Options, keymaps, autocmds, etc.
│   ├── plugins/                 # Plugin configs
│   ├── lua/                     # Lua code (ai-workflow.lua)
│   └── after/                   # Filetype-specific configs
└── nixvim-nvchad.nix            # Nixvim NvChad config (Nix)
```

## Adding a New Config

### Lua Config

1. **Add config directory:**
   ```bash
   mkdir modules/home/ide/nvim-lua-configs/nvim-newconfig
   # Add your init.lua, lua/, etc.
   ```

2. **Add symlink in `nvim-lua-configs/default.nix`:**
   ```nix
   "nvim-newconfig" = {
     source = ./nvim-newconfig;
     recursive = true;
   };
   ```

3. **Add wrapper in `nvim-wrappers.nix`:**
   ```nix
   nvn = {
     appName = "nvim-newconfig";
     description = "New config";
   };
   ```

### Nixvim Config

1. **Create module directory:**
   ```bash
   mkdir -p modules/home/ide/nixvim-newconfig/{config,plugins,lua}
   ```

2. **Create `default.nix` following nixvim-dragon pattern**

3. **Add to `ide/default.nix` imports:**
   ```nix
   imports = [
     # ...
     ./nixvim-newconfig
   ];
   ```

## Key Features

### AI Workflow Integration (nixvim-dragon)

Auto-save and auto-reload for seamless Claude Code integration:

**Auto-save triggers:**
- `FocusLost` - Save all buffers when switching to AI terminal
- `CursorHold` - Save current buffer after 250ms inactivity

**Auto-reload triggers:**
- `FocusGained` - Check for changes when switching back to nvim
- `BufEnter` - Check when entering a buffer
- `CursorHold` - Check on cursor idle

**Implementation:**
- `config/autocmds.nix` - Loads Lua from separate file
- `lua/ai-workflow.lua` - Actual autocmd logic (186 lines)
- Uses mini.notify for notifications with debouncing

### Stylix Theming (Nixvim only)

Nixvim configs automatically get colorscheme from stylix:
```nix
if config.stylix.enable or false
then nixvimDragonBase.extend config.stylix.targets.nixvim.exportedModule
else nixvimDragonBase;
```

Lua configs can read stylix colors manually if needed.

## Common Operations

**Switch configs:**
```bash
nvd file.txt    # Open with Lua dragon config
nxd file.txt    # Open with Nixvim dragon config
nvl file.txt    # Open with LazyVim config
```

**Rebuild after changes:**
```bash
# After modifying Lua configs (dotfiles)
home-manager switch  # Updates symlinks

# After modifying Nixvim configs (Nix)
home-manager switch  # Rebuilds nixvim packages
```

**Check autocmds (nixvim-dragon):**
```vim
:lua print(vim.inspect(vim.api.nvim_get_autocmds({group = "AutoSave"})))
```

## Troubleshooting

**Lua config not loading:**
- Check symlink: `ls -la ~/.config/nvim-dragon`
- Verify wrapper sets NVIM_APPNAME: `which nvd && cat $(which nvd)`

**Nixvim config not building:**
- Check stylix integration: `nix eval .#checks.x86_64-linux.home-nikhil-vermax`
- Verify no conflicting extraConfigLua merges

**Packages not found:**
- Check PATH includes home-manager packages
- LSPs should be in `ide/packages.nix`, not bundled with configs

**Autocmds missing (nixvim-dragon):**
- Verify `extraConfigLua` collection in `default.nix` (line 19)
- Check ai-workflow.lua exists and is readable

## Migration Notes

### From dotfiles/ to modules/

Lua configs were moved from `dotfiles/nvim-*/` to `modules/home/ide/nvim-lua-configs/` for:
- Declarative management via home-manager
- Version control in the flake
- Consistent organization with nixvim configs
- No more manual dotfile symlinking

### From programs.nixvim to standalone

Nixvim configs use standalone `makeNixvimWithModule` instead of `programs.nixvim` because:
- `programs.nixvim` is a singleton (only one allowed)
- We need multiple nixvim configs
- Stylix integration works via `exportedModule` for standalone

## References

- [NixVim Documentation](https://github.com/nix-community/nixvim)
- [Stylix Neovim Integration](https://nix-community.github.io/stylix/options/modules/neovim.html)
- [NVIM_APPNAME Documentation](https://tuckerchapman.com/til/nvim-appname-env/)
- [Home Manager File Management](https://nix-community.github.io/home-manager/options.html#opt-xdg.configFile)
