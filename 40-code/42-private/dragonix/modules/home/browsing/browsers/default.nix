{ config, lib, pkgs, system, ... }:
let
  isLinux = !lib.hasSuffix "-darwin" system;
in
{
  imports = if isLinux then [ 
    ./zen-firefox.nix 
    ./chromium-browsers.nix 
  ] else [ ];
}
