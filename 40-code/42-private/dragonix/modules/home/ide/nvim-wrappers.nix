# Neovim config wrappers for Lua-based configurations
# Creates wrapper scripts that use system nvim with NVIM_APPNAME
# Provides consistent CLI interface: nvl, nvk, nvd, nvm, nvmeta
#
# Note: Nixvim configs (nxd, nxc) create their own wrappers in their
# respective modules (nixvim-dragon, nixvim-nvchad) to handle stylix
# integration and avoid binary name conflicts.
{
  config,
  pkgs,
  lib,
  ...
}:
let
  # Lua-based configs - dotfiles at ~/.config/$NVIM_APPNAME/
  # All use system nvim binary + system packages from PATH
  luaConfigs = {
    nvl = {
      appName = "nvim-lazy";
      description = "LazyVim-based config";
    };
    nvk = {
      appName = "nvim-kickstart";
      description = "Kickstart.nvim config";
    };
    nvd = {
      appName = "nvim-dragon";
      description = "Minimal dragon config (Lua)";
    };
    nvm = {
      appName = "nvim-minimax";
      description = "Minimax config";
    };
    nvmeta = {
      appName = "nvim-meta";
      description = "Meta config";
    };
  };

  # Generate wrapper script for a Lua config
  mkWrapper = name: { appName, description }:
    pkgs.writeShellScriptBin name ''
      # ${description}
      export NVIM_APPNAME="${appName}"
      exec ${pkgs.neovim}/bin/nvim "$@"
    '';

  # Generate all wrapper scripts
  wrapperPackages = lib.mapAttrsToList mkWrapper luaConfigs;
in
{
  # Install wrapper scripts for Lua configs
  # Nixvim wrappers (nxd, nxc) installed by their respective modules
  home.packages = wrapperPackages;

  # Optional: Set one as default editor
  # home.sessionVariables.EDITOR = "nvd";
}
