Subject: Help needed: nixos-anywhere bootstrap fails with network connectivity loss after kexec

Hi everyone,

I'm having trouble with a `nixos-anywhere` installation on a new machine (Minisforum NucBoxG5, Intel N97). The bootstrap process fails right after the `kexec` reboot, and the machine becomes unreachable over the network, preventing the installation from continuing.

I'd appreciate any help or suggestions to debug and resolve this.

**The Problem**

- `nixos-anywhere` runs, copies keys, and successfully triggers the `kexec` reboot.
- Immediately after the reboot into the NixOS installer, the machine drops off the network.
- SSH attempts time out with "Operation timed out", "Host is down", or "No route to host".

**What I've Tried**

1.  **Initial Attempt:** The first attempt failed, and I realized my bootstrap `configuration.nix` in the `_nixos-anywhere-vermax` directory was missing any network configuration.

2.  **Adding `networking.useDHCP`:** I added `networking.useDHCP = lib.mkDefault true;` to the bootstrap configuration, hoping it would bring up the network interface (`enp2s0`) in the installer. This did not solve the issue.

3.  **Explicit Interface Configuration:** I also tried explicitly configuring the interface, which also didn't work:
    ```nix
    networking.useDHCP = false;
    networking.interfaces.enp2s0.useDHCP = true;
    networking.interfaces.wlan0.useDHCP = true;
    ```

**My Hypothesis**

The problem seems to be with the `nixos-anywhere` kexec environment itself, not my NixOS configuration. It seems like the installer environment doesn't correctly bring up the network for my hardware (Intel N97).

**Next Steps & Questions**

1.  **Console Output:** The next step is to connect a monitor and keyboard to see the console output during the kexec boot. I haven't been able to do this yet, but I'm working on it.
2.  **Hardware Drivers:** I need to check if the necessary drivers for the Intel N97's network interface are included in the `nixos-anywhere` kexec image.

**My Questions for the Community:**

- Has anyone else experienced similar issues with `nixos-anywhere` on newer hardware?
- Is there a way to customize the `nixos-anywhere` kexec environment to include specific kernel modules or drivers?
- Are there any known workarounds for network issues during the bootstrap phase?

Any guidance would be greatly appreciated!

---

**Appendix: Details and Logs**

**Hardware:**

-   **Machine:** Minisforum NucBoxG5 (Intel N97, 12GB RAM)
-   **Network:** `enp2s0` (wired), `wlan0` (wireless)
-   **Storage:** Btrfs on LUKS

**Bootstrap Configuration (`hosts/vermax/_nixos-anywhere-vermax/configuration.nix`):**

```nix
# This is the bootstrap configuration for nixos-anywhere
{ pkgs, ... }:
{
  imports = [
    # Import the disk configuration
    ./disk-config.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkg.pname or pkg.name) [
    "steam"
    "steam-original"
    "steam-run"
  ];

  # Enable the OpenSSH server.
  services.openssh.enable = true;

  # This is where I added the networking configuration
  # networking.useDHCP = lib.mkDefault true;

  # Or, the more explicit configuration:
  # networking.useDHCP = false;
  # networking.interfaces.enp2s0.useDHCP = true;
  # networking.interfaces.wlan0.useDHCP = true;
}
```

**`nixos-anywhere` command:**

```bash
nix run github:nix-community/nixos-anywhere -- \
  --generate-hardware-config nixos-generate-config ./hardware-configuration.nix \
  --flake .#generic \
  --target-host nikhilmaddirala@192.168.1.17 \
  --build-on remote
```

**Log Output (showing the hang after kexec):**

The logs show a successful handoff to kexec, and then connection timeouts.

```
...
machine will boot into nixos in 6s...
+ test -e /dev/kmsg
+ exec
Connection to 192.168.1.17 closed.
Warning: Permanently added '192.168.1.17' (ED25519) to the list of known hosts.
...
ssh: connect to host 192.168.1.17 port 22: Operation timed out
ssh: connect to host 192.168.1.17 port 22: No route to host
ssh: connect to host 192.168.1.17 port 22: Host is down
...
```

```