# Personal GNOME config for nikhilmaddirala (declarative extensions, no Flathub).
{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    gnomeExtensions.dash-to-dock
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
  ];

  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = [
        "dash-to-dock@micxgx.gmail.com"
        "appindicatorsupport@rgcjonas.gmail.com"
        "blur-my-shell@aunetx"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "paperwm@paperwm.github.com"
      ];
      attach-modal-dialogs = false;
    };

    "org/gnome/desktop/interface" = {
      clock-show-date = true;
    };

    "org/gnome/desktop/wm/keybindings" = {
      # Customized
      minimize = [ "<Super>m" ];
      switch-to-workspace-left = [ ];
      switch-to-workspace-right = [ ];

      # Default (from https://gitlab.gnome.org/GNOME/gsettings-desktop-schemas/-/blob/master/schemas/org.gnome.desktop.wm.keybindings.gschema.xml.in)
      close = [ "<Alt>F4" ];
      maximize = [ "<Super>Up" ];
      unmaximize = [
        "<Super>Down"
        "<Alt>F5"
      ];
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
      move-to-workspace-1 = [ "<Super><Shift>Home" ];
      move-to-workspace-last = [ "<Super><Shift>End" ];
      move-to-workspace-up = [ "<Control><Shift><Alt>Up" ];
      move-to-workspace-down = [ "<Control><Shift><Alt>Down" ];
      move-to-monitor-left = [ "<Super><Shift>Left" ];
      move-to-monitor-right = [ "<Super><Shift>Right" ];
      move-to-monitor-up = [ "<Super><Shift>Up" ];
      move-to-monitor-down = [ "<Super><Shift>Down" ];
      switch-input-source = [
        "<Super>space"
        "XF86Keyboard"
      ];
      switch-input-source-backward = [
        "<Shift><Super>space"
        "<Shift>XF86Keyboard"
      ];
    };

    "org/gnome/mutter" = {
      workspaces-only-on-primary = false;
      edge-tiling = false;
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      # Customized
      screensaver = [ "<Super><Shift>l" ];

      # Default (from https://gitlab.gnome.org/GNOME/gnome-settings-daemon/-/blob/main/plugins/media-keys/org.gnome.settings-daemon.plugins.media-keys.gschema.xml.in)
      # screensaver = ["<Super>l"];

      # Custom keybindings
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/vicinae/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/vicinae" = {
      name = "Toggle Vicinae";
      command = "vicinae toggle";
      binding = "<Super>space";
    };

    "org/gnome/shell/extensions/paperwm/keybindings" = {
      # Customized
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

      # Default (from https://github.com/paperwm/PaperWM)
      new-window = [
        "<Super>Return"
        "<Super>n"
      ];
      switch-next = [ "<Super>period" ];
      switch-previous = [ "<Super>comma" ];
      switch-first = [ "<Super>Home" ];
      switch-last = [ "<Super>End" ];
      take-window = [ "<Super>t" ];
      cycle-windows = [ "<Super>Tab" ];
      cycle-windows-backwards = [ "<Super><Shift>Tab" ];
      center-horizontal = [ "<Super>c" ];
      cycle-width = [ "<Super>r" ];
      cycle-height = [ "<Super><Shift>r" ];
      toggle-maximize-width = [ "<Super>f" ];
      toggle-fullscreen = [ "<Super><Shift>f" ];
      slurp-in = [ "<Super>i" ];
      barf-out = [ "<Super>o" ];
      switch-previous-workspace = [ "<Super>grave" ];
      switch-previous-workspace-backwards = [ "<Super><Shift>grave" ];
      move-previous-workspace = [ "<Super><Ctrl>grave" ];
      move-previous-workspace-backwards = [ "<Super><Shift><Ctrl>grave" ];
      switch-up-workspace = [ "<Super>Page_Up" ];
      switch-down-workspace = [ "<Super>Page_Down" ];
      move-up-workspace = [ "<Super><Ctrl>Page_Up" ];
      move-down-workspace = [ "<Super><Ctrl>Page_Down" ];
      toggle-scratch-window = [ "<Super>Escape" ];
      toggle-scratch-layer = [ "<Super><Shift>Escape" ];
      toggle-scratch = [ "<Super><Ctrl>Escape" ];

    };

    "org/gnome/gnome-session" = {
      auto-save-session = true;
    };
  };

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
}
