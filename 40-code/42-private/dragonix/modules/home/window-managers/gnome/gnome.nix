# Personal GNOME config for nikhilmaddirala (declarative extensions, no Flathub).
{
  config,
  lib,
  pkgs,
  ...
}:
{
  # ===========================================
  # === Extensions ===
  # ===========================================


  home.packages = with pkgs; [
    gnomeExtensions.dash-to-dock
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.hibernate-status-button
  ];

  xdg.configFile."gnome-shell/extensions/PaperWM@paperwm.github.com/stylesheet.css".text = ''
    /* PaperWM Custom Border Highlights - Catppuccin Accent Colors */

    /* Focused window border - Mauve accent (primary) */
    .paperwm-window-tile:focus {
      border: 2px solid #cba6f7;
      box-shadow: 0 0 10px rgba(203, 166, 247, 0.5);
    }

    /* Unfocused window border - Lavender (subtle) */
    .paperwm-window-tile:not(:focus) {
      border: 1px solid rgba(180, 190, 254, 0.3);
    }

    /* Tile preview when dragging/rearranging - Sky */
    .tile-preview {
      background-color: rgba(137, 220, 235, 0.2);
      border: 2px dashed #89dceb;
    }

    /* Active workspace indicator - Mauve */
    .paperwm-workspace:focus .paperwm-workspace-bar {
      background-color: #cba6f7;
    }

    /* Scratch window (popup) highlight - Pink */
    .paperwm-scratch-window {
      border: 2px solid #f5c2e7;
      box-shadow: 0 0 15px rgba(245, 194, 231, 0.6);
    }

    /* Monitor border - Sapphire */
    .paperwm-monitor-tiling {
      outline: 1px solid rgba(116, 199, 236, 0.2);
    }
  '';

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "vivaldi-stable.desktop";
      "x-scheme-handler/http" = "vivaldi-stable.desktop";
      "x-scheme-handler/https" = "vivaldi-stable.desktop";
      "x-scheme-handler/about" = "vivaldi-stable.desktop";
      "x-scheme-handler/unknown" = "vivaldi-stable.desktop";
    };
  };

  dconf.settings = {
    # ===========================================
    # ===========================================

    # GNOME Shell
    ## Core shell settings and enabled extensions

    # ===========================================
    # ===========================================

    "org/gnome/shell" = {
      enabled-extensions = [
        "dash-to-dock@micxgx.gmail.com"
        "appindicatorsupport@rgcjonas.gmail.com"
        "blur-my-shell@aunetx"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "paperwm@paperwm.github.com"
        "hibernate-status-button@dromi"
      ];
      attach-modal-dialogs = false;
    };

    # ===========================================
    # ===========================================

    # Desktop UI
    ## Desktop interface settings

    # ===========================================
    # ===========================================

    "org/gnome/desktop/interface" = {
      clock-show-date = true;
    };

    # ===========================================
    # ===========================================

    # WM Keybindings
    ## Window manager keybindings (mix of defaults and custom overrides)
    ## Default: https://gitlab.gnome.org/GNOME/gsettings-desktop-schemas

    # ===========================================
    # ===========================================

    "org/gnome/desktop/wm/keybindings" = {
      minimize = [ "<Super>m" ];
      switch-to-workspace-left = [ ];
      switch-to-workspace-right = [ ];

      close = [ "<Alt>F4" ];
      maximize = [ ];
      unmaximize = [ ];
      begin-move = [ "<Alt>F7" ];
      begin-resize = [ "<Alt>F8" ];
      toggle-maximized = [ "<Alt>F10" ];
      switch-to-workspace-1 = [ "<Super>Home" ];
      switch-to-workspace-up = [ "<Control><Alt>Up" ];
      switch-to-workspace-down = [ "<Control><Alt>Down" ];
      switch-to-workspace-last = [ "<Super>End" ];
      switch-group = [
        "<Super>Above_Tab"
        "<Alt>Above_Tab"
      ];
      switch-group-backward = [
        "<Shift><Super>Above_Tab"
        "<Shift><Alt>Above_Tab"
      ];
      switch-applications = [
        "<Super>Tab"
        "<Alt>Tab"
      ];
      switch-applications-backward = [
        "<Shift><Super>Tab"
        "<Shift><Alt>Tab"
      ];
      switch-panels = [ "<Control><Alt>Tab" ];
      switch-panels-backward = [ "<Shift><Control><Alt>Tab" ];
      cycle-group = [ "<Alt>F6" ];
      cycle-group-backward = [ "<Shift><Alt>F6" ];
      cycle-windows = [ "<Alt>Escape" ];
      cycle-windows-backward = [ "<Shift><Alt>Escape" ];
      cycle-panels = [ "<Control><Alt>Escape" ];
      cycle-panels-backward = [ "<Shift><Control><Alt>Escape" ];
      panel-run-dialog = [ "<Alt>F2" ];
      activate-window-menu = [ "<Alt>space" ];
      move-to-workspace-1 = [ ];
      move-to-workspace-last = [ ];
      move-to-workspace-up = [ ];
      move-to-workspace-down = [ ];
      move-to-monitor-left = [ ];
      move-to-monitor-right = [ ];
      move-to-monitor-up = [ ];
      move-to-monitor-down = [ ];
      switch-input-source = [
        "XF86Keyboard"
      ];
      switch-input-source-backward = [
        "<Shift><Super>space"
        "<Shift>XF86Keyboard"
      ];
    };

    # ===========================================
    # ===========================================

    # Mutter
    ## Window manager settings (disabling incompatible defaults)

    # ===========================================
    # ===========================================

    "org/gnome/mutter" = {
      workspaces-only-on-primary = false;
      edge-tiling = false;
    };

    # ===========================================
    # ===========================================

    # Media Keys
    ## Keyboard media shortcuts and custom keybindings

    # ===========================================
    # ===========================================

    "org/gnome/settings-daemon/plugins/media-keys" = {
      screensaver = [ "<Super><Shift>l" ];
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/vicinae"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/nerd-dictation"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/vicinae" = {
      name = "Toggle Vicinae";
      command = "vicinae toggle";
      binding = "<Super>space";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/nerd-dictation" = {
      name = "Toggle Nerd Dictation";
      command = "nerd-dictation toggle";
      binding = "<Super>d";
    };

    # ===========================================
    # ===========================================

    # PaperWM
    ## Custom keybindings and styling for PaperWM
    ## Only non-default modifications; defaults: https://github.com/paperwm/PaperWM

    # ===========================================
    # ===========================================

    "org/gnome/shell/extensions/paperwm/keybindings" = {
      close-window = [ "<Super>w" ];
      switch-left = [
        "<Super>h"
        "<Super>Left"
      ];
      switch-right = [
        "<Super>l"
        "<Super>Right"
      ];
      switch-up = [
        "<Super>k"
        "<Super>Up"
      ];
      switch-down = [
        "<Super>j"
        "<Super>Down"
      ];
      move-left = [
        "<Super><Ctrl>h"
        "<Super><Ctrl>Left"
      ];
      move-right = [
        "<Super><Ctrl>l"
        "<Super><Ctrl>Right"
      ];
      move-up = [
        "<Super><Ctrl>k"
        "<Super><Ctrl>Up"
      ];
      move-down = [
        "<Super><Ctrl>j"
        "<Super><Ctrl>Down"
      ];
      switch-monitor-left = [
        "<Super><Shift>h"
        "<Super><Shift>Left"
      ];
      switch-monitor-right = [
        "<Super><Shift>l"
        "<Super><Shift>Right"
      ];
      switch-monitor-up = [
        "<Super><Shift>k"
        "<Super><Shift>Up"
      ];
      switch-monitor-down = [
        "<Super><Shift>j"
        "<Super><Shift>Down"
      ];
      move-window-monitor-left = [
        "<Super><Shift><Ctrl>h"
        "<Super><Shift><Ctrl>Left"
      ];
      move-window-monitor-right = [
        "<Super><Shift><Ctrl>l"
        "<Super><Shift><Ctrl>Right"
      ];
      move-window-monitor-up = [
        "<Super><Shift><Ctrl>k"
        "<Super><Shift><Ctrl>Up"
      ];
      move-window-monitor-down = [
        "<Super><Shift><Ctrl>j"
        "<Super><Shift><Ctrl>Down"
      ];

      # Workspace navigation (comma/period instead of pgup/pgdown)
      switch-up-workspace = [ "<Super><Alt>k" ];
      switch-down-workspace = [ "<Super><Alt>j" ];
      move-up-workspace = [ "<Super><Ctrl>k" ];
      move-down-workspace = [ "<Super><Ctrl>j" ];
    };

    # ===========================================

    # MIME Apps
    ## Default applications for URL schemes and file types

    # ===========================================
    # ===========================================

    # Session
    ## Session and application settings

    # ===========================================
    # ===========================================

    "org/gnome/gnome-session" = {
      auto-save-session = true;
    };

    # ===========================================
    # ===========================================
  };
}
