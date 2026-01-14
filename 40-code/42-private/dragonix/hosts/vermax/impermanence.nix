# NixOS impermanence configuration
# Enables ephemeral root with persistent state management
# Root filesystem is wiped on boot, restoring from blank snapshot
# Only explicitly defined paths and files persist across reboots
# SSH host keys persist to maintain consistent SSH fingerprints across reboots
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [ inputs.impermanence.nixosModules.impermanence ];

  boot.initrd.postDeviceCommands = lib.mkAfter ''
    mkdir -p /mnt
    mount -t btrfs -o subvol=@root /dev/mapper/root /mnt

    # Create blank snapshot on first boot if it doesn't exist
    if ! btrfs subvolume show /mnt/@root-blank &>/dev/null; then
      btrfs subvolume snapshot -r /mnt/@root /mnt/@root-blank
    fi

    btrfs subvolume delete /mnt/@root
    btrfs subvolume snapshot /mnt/@root-blank /mnt/@root
    umount /mnt
  '';

  fileSystems."/persist".neededForBoot = true;

  # Configure impermanence - minimal persistent system state
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      # Essential system state
      "/var/lib/systemd"
      "/var/lib/nixos"
      "/var/lib/systemd/timers"
      # User state (home is on separate subvolume but can add app cache here if needed)
      "/var/lib/nix"

      # Service data - must survive @root wipes
      "/var/lib/couchdb" # Obsidian LiveSync backend

      # Snapshot metadata - Snapper stores snapshot info here
      "/persist/.snapshots" # Persist subvolume snapshot metadata
    ];
    files = [
      # System identification
      "/etc/machine-id"
    ];
  };

  # Persist SSH host keys via symlinks (not via /etc/ssh directory bind mount,
  # which would hide NixOS-generated sshd_config)
  # This allows sshd_config to regenerate on each boot while maintaining SSH fingerprint stability
  environment.etc = {
    "ssh/ssh_host_rsa_key".source = "/persist/etc/ssh/ssh_host_rsa_key";
    "ssh/ssh_host_rsa_key.pub".source = "/persist/etc/ssh/ssh_host_rsa_key.pub";
    "ssh/ssh_host_ed25519_key".source = "/persist/etc/ssh/ssh_host_ed25519_key";
    "ssh/ssh_host_ed25519_key.pub".source = "/persist/etc/ssh/ssh_host_ed25519_key.pub";
  };
}
