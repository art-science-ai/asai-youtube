{ inputs, ... }:
{
  imports = [
    ../../modules/hosts/base
    ../../modules/hosts/nix-settings
    ../../modules/hosts/users-shells
    ../../modules/hosts/sops
    ../../modules/hosts/desktop
    ../../modules/hosts/nixos-server
    ./disk-config.nix
    ./swap.nix
    ./hardware-configuration.nix
    ./configuration.nix
    ./snapper.nix
    ./obsidian/obsidian-livesync.nix
    ./remote-desktop/sunshine.nix
    ./remote-desktop/rustdesk.nix
    ./remote-desktop/gnome-rdp.nix
    ./remote-desktop/xrdp.nix
    ./jellyfin/jellyfin.nix
    # ./impermanence.nix  # TEMPORARILY DISABLED - will re-enable after system stabilizes
    inputs.disko.nixosModules.disko
    inputs.sops-nix.nixosModules.sops
    inputs.nix-index-database.nixosModules.nix-index
    inputs.nix-flatpak.nixosModules.nix-flatpak
  ];

  nixpkgs.overlays = [
    (import ../../overlays/whisper-diarization.nix)
  ];
}
