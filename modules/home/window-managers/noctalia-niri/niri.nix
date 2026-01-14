# Niri window manager configuration with Noctalia integration
{ config, lib, pkgs, inputs, ... }:

{
  imports = [ inputs.niri.homeModules.config ];

  programs.niri.package = pkgs.niri;  # Use same nixpkgs package as system for cache alignment

  programs.niri.settings = {
    spawn-at-startup = [
      { command = [ "noctalia-shell" ]; }
    ];

    binds = with config.lib.niri.actions; {
      # === NOCTALIA INTEGRATION ===
      # Noctalia launcher
      "Super+Space".action.spawn = [ "noctalia-shell" "ipc" "call" "launcher" "toggle" ];

      # Session menu
      "Super+Escape".action.spawn = [ "noctalia-shell" "ipc" "call" "sessionMenu" "toggle" ];

      # Volume controls
      "XF86AudioRaiseVolume".action.spawn = [ "noctalia-shell" "ipc" "call" "volume" "increase" ];
      "XF86AudioLowerVolume".action.spawn = [ "noctalia-shell" "ipc" "call" "volume" "decrease" ];
      "XF86AudioMute".action.spawn = [ "noctalia-shell" "ipc" "call" "volume" "muteOutput" ];

      # Brightness controls
      "XF86MonBrightnessUp".action.spawn = [ "noctalia-shell" "ipc" "call" "brightness" "increase" ];
      "XF86MonBrightnessDown".action.spawn = [ "noctalia-shell" "ipc" "call" "brightness" "decrease" ];

      # === WINDOW MANAGEMENT ===
      # Close window
      "Super+Q".action.spawn = [ "niri" "msg" "action" "close-window" ];

      # Toggle floating
      "Super+F".action.spawn = [ "niri" "msg" "action" "toggle-window-floating" ];

      # === NAVIGATION ===
      # Note: Directional focus actions not exposed by niri-flake
      # Use workspace navigation and overview instead

      # === WORKSPACES ===
      # Focus workspace
      "Super+1".action.spawn = [ "niri" "msg" "action" "focus-workspace" "1" ];
      "Super+2".action.spawn = [ "niri" "msg" "action" "focus-workspace" "2" ];
      "Super+3".action.spawn = [ "niri" "msg" "action" "focus-workspace" "3" ];
      "Super+4".action.spawn = [ "niri" "msg" "action" "focus-workspace" "4" ];
      "Super+5".action.spawn = [ "niri" "msg" "action" "focus-workspace" "5" ];
      "Super+6".action.spawn = [ "niri" "msg" "action" "focus-workspace" "6" ];
      "Super+7".action.spawn = [ "niri" "msg" "action" "focus-workspace" "7" ];
      "Super+8".action.spawn = [ "niri" "msg" "action" "focus-workspace" "8" ];
      "Super+9".action.spawn = [ "niri" "msg" "action" "focus-workspace" "9" ];

      # Move window to workspace
      "Super+Shift+1".action.spawn = [ "niri" "msg" "action" "move-window-to-workspace" "1" ];
      "Super+Shift+2".action.spawn = [ "niri" "msg" "action" "move-window-to-workspace" "2" ];
      "Super+Shift+3".action.spawn = [ "niri" "msg" "action" "move-window-to-workspace" "3" ];
      "Super+Shift+4".action.spawn = [ "niri" "msg" "action" "move-window-to-workspace" "4" ];
      "Super+Shift+5".action.spawn = [ "niri" "msg" "action" "move-window-to-workspace" "5" ];
      "Super+Shift+6".action.spawn = [ "niri" "msg" "action" "move-window-to-workspace" "6" ];
      "Super+Shift+7".action.spawn = [ "niri" "msg" "action" "move-window-to-workspace" "7" ];
      "Super+Shift+8".action.spawn = [ "niri" "msg" "action" "move-window-to-workspace" "8" ];
      "Super+Shift+9".action.spawn = [ "niri" "msg" "action" "move-window-to-workspace" "9" ];

      # === APPLICATIONS ===
      # Spawn terminal (wezterm)
      "Super+Return".action.spawn = [ "wezterm" ];

      # Spawn launcher (fuzzel - recommended lightweight Wayland launcher)
      "Super+D".action.spawn = [ "fuzzel" ];

      # === SPECIAL FEATURES ===
      # Toggle overview
      "Super+O".action = toggle-overview;

       # Screenshot (using niri msg since action not exposed by niri-flake)
       "Super+S".action.spawn = [ "niri" "msg" "action" "screenshot" ];

       # Screenshot window (using niri msg since action not exposed by niri-flake)
       "Super+Shift+S".action.spawn = [ "niri" "msg" "action" "screenshot-window" ];

      # Screenshot screen (using niri msg since action not exposed by niri-flake)
      "Super+Ctrl+S".action.spawn = [ "niri" "msg" "action" "screenshot-screen" ];

      # === DEBUGGING ===
       # Show hotkey overlay (help)
       "Super+Shift+Slash".action.spawn = [ "niri" "msg" "action" "show-hotkey-overlay" ];
      };
    };
}
