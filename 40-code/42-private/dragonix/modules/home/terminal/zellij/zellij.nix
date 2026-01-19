{ config, lib, pkgs, ... }:
let
  # Fetch zellij-forgot plugin
  zellij-forgot-plugin = pkgs.fetchurl {
    url = "https://github.com/karimould/zellij-forgot/releases/download/0.4.2/zellij_forgot.wasm";
    sha256 = "sha256-MRlBRVGdvcEoaFtFb5cDdDePoZ/J2nQvvkoyG6zkSds=";
  };
in
{
  # Enable Zoxide for quick directory jumping
  programs.zoxide.enable = true;

  programs.zellij = {
    enable = true;

    # Manual control: No auto-start on shell initialization
    enableZshIntegration = false;
    enableBashIntegration = false;
    enableFishIntegration = false;

    # Load KDL config
    extraConfig = builtins.readFile ./config.kdl;
  };

  # Deploy Zellij plugins
  xdg.configFile."zellij/plugins/zellij_forgot.wasm".source = zellij-forgot-plugin;

  # Deploy Zellij layouts
  xdg.configFile."zellij/layouts".source = ./layouts;
}