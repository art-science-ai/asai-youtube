# Home configuration for nikhilmaddirala@meleys (macOS, aarch64-darwin)
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
    ../modules/home/browsing
    ../modules/home/cli
    ../modules/home/cloud-storage
    ../modules/home/terminal
    ../modules/home/desktop-apps
    ../modules/home/themes
    ../modules/home/macos-user-settings.nix
    ../modules/home/ide
    ../modules/home/ai
    ../modules/home/window-managers
    ../modules/home/keyboard
  ];

  # User identity
  home.username = "nikhilmaddirala";
  home.homeDirectory = "/Users/nikhilmaddirala";
  home.stateVersion = "23.05";

  # Desktop configuration
  isDesktop = true;
}
