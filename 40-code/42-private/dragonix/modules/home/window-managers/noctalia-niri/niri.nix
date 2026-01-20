# Niri window manager configuration with Noctalia integration
# Default config pinned to niri v25.08
# https://github.com/YaLTeR/niri/blob/01be0e65f4eb91a9cd624ac0b76aaeab765c7294/resources/default-config.kdl

{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [ inputs.niri.homeModules.config ];

  programs.niri.package = pkgs.niri; # Use same nixpkgs package as system for cache alignment

  programs.niri.config = builtins.readFile ./default-config.kdl;
}
