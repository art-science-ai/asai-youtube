{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  # Niri session
  programs.niri = {
    enable = true;  # provides a Niri Wayland session for the DM
  };
}