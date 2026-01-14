{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  # GDM display manager with Wayland support
  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  # Session packages are automatically managed by desktop managers
  # GNOME sessions are provided by services.desktopManager.gnome.enable = true
  # Hyprland sessions are provided by programs.hyprland.enable = true

  # GDM login screen configuration to show users
  services.displayManager.gdm.settings = {
    General = {
      disable-user-list = false;  # Show user list instead of manual entry
    };
  };

  # Default session to hide session selector (gear icon)
  # services.displayManager.defaultSession = "gnome";
}
