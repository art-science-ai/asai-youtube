{ config, lib, pkgs, system, ... }:
let
  isDarwin = lib.hasSuffix "-darwin" system;
in
{
  imports = if isDarwin then [ ./karabiner.nix ] else [ ./kanata.nix ];
}