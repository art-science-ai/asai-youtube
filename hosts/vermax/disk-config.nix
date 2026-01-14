# Vermax disk configuration with LUKS encryption, btrfs, and impermanence
# Hardware: Single 476.94 GiB SSD with EFI + encrypted root
# Impermanence: @root (ephemeral), @nix, @persist, @home (persistent)
{ lib, ... }:
{
  disko.devices = {
    disk.sda = {
      device = lib.mkDefault "/dev/sda";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          # EFI System Partition for UEFI boot
          esp = {
            name = "ESP";
            size = "2G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          # Swap partition for hibernation
          swap = {
            name = "swap";
            size = "16G";
            type = "8200";
            content = {
              type = "swap";
            };
          };
          # Root partition with btrfs subvolumes for impermanence
          root = {
            name = "root";
            size = "100%";
            type = "8300";
            content = {
              type = "btrfs";
              extraArgs = [ "-f" "-L" "nixos" ];
              subvolumes = {
                # Ephemeral root - wiped on boot
                "@root" = {
                  mountpoint = "/";
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                };
                # Persistent Nix store
                "@nix" = {
                  mountpoint = "/nix";
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                };
                # Persistent data for impermanence (system state, SSH keys, etc.)
                "@persist" = {
                  mountpoint = "/persist";
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                };
                # Persistent home directories for all users
                "@home" = {
                  mountpoint = "/home";
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                };
              };
            };
          };
        };
      };
    };
  };
}
