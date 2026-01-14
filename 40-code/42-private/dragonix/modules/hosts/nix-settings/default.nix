{ config, lib, system, ... }:
let
  isLinux = lib.hasSuffix "-linux" system;
  isDarwin = lib.hasSuffix "-darwin" system;
in
{
  imports = [
    ./common.nix
  ] ++ lib.optional isDarwin ./darwin.nix
    ++ lib.optional isLinux ./linux.nix;
}
