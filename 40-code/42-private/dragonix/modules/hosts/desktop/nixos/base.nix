# Base desktop infrastructure module for NixOS
# Provides common services and packages for all desktop environments
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  # Audio configuration (PipeWire)
  security.rtkit.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Bluetooth support
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Power management services (required for desktop environments like Noctalia)
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  # Font packages
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-color-emoji
    nerd-fonts.caskaydia-mono
  ];

  

  # Networking utilities
  services.resolved.enable = true;
  networking.networkmanager.enable = true;

   # Enable direnv system-wide
   programs.direnv.enable = true;

   # Enable 1Password system-wide
   programs._1password.enable = true;
   programs._1password-gui = {
     enable = true;
     # Required for:
     # - System authentication (fingerprint/password unlock) on GNOME
     # - Browser extension native messaging
     polkitPolicyOwners = [ "nikhilmaddirala" ];
   };

   # Allow 1Password browser extension for Zen browser
   # Firefox/Chrome/Brave are auto-configured, but Zen needs explicit allowlist
   environment.etc."1password/custom_allowed_browsers" = {
     text = ''
       zen
       zen-twilight
       zen-browser
       firefox
       chrome
       vivaldi-bin
       chromium
       msedge
     '';
     mode = "0755";
   };

  # Desktop environment packages
  environment.systemPackages = with pkgs; [
    # Note: Firefox is managed via Home Manager (see modules/home/browsing/browsers)
    chromium
    flatpak
    qemu
  ];

  # Graphics / X / Wayland
  services.xserver.enable = true;

  # XDG Portal configuration for both desktops
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk       # works well for GNOME
      xdg-desktop-portal-hyprland  # for Hyprland (handled by Hyprland config but included for completeness)
    ];
  };

}
