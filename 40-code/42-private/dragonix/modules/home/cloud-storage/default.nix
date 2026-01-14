{ config, lib, pkgs, system, ... }:
let
  isLinux = lib.hasSuffix "-linux" system;
in
{
  imports = [ ./syncthing.nix ] ++ (if isLinux then [ ./google-drive.nix ] else [ ]);
}
