# Seasmoke host configuration (NixOS server, x86_64-linux)
# Host-specific configuration extracted from default.nix
{
  config,
  pkgs,
  ...
}:
{
  # Enable users for this host
  myUsers = {
    nikhilmaddirala.enable = true;
    aegon.enable = true;
    tyrion.enable = true;
  };

  # Boot loader configuration
  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  # Networking
  networking = {
    hostName = "seasmoke";
    # Prevent DHCP from overriding the configured hostname
    dhcpcd.setHostname = false;
    firewall.allowedUDPPortRanges = [
      {
        from = 60000;
        to = 61000;
      }
    ];
  };

  # Server base configuration
  system.stateVersion = "23.11";
}