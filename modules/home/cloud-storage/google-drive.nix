{ config, lib, pkgs, ... }:

{
  programs.rclone = {
    enable = true;

    # Google Drive mount configuration
    #
    # OAuth credentials are managed imperatively via rclone.conf.
    # Home Manager only manages the remote type, mount point, and systemd service.
    #
    # ONE-TIME SETUP: Run `rclone config` and use these settings:
    #
    #   1. Choose: e (Edit existing remote)
    #   2. Select: gdrive
    #   3. client_id> (leave blank to use rclone's default)
    #   4. client_secret> (leave blank to use rclone's default)
    #   5. scope> drive (Full access to all files)
    #   6. service_account_file> (leave blank)
    #   7. Edit advanced config? n
    #   8. Use web browser to automatically authenticate? y
    #      (this opens browser for Google OAuth)
    #   9. Configure this as a Shared Drive? n
    #
    # The OAuth tokens are appended to the [gdrive] section in ~/.config/rclone/rclone.conf
    # and will persist across home-manager rebuilds.
    remotes.gdrive = {
      # Minimal config required by Home Manager - only declares the remote type
      # All OAuth settings (client_id, token, etc.) are added imperatively via rclone config
      config = {
        type = "drive";
      };

      # Mount the root of gdrive to ~/GDrive
      mounts."".enable = true;
      mounts."".mountPoint = "%h/GDrive";
      mounts."".logLevel = "INFO";
      mounts."".options = {
        vfs-cache-mode = "full";
        vfs-cache-max-age = "24h";
        vfs-cache-max-size = "10G";
        vfs-read-ahead = "128M";
      };
    };
  };
}
