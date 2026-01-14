{ config, pkgs, ... }:

{
  config = {
    # Allow unfree packages (needed for 1Password, etc.)
    nixpkgs.config.allowUnfree = true;

    # Base system packages shared across all hosts
    environment.systemPackages = with pkgs; [
      mosh
      podman
      nixos-rebuild
    ];
  };
}