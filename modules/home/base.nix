# Universal home-manager configuration
# Base settings applied to all user profiles
{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.isDesktop = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Whether this is a desktop configuration (vs server/headless)";
  };

  config = {
    # Enable home-manager CLI tool for all users
    programs.home-manager.enable = true;

    # Allow unfree packages consistently across all users
    nixpkgs.config.allowUnfree = true;
  };
}
