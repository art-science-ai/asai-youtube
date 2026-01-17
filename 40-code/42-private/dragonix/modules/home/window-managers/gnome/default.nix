{ config, lib, system, ... }:

let
  isDarwin = lib.hasSuffix "-darwin" system;
in
{
  imports = if !isDarwin then [ ./gnome.nix ] else [];
}
