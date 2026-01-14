# Home configuration for nikhilmaddirala@seasmoke (NixOS, x86_64-linux)
# Self-contained user-host pair configuration
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
    ../modules/home/auth
    # ../modules/home/browsing
    ../modules/home/cli
    ../modules/home/cloud-storage
    ../modules/home/terminal
    # ../modules/home/desktop-apps
    ../modules/home/themes
    ../modules/home/ide
    # ../modules/home/window-managers
    ../modules/home/keyboard
  ];

  # User identity
  home.username = "nikhilmaddirala";
  home.homeDirectory = "/home/nikhilmaddirala";
  home.stateVersion = "23.05";

  # Server configuration (headless, no GUI)
  isDesktop = false;
}
