{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  # Session packages are automatically managed by desktop managers
  # GNOME sessions are provided by services.desktopManager.gnome.enable = true
  # Hyprland sessions are provided by programs.hyprland.enable = true

  # SDDM display manager (alternative to GDM)
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # Available sessions: "gnome", "hyprland"
  # Uncomment to force default; SDDM shows selector by default
  # services.displayManager.defaultSession = "gnome";
}