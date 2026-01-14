{ config, lib, pkgs, ... }:

lib.mkIf pkgs.stdenv.isDarwin {
  # Finicky URL handler configuration (macOS only)
  home.file.".config/finicky/finicky.js".source = ./finicky.js;
}