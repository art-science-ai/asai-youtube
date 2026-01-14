{ config, lib, pkgs, system, ... }:
let
  isLinux = !lib.hasSuffix "-darwin" system;
  isx86_64Linux = isLinux && system == "x86_64-linux";
in
{
  config = lib.mkIf isLinux {
    home.packages = with pkgs; [
      chromium          # Open-source Chromium browser
      google-chrome     # Google Chrome (unfree)
      vivaldi           # Vivaldi browser (unfree)
    ] ++ lib.optionals isx86_64Linux [
      microsoft-edge    # Microsoft Edge (unfree, x86_64 Linux only)
    ];
    
    # Configure Chromium settings
    programs.chromium = {
      enable = true;
      extensions = [
        # Add common extensions as examples
        # { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
      ];
      # Default search engine and other preferences can be added here
    };
  };
}