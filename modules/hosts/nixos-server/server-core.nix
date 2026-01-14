# Server baseline configuration
# SSH, monitoring, firewall, containers, Docker, and server-specific settings
{
  config,
  pkgs,
  lib,
  ...
}:
{
  # Enable SSH service for remote management
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  # Enable mosh (mobile shell) for better roaming and intermittent connections
  programs.mosh.enable = true;

  # Container runtime support
  # Use Podman with Docker compatibility for container management
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      autoPrune = {
        enable = true;
        dates = "daily";
        flags = [
          "--all"
          "--filter=until=48h"
          "--filter=label!=important"
        ];
      };
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # Enable Podman API service for container monitoring
  systemd.services.podman.enable = true;
  systemd.sockets.podman.enable = true;

  # Server-specific packages
  environment.systemPackages = with pkgs; [
    ponysay
    postgresql
    sqlite
    pgcli
    litecli
    podman-compose
    python3Packages.podman
    mosh # Mobile shell client for better roaming support
  ];

  # Basic firewall configuration
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ]; # SSH
    allowedUDPPortRanges = [
      {
        from = 60000;
        to = 61000;
      } # Mosh (UDP range for connections)
    ];
  };

  # Enable automatic updates
  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
  };

  # Nix garbage collection - aggressive cleanup for servers
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 3d";
  };

  # Optimize Nix store weekly to reclaim hard-link savings
  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };

  # Enable passwordless sudo for wheel group
  security.sudo.wheelNeedsPassword = false;

  # Enable systemd user lingering for persistent user services
  # This allows user services (like rootless Podman containers) to run without an active login session
  users.users.nikhilmaddirala.linger = true;

  # Comprehensive Podman cleanup - removes orphaned storage layers
  # This catches what autoPrune misses (build cache, orphaned layers, volumes)
  systemd.services.podman-system-cleanup = {
    description = "Deep clean Podman system storage";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.podman}/bin/podman system prune --all --force --volumes";
    };
  };

  systemd.timers.podman-system-cleanup = {
    description = "Run Podman system cleanup weekly";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "weekly";
      Persistent = true;
    };
  };

  # Aggressive journal cleanup - limit journal size
  services.journald.extraConfig = ''
    SystemMaxUse=500M
    MaxRetentionSec=7day
    MaxFileSec=1day
  '';

  # tmpfs for truly ephemeral data (cleared on reboot)
  # Reduces wear on disk and ensures fresh start
  fileSystems."/tmp" = {
    device = "tmpfs";
    fsType = "tmpfs";
    options = [ "defaults" "size=2G" "mode=1777" ];
  };

  fileSystems."/var/tmp" = {
    device = "tmpfs";
    fsType = "tmpfs";
    options = [ "defaults" "size=1G" "mode=1777" ];
  };
}
