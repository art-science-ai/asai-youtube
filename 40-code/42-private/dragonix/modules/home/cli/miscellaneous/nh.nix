{ config, lib, ... }:

let
  flakePath = "${config.xdg.configHome}/nix-config";
in
{
  programs.nh = {
    enable = true;
    flake = flakePath;
    homeFlake = flakePath;
    osFlake = flakePath;
    darwinFlake = flakePath;
    clean = {
      enable = true;
      dates = "weekly";
    };
  };
}