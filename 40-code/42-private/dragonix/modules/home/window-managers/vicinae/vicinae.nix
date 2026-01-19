# ============================================================================
# VICINAE - Modern Application Launcher for GNOME
# ============================================================================
#
# Vicinae is a fast, fuzzy-search launcher for applications and files.
# Alternative to rofi/wofi with beautiful UI and plugin support.
#
# Current Status:
#   ✅ Service running and CLI working
#   ❌ Super+Space keybinding NOT working (known issue - see notes below)
#
# Quick Start:
#   vicinae toggle   # Open launcher (run in terminal)
#   Type "clip"       # Search clipboard history (once open)
#
# TODO: Fix Super+Space keybinding - see INTEGRATION NOTES below
# Help: https://vicinae.com/docs
# ============================================================================

{ config, lib, inputs, ... }:

{
  # Import vicinae's home-manager module from flake input
  imports = [ inputs.vicinae.homeManagerModules.default ];

  # ============================================================
  # VICINAE SERVICE CONFIGURATION
  # ============================================================

  services.vicinae = {
    # Enable vicinae launcher (runs in background)
    enable = lib.mkDefault true;

    # Auto-start on login
    autoStart = lib.mkDefault true;

    # Main configuration settings
    settings = lib.mkDefault {
      # Favicon service: Use Google (more reliable than twenty.com)
      faviconService = "google";

      # Font size for search results
      font = {
        size = 11;
      };

      # Close behavior: Return to root when closing sub-menus
      popToRootOnClose = true;

      # Search scope: Include files in addition to applications
      rootSearch = {
        searchFiles = true;
      };

      # Visual theme: Dark mode
      theme = {
        name = "vicinae-dark";
      };

      # Window appearance
      window = {
        csd = true;           # Client-side decorations (custom title bar)
        opacity = 0.95;       # Slightly transparent
        rounding = 10;        # Rounded corners
      };
    };
  };

  # ============================================================
  # INTEGRATION NOTES & KNOWN ISSUES
  # ============================================================
  #
  # Current Status:
  #   ✅ Vicinae service: Running (systemd --user)
  #   ✅ CLI commands: Working (vicinae toggle, show, etc.)
  #   ❌ Keybinding (Super+Space): NOT WORKING - see below
  #
  # Keybinding Problem:
  #   Super+Space shortcut doesn't open vicinae, even though:
  #   - Custom keybinding configured in gnome.nix
  #   - Conflicting switch-input-source binding removed
  #   - Path mismatch fixed (/vicinae/ → /vicinae)
  #
  #   The `vicinae toggle` command works in terminal, but the
  #   keyboard shortcut doesn't trigger it. Likely issues:
  #   1. GNOME not loading custom keybinding properly
  #   2. PaperWM or another extension intercepting the key
  #   3. dconf settings not applied after rebuild
  #
  # Temporary Workaround:
  #   Run manually in terminal: vicinae toggle
  #   Or: vicinae show
  #
  # Next Steps to Fix:
  #   1. Verify dconf: gsettings list-recursively \
  #      org.gnome.settings-daemon.plugins.media-keys.custom-keybindings
  #   2. Check for conflicting bindings in GNOME Shell extensions
  #   3. Try vicinae's built-in hotkey configuration
  #   4. Consider alternative keybinding approach
  #
  # Clipboard Manager:
  #   Using vicinae's built-in clipboard (via GNOME extension)
  #   Access: Open vicinae → Type "clip" or "clipboard"
  #
  # Window Manager (PaperWM):
  #   Vicinae should float centered, not tile
  #   Configure manually: Super+Alt+. → Window Rules → Add vicinae rule
  #   - App ID: vicinae
  #   - Scale: Free
  #   - Open Center: enabled
  #
  # Service Management:
  #   systemctl --user status vicinae
  #   systemctl --user restart vicinae
  #   pkill vicinae  (if duplicate processes)
  #
  # Alternative: CopyQ integration (commented out - using vicinae clipboard instead)
}