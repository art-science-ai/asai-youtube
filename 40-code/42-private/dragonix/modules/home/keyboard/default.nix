{ config, lib, pkgs, system, ... }:
let
  isDarwin = lib.hasSuffix "-darwin" system;
in
{
  imports =
    [
      ./kanata.nix  # Linux only (handled internally with mkIf)
      ./karabiner.nix  # macOS only (handled internally with mkIf)
    ]
    ++ lib.optionals (!isDarwin) [
      ./clipboard.nix
    ];
}