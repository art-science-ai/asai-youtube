{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    myJellyfin.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Jellyfin media server";
    };
  };

  config = lib.mkIf config.myJellyfin.enable {
    # Jellyfin - Free software media system for streaming media
    # Purpose: Serve media content (movies, TV, music) to devices on the network
    # Accessible via Tailscale for remote streaming
    services.jellyfin = {
      enable = true;
      openFirewall = true;  # Opens TCP 8096 for web UI and streaming
    };

    # Enable FUSE for SSHFS support
    services.openssh.settings.AllowUsers = lib.mkAfter [ "jellyfin@sheepstealer" ];

    # SSHFS mount from sheepstealer for media library
    # Mounts media directory via systemd automount for on-demand access
    fileSystems."/mnt/media" = {
      device = "sheepstealer:/home/box_ring_fence/media";
      fsType = "fuse.sshfs";
      options = [
        "_netdev"
        "x-systemd.requires=network-online.target"
        "x-systemd.after=network-online.target"
        "connecttimeout=10"
        "reconnect"
        "idmap=user"
        "allow_other"
        "default_permissions"
        # Note: Add IdentityFile=path if using specific SSH key
        # Example: IdentityFile=/path/to/jellyfin_ssh_key
      ];
    };

    # Tailscale integration - allow Tailnet access to Jellyfin
    # This enables secure remote access to your media server from anywhere
    networking.firewall.trustedInterfaces = lib.mkAfter [ "tailscale0" ];
  };
}
