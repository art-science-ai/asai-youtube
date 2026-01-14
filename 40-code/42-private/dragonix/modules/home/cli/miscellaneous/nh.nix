{ config, lib, ... }:

let
  flakePath = config.home.homeDirectory + "/repos/nix-config";
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