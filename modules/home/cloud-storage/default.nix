{ config, lib, pkgs, system, ... }:
let
  isLinux = lib.hasSuffix "-linux" system;
in
{
  imports = if isLinux then [ ./google-drive.nix ] else [ ];
}
