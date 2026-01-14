{ config, lib, pkgs, ... }:

{
  # AeroSpace window manager configuration
  home.file.".config/aerospace/aerospace.toml".source = ./aerospace.toml;
}