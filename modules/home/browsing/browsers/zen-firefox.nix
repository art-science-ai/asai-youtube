{ config, lib, inputs, ... }:

{
  # Browser installations
  # ---
  # Zen (Twilight variant) - primary browser
  imports = [
    inputs.zen-browser.homeModules.twilight
  ];
  programs.zen-browser = {
    enable = true;
    profiles.default = {
      id = 0;
      # No settings here - everything handled by Firefox Sync
      # Configure preferences, add-ons, bookmarks, etc. in the browser UI
    };
  };

  # Firefox - secondary/backup browser
  # Uses the same Firefox Sync account as Zen
  programs.firefox = {
    enable = true;
    profiles.default = {
      id = 0;
      # No settings here - everything handled by Firefox Sync
      # Configure preferences, add-ons, bookmarks, etc. in the browser UI
    };
  };

  # Stylix integration
  # Tell Stylix which browser profiles exist
  stylix.targets = {
    firefox.profileNames = [ "default" ];
    zen-browser.profileNames = [ "default" ];
  };

  # System integration
  # ---
  # Set Zen as the default browser (MIME type associations)
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "zen-twilight.desktop";
      "x-scheme-handler/http" = "zen-twilight.desktop";
      "x-scheme-handler/https" = "zen-twilight.desktop";
      "x-scheme-handler/about" = "zen-twilight.desktop";
      "x-scheme-handler/unknown" = "zen-twilight.desktop";
    };
  };

  # Note: 1Password browser integration is configured at the NixOS system level
  # See modules/hosts/desktop/nixos/base.nix for programs._1password configuration
}
