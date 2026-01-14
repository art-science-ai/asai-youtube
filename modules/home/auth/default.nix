# Authentication and user identity module
# Provides:
# - 1Password SSH agent integration
# - Git commit signing with 1Password
# - User-specific settings (git config, SSH hosts, editor preferences)
{ config, pkgs, lib, ... }:

{
  options = {
    userIdentity = {
      name = lib.mkOption {
        type = lib.types.str;
        default = "Nikhil Maddirala";
        description = "User full name";
      };
      email = lib.mkOption {
        type = lib.types.str;
        default = "nikhil.maddirala@gmail.com";
        description = "User email address";
      };
    };
  };

  imports = [
    ./user-nikhilmaddirala.nix
  ];
}
