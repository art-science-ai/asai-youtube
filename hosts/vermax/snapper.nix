# Snapper configuration for btrfs snapshots
# Provides automatic snapshot management for home and persist subvolumes
# Snapshots are stored in .snapshots within each subvolume
{ config, lib, ... }:
{
  # Enable Snapper service
  services.snapper = {
    # Enable automatic cleanup of old snapshots
    snapshotInterval = "hourly";

    configs = {
      # Home directory snapshots - protects user data
      home = {
        # Subvolume path to snapshot
        SUBVOLUME = "/home";

        # Where to store snapshots (.snapshots dir inside /home)
        # Users can browse /home/.snapshots to see historical versions
        ALLOW_USERS = [ "nikhilmaddirala" ];

        # Timeline snapshot settings
        TIMELINE_CREATE = true;
        TIMELINE_CLEANUP = true;

        # Retention policy for home directory
        # Keeps: 24 hourly, 7 daily, 4 weekly, 12 monthly
        TIMELINE_LIMIT_HOURLY = "24";
        TIMELINE_LIMIT_DAILY = "7";
        TIMELINE_LIMIT_WEEKLY = "4";
        TIMELINE_LIMIT_MONTHLY = "12";
        TIMELINE_LIMIT_YEARLY = "0";

        # Cleanup algorithm
        # "timeline" removes old snapshots based on age
        # "number" would limit total count instead
        TIMELINE_MIN_AGE = "1800"; # 30 minutes minimum age before cleanup
      };

      # Persist directory snapshots - protects system state and service data
      persist = {
        SUBVOLUME = "/persist";

        # Allow root to manage snapshots
        ALLOW_USERS = [ ];

        # Timeline snapshot settings
        TIMELINE_CREATE = true;
        TIMELINE_CLEANUP = true;

        # More conservative retention for persist (service data changes less frequently)
        # Keeps: 12 hourly, 7 daily, 4 weekly, 6 monthly
        TIMELINE_LIMIT_HOURLY = "12";
        TIMELINE_LIMIT_DAILY = "7";
        TIMELINE_LIMIT_WEEKLY = "4";
        TIMELINE_LIMIT_MONTHLY = "6";
        TIMELINE_LIMIT_YEARLY = "0";

        TIMELINE_MIN_AGE = "1800";
      };
    };
  };

  # NOTE: @root and @nix subvolumes are NOT snapshotted because:
  # - @root is ephemeral (wiped on boot via impermanence, when re-enabled)
  # - @nix is reproducible (can be rebuilt from configuration.nix)

  # IMPORTANT: When impermanence is re-enabled, uncomment this section
  # to ensure snapshot metadata survives @root wipes
  # environment.persistence."/persist" = lib.mkIf config.services.snapper.configs ? persist {
  #   directories = [
  #     # Snapper stores its snapshot metadata here
  #     "/persist/.snapshots"
  #     # Home snapshots are already on persistent @home subvolume
  #   ];
  # };
}
