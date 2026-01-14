{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    myRemoteDesktop.gnomeRdp.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable GNOME Remote Desktop (RDP)";
    };
  };

  config = lib.mkIf config.myRemoteDesktop.gnomeRdp.enable {
    # Enable GNOME Remote Desktop service (system daemon mode)
    # Purpose: Remote login capability for headless access (like Windows RDP)
    # Why complex: NixOS lacks native options for gnome-remote-desktop config
    # See: https://github.com/NixOS/nixpkgs/issues/266774
    services.gnome.gnome-remote-desktop.enable = true;

    environment.systemPackages = with pkgs; [
      freerdp  # Provides winpr-makecert for TLS certificate generation
    ];

    # Disable user-level gnome-remote-desktop to avoid conflicts with system daemon
    # User daemon = session sharing (TeamViewer-like), System daemon = remote login
    systemd.user.services.gnome-remote-desktop = {
      enable = false;
    };

    systemd.services.gnome-remote-desktop = {
      wantedBy = [ "graphical.target" ];

      # Need coreutils (mkdir, rm, chown), freerdp (winpr-makecert)
      path = with pkgs; [ coreutils freerdp ];

      preStart = ''
        # Create certificates directory if it doesn't exist
        mkdir -p /var/lib/gnome-remote-desktop

        # Generate TLS certificates if they don't exist
        if [ ! -f /var/lib/gnome-remote-desktop/rdp-tls.crt ] || [ ! -f /var/lib/gnome-remote-desktop/rdp-tls.key ]; then
          echo "Generating RDP TLS certificates..."
          rm -f /var/lib/gnome-remote-desktop/rdp-tls.*
          ${pkgs.freerdp}/bin/winpr-makecert -silent -rdp -path /var/lib/gnome-remote-desktop rdp-tls
          chown gnome-remote-desktop:gnome-remote-desktop /var/lib/gnome-remote-desktop/rdp-tls.*
        fi
      '';

      postStart = ''
        # Wait for the service to be ready
        sleep 2

        # Configure RDP settings using grdctl
        # Note: grdctl uses pkexec which requires polkit and must run as root
        # Using absolute path to ensure we get the setuid wrapper
        export PATH="/run/wrappers/bin:$PATH"
        ${pkgs.gnome-remote-desktop}/bin/grdctl --system rdp set-tls-cert /var/lib/gnome-remote-desktop/rdp-tls.crt
        ${pkgs.gnome-remote-desktop}/bin/grdctl --system rdp set-tls-key /var/lib/gnome-remote-desktop/rdp-tls.key
        ${pkgs.gnome-remote-desktop}/bin/grdctl --system rdp enable
      '';
    };

    services.displayManager.autoLogin.enable = false;

    networking.firewall = {
      allowedTCPPorts = lib.mkAfter [ 3389 ];
      trustedInterfaces = lib.mkAfter [ "tailscale0" ];
    };
  };
}
