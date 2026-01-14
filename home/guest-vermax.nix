# Home configuration for guest@vermax (NixOS, x86_64-linux)
# Minimal GNOME user with user-level Flatpak for basic app store experience
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
  home.username = "guest";
  home.homeDirectory = "/home/guest";
  home.stateVersion = "23.05";

  
