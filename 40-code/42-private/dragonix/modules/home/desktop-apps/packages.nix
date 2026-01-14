# Desktop application packages
{
  config,
  pkgs,
  lib,
  ...
}:
let
  isLinux = !pkgs.stdenv.isDarwin;
  isDarwin = pkgs.stdenv.isDarwin;
in
{
  programs.onedrive.enable = lib.mkIf isLinux true;

  home.packages = lib.mkMerge [
    (with pkgs; [
      # Common packages
      musescore
    ])
    (lib.mkIf isLinux (with pkgs; [
      # NixOS-specific desktop packages
      flameshot
      libreoffice
      obsidian
      obs-studio
    ]))
    (lib.mkIf isDarwin (with pkgs; [
      # Darwin-specific desktop packages
      pngpaste 
    ]))
  ];
}
