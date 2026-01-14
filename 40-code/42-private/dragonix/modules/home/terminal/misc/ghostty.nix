{ config, lib, ... }:

{
  programs.ghostty = {
    enable = true;
    package = null;
    systemd.enable = false;
    settings = {
      term = "xterm-256color";
      font-size = 18;
      macos-option-as-alt = true;
      # split-divider-color = "firebrick4";
      window-padding-x = 2;
      window-padding-y = 2;
      unfocused-split-opacity = 0.9;
      scrollback-limit = 100000000;
      keybind = [
        "cmd+ctrl+left=resize_split:left,10"
        "cmd+ctrl+right=resize_split:right,10"
        "cmd+ctrl+up=resize_split:up,10"
        "cmd+ctrl+down=resize_split:down,10"
        "cmd+left=resize_split:left,25"
        "cmd+right=resize_split:right,25"
        "cmd+up=resize_split:up,25"
        "cmd+down=resize_split:down,25"
      ];
    };
  };
}