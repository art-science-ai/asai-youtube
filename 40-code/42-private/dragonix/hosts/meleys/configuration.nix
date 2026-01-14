# Meleys host configuration (macOS, aarch64-darwin)
# Host-specific configuration extracted from default.nix
{
  config,
  pkgs,
  lib,
  ...
}:
{
  # Use vanilla Nix (default behavior)
  ids.gids.nixbld = 350;

  # Facebook-specific configuration
  environment.variables = {
    BASH_SILENCE_DEPRECATION_WARNING = "1";
    PATH = "/opt/facebook/bin:/opt/facebook/sbin:$PATH";
  };

  environment.systemPath = [
    "/opt/facebook/bin"
    "/opt/facebook/sbin"
  ];

  # Facebook-specific PATH additions
  launchd.user.envVariables.PATH = lib.mkAfter [
    "/opt/facebook/bin"
    "/opt/facebook/sbin"
  ];
}