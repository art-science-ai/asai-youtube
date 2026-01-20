# Google Drive integration via rclone
# Fully imperative setup - see README.md for configuration details
{
  config,
  lib,
  pkgs,
  ...
}:
let
  gdrivePath = config.home.homeDirectory + "/cloud-storage/gdrive";
in
{
  home.packages = [ pkgs.rclone ];

  # Systemd user service for mounting Google Drive
  systemd.user.services.rclone-gdrive = {
    Unit = {
      Description = "Rclone Google Drive Mount";
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
    };

    Service = {
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p ${gdrivePath}";
      ExecStart =
        "${pkgs.rclone}/bin/rclone mount gdrive: ${gdrivePath}"
        + " --vfs-cache-mode full"
        + " --vfs-cache-max-age 24h"
        + " --vfs-cache-max-size 10G"
        + " --log-level INFO";
      ExecStop = "${pkgs.fuse}/bin/fusermount -u ${gdrivePath}";
      Restart = "on-failure";
      RestartSec = "5s";
    };

    Install.WantedBy = [ "default.target" ];
  };
}
