# Home configuration for rukmasen@vermax (NixOS, x86_64-linux)
# GNOME user with user-level Flatpak and app store experience
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ../modules/home/base.nix
  ];

  # User identity
  home.username = "rukmasen";
  home.homeDirectory = "/home/rukmasen";
  home.stateVersion = "23.05";

  
