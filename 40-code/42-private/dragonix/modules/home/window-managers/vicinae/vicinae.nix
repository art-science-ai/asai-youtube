# Vicinae configuration
{ config, lib, inputs, ... }:

{
  imports = [ inputs.vicinae.homeManagerModules.default ];

  services.vicinae = {
    enable = lib.mkDefault true;
    autoStart = lib.mkDefault true;

    settings = lib.mkDefault {
      # Use Google for favicon service (more reliable than twenty)
      faviconService = "google";

      # Font configuration
      font = {
        size = 11;
      };

      # Close behavior
      popToRootOnClose = true;

      # Search configuration
      rootSearch = {
        searchFiles = true;
      };

      # Theme configuration
      theme = {
        name = "vicinae-dark";
      };

      # Window configuration
      window = {
        csd = true;
        opacity = 0.95;
        rounding = 10;
      };
    };
  };
}