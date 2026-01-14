# Syncthing - Continuous file synchronization
# https://github.com/syncthing/syncthing
#
# Declarative configuration:
# - Folder structure and ignore patterns (managed here)
# - Device pairing (imperative via Web UI, optional to make declarative)
# See: modules/home/cloud-storage/README.md for setup instructions
{ config, lib, pkgs, ... }:
{
  services.syncthing = {
    enable = true;
    overrideFolders = true;

    settings = {
      folders = {
        "monorepo" = {
          path = "${config.home.homeDirectory}/repos/monorepo";
          label = "monorepo";
          ignorePatterns = [
            # Build artifacts
            "node_modules/"
            "target/"
            "dist/"

            # Sync conflicts
            ".sync-conflict-*"

            # Git locks
            ".git/*.lock"

            # Obsidian workspace (machine-specific)
            ".obsidian/workspace.json"
          ];
          # Device IDs added imperatively via Web UI during initial setup
          # After pairing, optionally add devices declaratively:
          # devices = [ "vermax" "seasmoke" "meleys" "moondancer" ];
          devices = [ ];
        };
      };
    };
  };

  # Automatically start systemd user services
  systemd.user.startServices = true;
}
