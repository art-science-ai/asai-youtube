# Nixvim-based nvim-dragon configuration
# Minimal Neovim configuration based on nvim-dragon dotfiles
# 100% declarative Nix configuration - no Lua files!
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
let
  # Import all config modules from config directory
  configFiles = builtins.filter (file: lib.strings.hasSuffix ".nix" file)
    (builtins.attrNames (builtins.readDir ./config));
  configModules = map (file: import (./config + "/${file}")) configFiles;
  # Collect keymaps from config modules before merging (to avoid overwriting)
  configKeymaps = lib.concatLists (map (mod: mod.keymaps or []) configModules);
  # Collect extraConfigLua from config modules before merging (to avoid overwriting)
  configExtraLua = lib.filter (x: x != "") (map (mod: mod.extraConfigLua or "") configModules);
  # Merge remaining attributes (without keymaps and extraConfigLua)
  configAttrs = lib.foldl (acc: mod: acc // (builtins.removeAttrs mod ["keymaps" "extraConfigLua"])) {} configModules;

  # Import all after modules from after directory
  afterFiles = builtins.filter (file: lib.strings.hasSuffix ".nix" file)
    (builtins.attrNames (builtins.readDir ./after));
  afterModules = map (file: import (./after + "/${file}")) afterFiles;
  afterAttrs = lib.foldl (acc: mod: acc // mod) {} afterModules;

  # Import all plugin modules from plugins directory
  pluginFiles = builtins.filter (file: lib.strings.hasSuffix ".nix" file)
    (builtins.attrNames (builtins.readDir ./plugins));
  pluginModules = map (file: import (./plugins + "/${file}")) pluginFiles;
  plugins = lib.foldl (acc: mod: acc // (mod.plugins or mod)) {} pluginModules;

  # Collect keymaps from plugins
  keymapsExtra = lib.concatLists (map (mod: mod.keymaps or []) pluginModules);

  # Collect all extraConfigLua from all modules
  allExtraConfigLua = lib.filter (x: x != "") (
    configExtraLua ++
    (map (mod: mod.extraConfigLua or "") pluginModules) ++
    [ (afterAttrs.extraConfigLua or "") ]
  );
  extraConfigLua = lib.concatStringsSep "\n\n" allExtraConfigLua;

  # Remove keymaps and extraConfigLua from configAttrs since we handle them separately
  # (already removed during merge above, but keep for clarity)
  configAttrsWithoutSpecial = configAttrs;
  afterAttrsWithoutSpecial = builtins.removeAttrs afterAttrs [ "extraConfigLua" ];

  # Complete nixvim configuration
  nvimConfig = {
    # Import our modular configuration
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
    keymaps = configKeymaps ++ keymapsExtra;

    # All plugins
    plugins = plugins;

    # Concatenated extraConfigLua from all modules
    extraConfigLua = extraConfigLua;
  } // configAttrsWithoutSpecial // afterAttrsWithoutSpecial;

  # Create standalone nixvim package
  # Uses standalone approach because:
  # 1. programs.nixvim is a singleton (can only have ONE)
  # 2. We want multiple nixvim configs (dragon, nvchad, etc.)
  # 3. Stylix integration works via exportedModule for standalone
  nixvimDragonBase = inputs.nixvim.legacyPackages.${pkgs.system}.makeNixvimWithModule {
    inherit pkgs;
    module = nvimConfig;
  };

  # Extend with stylix theming if available
  # See: https://nix-community.github.io/stylix/options/modules/neovim.html
  nixvimDragon =
    if config.stylix.enable or false
    then nixvimDragonBase.extend config.stylix.targets.nixvim.exportedModule
    else nixvimDragonBase;
  # Create wrapper script
  # Sets NVIM_APPNAME for state isolation at ~/.local/state/nixvim-dragon
  nxdWrapper = pkgs.writeShellScriptBin "nxd" ''
    # Nixvim dragon config with stylix integration
    # Uses system packages (ripgrep, fd, etc.) from PATH
    export NVIM_APPNAME=nixvim-dragon
    exec ${nixvimDragon}/bin/nvim "$@"
  '';
in
{
  # Install wrapper script (not the nixvim package directly)
  # This avoids binary name conflicts with other nixvim configs
  home.packages = [ nxdWrapper ];
}