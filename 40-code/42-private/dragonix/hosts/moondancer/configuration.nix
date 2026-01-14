# Moondancer host configuration (macOS, aarch64-darwin)
# Host-specific configuration extracted from default.nix
{
  config,
  pkgs,
  lib,
  ...
}:
{
  # Set hostname
  networking.hostName = "moondancer";
  networking.computerName = "moondancer";
  networking.localHostName = "moondancer";

  # Enable users for this host
  myUsers = {
    nikhilmaddirala.enable = true;
    rukmasen.enable = true;
  };

  # Use Determinate Nix instead of nix-darwin's Nix daemon
  determinateNix.enable = true;
}