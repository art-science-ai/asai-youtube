# Hibernation support for Vermax desktop
# Enables hibernate to swap partition with power button trigger
#
# How it works:
# - Hibernate writes RAM contents to swap partition (/dev/sda2)
# - System powers off completely (survives power loss, no battery drain)
# - On boot, kernel reads resume image and restores full system state
# - All running processes, open files, terminal sessions preserved
#
# Usage:
# - Press power button briefly → hibernate
# - GNOME power menu → Hibernate option (requires extension, see gnome.nix)
# - Terminal: systemctl hibernate

{ lib, ... }:
{
  # Tell kernel where to find hibernation image on resume
  # Must match the swap partition defined in disk-config.nix
  boot.resumeDevice = "/dev/sda2";

  # Power button behavior
  # Override the desktop module's "ignore" setting
  services.logind.powerKey = lib.mkForce "hibernate";

  # Polkit rule to allow users in "users" group to hibernate without password
  # This enables the GNOME power menu hibernate option to work seamlessly
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id == "org.freedesktop.login1.hibernate" ||
          action.id == "org.freedesktop.login1.hibernate-multiple-sessions" ||
          action.id == "org.freedesktop.login1.handle-hibernate-key") {
        if (subject.isInGroup("users")) {
          return polkit.Result.YES;
        }
      }
    });
  '';
}
