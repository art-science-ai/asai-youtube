{ config, lib, ... }:

{
  imports = [
    # Note: 1Password SSH integration moved to modules/home/user-nikhilmaddirala.nix

    # ./distrobox-config.nix

    ./gnome-integration.nix
    ./obsidian
    ./packages.nix
    ./vscode.nix
  ];
}
