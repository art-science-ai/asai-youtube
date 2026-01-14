# Fuzzel application launcher configuration
{ config, lib, pkgs, ... }:

{
  programs.fuzzel = {
    enable = true;
    package = pkgs.fuzzel;

    settings = {
      main = {
        # Terminal to use for launching applications
        terminal = "${pkgs.wezterm}/bin/wezterm";

        # Layer to render on (overlay is good for Wayland)
        layer = "overlay";

        # Font settings
        font = lib.mkForce "JetBrainsMono Nerd Font:size=12";

        # Icon theme (uses system icon theme)
        icon-theme = "Adwaita";

        # Show icons in results
        icons-enabled = true;

        # Number of lines to show
        lines = 15;

        # Width of the launcher
        width = 30;

        # Horizontal padding
        horizontal-pad = 8;

        # Vertical padding
        vertical-pad = 8;

        # Inner padding
        inner-pad = 8;
      };

      border = {
        # Border width
        width = 2;

        # Border radius
        radius = 8;
      };
    };
  };
}
