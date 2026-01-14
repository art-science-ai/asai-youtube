{ inputs, ... }:
{
  imports = [
    ../../modules/hosts/base
    ../../modules/hosts/nix-settings
    ../../modules/hosts/sops
    ../../modules/hosts/users-shells
    ../../modules/hosts/nixos-server
    ./hardware-configuration.nix
    ./disk-config.nix
    ./ports.nix
    ./prod
    ./dev
    ./configuration.nix
    inputs.disko.nixosModules.disko
    inputs.sops-nix.nixosModules.sops
    inputs.nix-index-database.nixosModules.nix-index
  ];
}
