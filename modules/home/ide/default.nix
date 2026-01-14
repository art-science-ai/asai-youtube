# IDE module - combines editor packages and configurations
# Provides:
# - packages.nix: LSP servers, formatters, linters (shared across all editors)
# - nvim-lua-configs: Lua-based nvim configs (nvim-dragon, nvim-lazy, etc.)
# - nvim-wrappers.nix: Wrapper scripts for Lua nvim configs
# - nixvim-nvchad.nix: Nixvim NvChad configuration (Nix-based)
# - nixvim-dragon: Nixvim Dragon configuration (Nix-based)
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ./packages.nix
    ./helix.nix
    ./nvim-lua-configs
    ./nvim-wrappers.nix
    ./nixvim-nvchad.nix
    ./nixvim-dragon
  ];
}
