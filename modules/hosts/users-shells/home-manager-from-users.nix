# Home Manager configuration derived from user profiles
# Automatically configures Home Manager for users with homeManager = "nixos-module"
{ config, pkgs, lib, inputs, ... }:

let
  # Import userProfiles to access homeManager preferences
  userProfilesModule = import ./users-shells.nix {
    inherit config pkgs lib inputs;
  };

  # Filter enabled users that should use NixOS Home Manager module
  nixosHmUsers = lib.filterAttrs (username: profile:
    config.myUsers.${username}.enable &&
    (userProfilesModule.userProfiles.${username}.homeManager or "standalone") == "nixos-module"
  ) config.myUsers;

in {
  # Import Home Manager NixOS module
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  # Configure Home Manager for selected users
  home-manager = lib.mkIf (lib.attrNames nixosHmUsers != []) {
    useGlobalPkgs = true;
    useUserPackages = true;
    overwriteBackup = true;

    users = lib.mapAttrs' (username: profile:
      lib.nameValuePair username {
        imports = [ ../../home/${username}-${config.networking.hostName}.nix ];
        home.username = username;
        home.homeDirectory = "/home/${username}";
        home.sessionVariables.XDG_DATA_DIRS = "$XDG_DATA_DIRS:$HOME/.local/share/flatpak/exports/share";
      }
    ) nixosHmUsers;
  };
}