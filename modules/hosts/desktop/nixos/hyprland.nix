{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  # Hyprland session
  programs.hyprland = {
    enable = true;      # provides a Hyprland Wayland session for the DM
    xwayland.enable = true;
    # Using stable nixpkgs version to avoid compilation issues with GCC 15.2.0
    # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = pkgs.xdg-desktop-portal-hyprland; # Use stable nixpkgs version to fix Qt version mismatch
  };
}