# Home configuration for tyrion@seasmoke (NixOS, x86_64-linux)
# Minimal setup for non-dev user
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
    ../modules/home/browsing
    ../modules/home/cli
    ../modules/home/terminal
    ../modules/home/desktop-apps
    ../modules/home/themes
    ../modules/home/window-managers
    ../modules/home/keyboard
  ];

  # User identity
  home.username = "tyrion";
  home.homeDirectory = "/home/tyrion";
  home.stateVersion = "23.05";

  # Basic shell setup
  programs.bash.bashrcExtra = ''
    echo "Welcome, Tyrion. You drink and you know things, but you don't rule here."
  '';
}
