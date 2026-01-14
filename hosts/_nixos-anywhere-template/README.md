# NixOS-Anywhere Bootstrap

Bootstrap configuration for provisioning this NixOS host using [nixos-anywhere](https://github.com/nix-community/nixos-anywhere).

For detailed step-by-step instructions, see [quickstart.md](./quickstart.md).

## Gather target info 

Run these commands and paste the output below to customize this configuration:

```bash
ssh user@target 

echo "=== Block Devices ===" && lsblk -f && echo -e "\\n=== Disk Details ===" && sudo fdisk -l && echo -e "\\n=== Filesystems ===" && df -h && echo -e "\\n=== UUIDs ===" && sudo blkid

fastfetch

ip addr
```

Output:
```bash
INSERT_OUTPUT_HERE
```


## Quick Start

1. **Prepare target machine** - Ensure SSH access (wired LAN recommended) and prerequisites:
   ```bash
   # For passwordless sudo (if non-root user):
   echo "username ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/username > /dev/null
   sudo chmod 440 /etc/sudoers.d/username
   ```

2. **Update SSH keys** - Edit `configuration.nix` and add your public key to both root and your user

3. **Customize disk-config.nix** - Based on requirements and disk info - e.g. update `/dev/sda` in `disk-config.nix`:

4. **Run nixos-anywhere**:
   ```bash
   nix run github:nix-community/nixos-anywhere -- \
     --generate-hardware-config nixos-generate-config ./hardware-configuration.nix \
     --flake .#HOSTNAME \
     --target-host user@target-ip \
     --build-on remote
   ```

5. **Deploy full configuration** - After bootstrap succeeds, create `hosts/HOSTNAME/default.nix` and rebuild

