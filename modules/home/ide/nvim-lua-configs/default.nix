# Lua-based Neovim configurations
# Symlinks Lua nvim configs to ~/.config/ for use with NVIM_APPNAME
#
# Configs managed here:
# - nvim-dragon: Minimal dragon config
# - nvim-lazy: LazyVim-based config
# - nvim-kickstart: Kickstart.nvim config
# - nvim-minimax: Minimax config
#
# These are used by wrapper scripts from nvim-wrappers.nix:
# - nvd -> NVIM_APPNAME=nvim-dragon
# - nvl -> NVIM_APPNAME=nvim-lazy
# - nvk -> NVIM_APPNAME=nvim-kickstart
# - nvm -> NVIM_APPNAME=nvim-minimax
{
  config,
  pkgs,
  lib,
  ...
}:
{
  # Symlink all Lua nvim configs to ~/.config/
  # Using xdg.configFile for proper home-manager integration
  xdg.configFile = {
    # nvim-dragon: Minimal dragon config
    "nvim-dragon" = {
      source = ./nvim-dragon;
      recursive = true;
    };

    # nvim-lazy: LazyVim-based config
    "nvim-lazy" = {
      source = ./nvim-lazy;
      recursive = true;
    };

    # nvim-kickstart: Kickstart.nvim config
    "nvim-kickstart" = {
      source = ./nvim-kickstart;
      recursive = true;
    };

    # nvim-minimax: Minimax config
    "nvim-minimax" = {
      source = ./nvim-minimax;
      recursive = true;
    };

    # nvim-meta: Meta config (if it exists)
    # "nvim-meta" = {
    #   source = ./nvim-meta;
    #   recursive = true;
    # };
  };
}
