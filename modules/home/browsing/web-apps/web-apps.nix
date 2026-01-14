{ config, lib, pkgs, ... }:
let
  ssbDir = "${config.home.homeDirectory}/.local/share/ssb";
  iconsDir = ./icons;
in {
  # Install app icons
  home.file = {
    ".local/share/icons/whatsapp-web.svg".source = "${iconsDir}/whatsapp-web.svg";
    ".local/share/icons/gmail-web.svg".source = "${iconsDir}/gmail-web.svg";
  };

  xdg.desktopEntries = {
    whatsapp-web = {
      name = "WhatsApp";
      exec = "${pkgs.chromium}/bin/chromium --app=https://web.whatsapp.com --user-data-dir=${ssbDir}/whatsapp --app-id=whatsapp-web";
      icon = "whatsapp-web";
      categories = ["Network" "InstantMessaging"];
      settings = {
        StartupWMClass = "whatsapp-web";
      };
    };
    gmail = {
      name = "Gmail";
      exec = "${pkgs.chromium}/bin/chromium --app=https://mail.google.com --user-data-dir=${ssbDir}/gmail --app-id=gmail-web";
      icon = "gmail-web";
      categories = ["Network" "Email"];
      settings = {
        StartupWMClass = "gmail-web";
      };
    };
  };
}
