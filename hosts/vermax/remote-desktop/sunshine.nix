{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    myRemoteDesktop.sunshine.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Sunshine remote desktop server";
    };
  };

  config = lib.mkIf config.myRemoteDesktop.sunshine.enable {
    services.sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;
      settings = {
        sunshine_name = "vermax";
        min_log_level = 2;

        # Performance preset prioritizes low latency
        global_preset = "performance";

        # High-quality streaming settings for retina display
        # These allow Moonlight to request higher resolutions
        encoder = "hevc"; # H.265 for better quality at same bitrate
        hevc_mode = 1; # 0=disabled, 1=enable, 2=only

        # Video quality settings
        # Bitrate in Kbps (30000 = 30 Mbps, good for 1440p over Tailscale)
        bitrate = 30000;

        # Allow client to request resolution up to 4K
        # Sunshine will create virtual framebuffer at requested resolution
        # Note: Sunshine accepts resolution strings in this format
        fps = "[30, 60, 120]";
      };
    };

    users.users.nikhilmaddirala.extraGroups = lib.mkAfter [
      "video"
      "render"
    ];

    networking.firewall.trustedInterfaces = lib.mkAfter [ "tailscale0" ];

    networking.firewall.allowedTCPPortRanges = lib.mkAfter [
      {
        from = 47984;
        to = 47990;
      }
    ];
    networking.firewall.allowedUDPPortRanges = lib.mkAfter [
      {
        from = 47998;
        to = 48010;
      }
    ];

    # GNOME settings to support higher resolutions via virtual displays
    # This allows Sunshine to capture at resolutions higher than physical display
    systemd.user.services.sunshine-display-setup = {
      description = "Configure GNOME for high-resolution Sunshine streaming";
      wantedBy = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = "${pkgs.writeShellScript "sunshine-display-setup" ''
          # Allow GNOME to use higher resolutions than physical display
          # This enables Sunshine to create virtual displays at retina resolutions
          ${pkgs.glib}/bin/gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"

          # Optional: You can also set a preferred mode for virtual displays here
          # using gnome-randr or similar tools if needed
        ''}";
      };
    };
  };
}
