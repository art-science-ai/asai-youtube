{ config, lib, system, ... }:
let
  isLinux = lib.hasSuffix "-linux" system;
in
{
  imports = [
    ./users-shells.nix
  ] ++ lib.optional isLinux ./home-manager-from-users.nix;
}