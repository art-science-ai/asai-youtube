{ config, lib, ... }:
{
  programs.zellij = {
    enable = true;

    # Manual control: No auto-start on shell initialization
    # User types 'zellij' to start/attach to session
    # Zellij will automatically attach to existing session by default
    enableZshIntegration = false;
    enableBashIntegration = false;
    enableFishIntegration = false;

    # Load KDL config
    extraConfig = builtins.readFile ./config.kdl;
  };
}
