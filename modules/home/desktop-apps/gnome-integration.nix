# GNOME desktop integration - automatic launcher updates
# Creates symlinks from Nix profile desktop files to writable local directory
# so GNOME can detect new applications without shell restart
{ config, pkgs, lib, ... }:

let
  cfg = config.programs.gnome-desktop-integration;
in
{
  options.programs.gnome-desktop-integration = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable automatic GNOME launcher updates for Home Manager apps";
    };
  };

  config = lib.mkIf cfg.enable {
    home.activation.gnomeDesktopIntegration = lib.hm.dag.entryAfter ["writeBoundary"] ''
      # GNOME Desktop Integration - runs on every home-manager switch
      # Create writable applications directory and symlink Nix desktop files

      echo "🔗 Updating GNOME desktop applications..."

      # Create writable applications directory
      mkdir -p ~/.local/share/applications

      # Remove broken symlinks from previous runs (cleanup)
      find ~/.local/share/applications -type l -broken 2>/dev/null | xargs rm -f 2>/dev/null || true

      # Remove old symlinks to prevent stale entries
      find ~/.local/share/applications -type l -lname "*/.nix-profile/*" 2>/dev/null | xargs rm -f 2>/dev/null || true

      # Create symlinks to all desktop files in Nix profile
      if [ -d ~/.nix-profile/share/applications ]; then
        find ~/.nix-profile/share/applications -name "*.desktop" -exec ln -sf {} ~/.local/share/applications/ \; 2>/dev/null || true
      fi

      # Update desktop database in writable location
      # This makes MIME types and other metadata available to GNOME
      if command -v update-desktop-database >/dev/null 2>&1; then
        update-desktop-database ~/.local/share/applications 2>/dev/null || true
      fi

      echo "✅ GNOME desktop applications updated"
    '';
  };
}