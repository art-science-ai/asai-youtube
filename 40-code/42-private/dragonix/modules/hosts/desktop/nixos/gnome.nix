{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  # GNOME desktop
  services.desktopManager.gnome = {
    enable = true;
    extraGSettingsOverrides = ''
      [org/gnome/desktop/session]
      idle-delay=uint32 300

      [org/gnome/settings-daemon/plugins/power]
      sleep-inactive-ac-type='blank'
      sleep-inactive-ac-timeout=uint32 600
      sleep-inactive-battery-type='blank'
      sleep-inactive-battery-timeout=uint32 300
    '';

    extraGSettingsOverridePackages = [
      pkgs.gsettings-desktop-schemas
    ];
  };

  services.gnome.gnome-software.enable = true;

  # Allow browser/Extension Manager to install per-user extensions.
  services.gnome.gnome-browser-connector.enable = true;

  # GNOME-specific packages
  environment.systemPackages = with pkgs; [
    gnome-software
    gnome-extension-manager
    gnome-tweaks
  ];

   # dconf is required for GNOME settings to apply correctly.
   programs.dconf.enable = true;

   # Include all default GNOME applications
   environment.gnome.excludePackages = [ ];

   # Power management configuration
   # - Display blanks after 5min idle, off after 10min on AC (system-wide GNOME settings)
   # - Sleep/suspend disabled completely
   # - Hibernate only on power key long press
   services.logind.settings.Login = {
     HandleLidSwitch = "ignore";
     HandleLidSwitchExternalPower = "ignore";
     HandlePowerKey = "ignore";                # Short press: do nothing
     HandlePowerKeyLongPress = "hibernate";    # Long press: hibernate
     IdleAction = "ignore";                    # GNOME manages display blanking
   };

   # Disable sleep modes, but allow hibernation for power key long press
   systemd.sleep.extraConfig = ''
     AllowSuspend=no
     AllowHybridSleep=no
     AllowSuspendThenHibernate=no
   '';
}