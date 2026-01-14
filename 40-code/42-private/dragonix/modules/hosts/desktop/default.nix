{ config, lib, system, ... }:

let
  isDarwin = lib.hasSuffix "-darwin" system;
in
{
  imports = [
    # Cross-platform desktop modules
    ./tailscale.nix
  ] ++ (if isDarwin then [
    # macOS-specific desktop modules
    ./darwin/homebrew.nix
    ./darwin/macos-settings.nix
  ] else [
    # NixOS-specific desktop modules
    ./nixos/base.nix
    ./nixos/flatpak.nix
    ./nixos/gdm.nix
    ./nixos/gnome.nix
    ./nixos/hyprland.nix
    ./nixos/niri.nix
    # ./nixos/sddm.nix
  ]);
}
