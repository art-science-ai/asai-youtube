{
  modulesPath,
  lib,
  pkgs,
  ...
}@args:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ../disk-config.nix
  ];

  boot.loader.grub = {
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    # devices = [ ];
    devices = [ "nodev" ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  # Enable DHCP on all interfaces to maintain network connectivity during bootstrap
  networking.useDHCP = lib.mkDefault true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    pkgs.gitMinimal
    pkgs.cowsay
  ];

  # SSH keys for both root (backup) and nikhilmaddirala (primary)
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBrpbMwLVb28otKcvFmUguFYavpYmfW4fbXpDBraZeXK"
  ] ++ (args.extraPublicKeys or [ ]);

  # Minimal user configuration for bootstrap
  users.users.nikhilmaddirala = {
    isNormalUser = true;
    home = "/home/nikhilmaddirala";
    extraGroups = [ "wheel" ];
    shell = pkgs.bash;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBrpbMwLVb28otKcvFmUguFYavpYmfW4fbXpDBraZeXK"
    ];
  };

  # Enable passwordless sudo for wheel group
  security.sudo.wheelNeedsPassword = false;

  system.stateVersion = "24.05";
}
