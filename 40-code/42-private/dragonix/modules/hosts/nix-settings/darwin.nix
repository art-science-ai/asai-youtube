{ config, lib, ... }:

{
  # Nix daemon configuration
  # On Darwin: disable if using Determinate Nix, otherwise enable vanilla Nix
  nix.enable = lib.mkDefault (!config.determinateNix.enable);

  # Garbage collection configuration for Darwin
  # Only enable if not using Determinate Nix (which has its own GC)
  nix.gc = lib.mkIf (!config.determinateNix.enable) {
    automatic = lib.mkDefault true;
    interval = lib.mkDefault {
      Weekday = 0;
      Hour = 2;
      Minute = 0;
    };
    options = lib.mkDefault "--delete-older-than 7d";
  };
}