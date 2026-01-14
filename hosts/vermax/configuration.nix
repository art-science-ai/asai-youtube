# Vermax host configuration (desktop + server with containers, x86_64-linux)
# Combines desktop environment with server capabilities (SSH, Docker, containers)
# Host-specific configuration extracted from default.nix
{
  config,
  pkgs,
  lib,
  ...
}:
{
  # SOPS configuration - disable during initial installation, enable after first boot
  # Set to false during nixos-install, then set to true after system is fully installed
  mySops.enable = lib.mkDefault true;

  # Enable users for this host
  myUsers = {
    nikhilmaddirala.enable = true;
    rukmasen.enable = true;
    guest.enable = true;
  };

  # Enable remote desktop options
  myRemoteDesktop = {
    sunshine.enable = true;
    rustdesk.enable = true;
    gnomeRdp.enable = false;  # Disabled in favor of XRDP (simpler, native NixOS support)
    xrdp.enable = true;       # Primary remote login solution (headless capable)
  };

  # Enable Jellyfin media server
  myJellyfin.enable = false;

  # Host-specific configuration
  networking.hostName = "vermax";
  # DNS fallback via systemd-resolved inherited from nixos-server/tailscale.nix

  # Make users fully declarative (passwords set via initialPassword)
  users.mutableUsers = true;

  # Boot loader configuration (UEFI)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Load uinput kernel module for kanata
  boot.kernelModules = [ "uinput" ];

  # Define input and uinput groups for device access
  users.groups.input = { };
  users.groups.uinput = { };

  # Udev rule for uinput permissions
  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';

  # NixOS version
  system.stateVersion = "25.05";
}
