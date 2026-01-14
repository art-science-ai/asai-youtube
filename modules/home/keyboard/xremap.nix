# xremap configuration for GNOME macOS-style remapping
# User-specific configuration for nikhilmaddirala via home-manager

{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    inputs.xremap-flake.homeManagerModules.default
  ];

  config = lib.mkIf (!pkgs.stdenv.isDarwin) {
    services.xremap = {
      enable = true;
      withGnome = true;  # Required for GNOME/Wayland support

      # Load configuration from YAML file
      yamlConfig = builtins.readFile ./xremap.yml;
    };
  };
}
