{ config, pkgs, ... }:

{
  # NixOS-specific configuration
  # Enable dynamic linker
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Python libs
    stdenv.cc.cc
    zlib
    openssl
  ];

  # NixOS-specific system packages (in addition to shared base packages)
  environment.systemPackages = with pkgs; [
    # Essential CLI tools for NixOS systems
    git
    vim
    wget
    curl
    home-manager
  ];
}
