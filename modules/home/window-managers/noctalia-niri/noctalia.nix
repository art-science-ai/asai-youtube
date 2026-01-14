# Noctalia shell configuration
{ config, lib, pkgs, inputs, ... }:

{
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;
    # Using all default settings
  };
}