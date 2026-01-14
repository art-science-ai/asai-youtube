{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    myRemoteDesktop.xrdp.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable XRDP for remote desktop access";
    };
  };

  config = lib.mkIf config.myRemoteDesktop.xrdp.enable {
    # XRDP - Alternative RDP implementation with native NixOS support
    # Purpose: Remote login capability for headless access (like Windows RDP)
    # Simpler than gnome-remote-desktop with full declarative configuration
    services.xrdp = {
      enable = true;
      defaultWindowManager = "${pkgs.gnome-session}/bin/gnome-session";
      openFirewall = true;  # Opens TCP 3389
    };

    # Prevent system from sleeping during remote sessions
    systemd.targets.sleep.enable = false;
    systemd.targets.suspend.enable = false;
    systemd.targets.hibernate.enable = false;
    systemd.targets.hybrid-sleep.enable = false;

    # Additional sleep prevention via logind
    services.logind.settings.Login.HandleLidSwitch = "ignore";

    # Disable auto-login for security (same as gnome-rdp)
    services.displayManager.autoLogin.enable = false;

    # Tailscale integration (same pattern as other remote desktop modules)
    networking.firewall.trustedInterfaces = lib.mkAfter [ "tailscale0" ];
  };
}
