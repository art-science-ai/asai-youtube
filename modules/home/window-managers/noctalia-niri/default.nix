{ config, lib, system, ... }:

let
  isDarwin = lib.hasSuffix "-darwin" system;
in
{
  imports = if !isDarwin then [ ./fuzzel.nix ./noctalia.nix ./niri.nix ] else [];
}