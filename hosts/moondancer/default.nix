{ inputs, ... }:
{
  imports = [
    ../../modules/hosts/base
    ../../modules/hosts/nix-settings
    ../../modules/hosts/sops
    ../../modules/hosts/users-shells
    ../../modules/hosts/desktop
    ./configuration.nix
    inputs.nix-homebrew.darwinModules.nix-homebrew
    inputs.sops-nix.darwinModules.sops
    inputs.nix-index-database.darwinModules.nix-index
  ];
}
