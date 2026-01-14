{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  # Flatpak service for app store functionality
  services.flatpak.enable = true;

  # Clean up system Flatpaks and remote, then set up per-user Flathub.
  systemd.services.flatpak-user-flathub = {
    description = "Clean up system Flatpaks, remove system remote, and configure per-user Flathub";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];

    path = [ pkgs.flatpak pkgs.util-linux ];
    serviceConfig.Type = "oneshot";

    script = ''
      set -eu

      echo "Uninstalling all system flatpaks..."
      flatpak uninstall --system --all --noninteractive || true

      echo "Removing system-wide Flathub remote..."
      flatpak --system remote-delete --force flathub || true

      for user in rukmasen guest; do
        if id "$user" >/dev/null 2>&1; then
          echo "Configuring user-level Flathub for $user..."
          runuser -l "$user" -c '
            flatpak --user remote-add --if-not-exists flathub \
              https://flathub.org/repo/flathub.flatpakrepo
          '
        fi
      done
    '';
  };
}