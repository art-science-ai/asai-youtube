{ lib, ... }:

{
  # Nix daemon is always enabled on NixOS
  nix.enable = true;

  # Garbage collection configuration for Linux
  nix.gc = {
    automatic = lib.mkDefault true;
    options = lib.mkDefault "--delete-older-than 7d";
  };
}