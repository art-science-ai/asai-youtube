## Overview

Mini PC setup for dual use: primary production server (NixOS host) + experimental desktop environment (Arch VM). Server uptime is prioritized with dynamic resource allocation ensuring VMs don't impact server performance.

## Hardware & Architecture

**Hardware:**
- ✅ Mini PC with Windows - GMKtec Mini PC Intel N97 (up to 3.60GHz) / 12GB DDR5 / 512GB SSD
- ✅ Monitor - external monitor or TV via HDMI
- ⌛ Keyboard + trackpad - to buy - on Amazon for around Rs.1k

**Architecture:** NixOS-Centric (Option 2)
- **Host OS:** NixOS - headless (text console only), declarative flake config, runs 24/7
- **Primary VM:** Arch Linux - QEMU/KVM with GPU passthrough, started on-demand for desktop experimentation
- **Resource Strategy:** Dynamic allocation - NixOS gets full resources (~11GB RAM, all cores) when VMs off; intelligent sharing with CPU priorities when VMs running
- **Access:** MacBook → SSH to NixOS host (primary workflow); Arch VM via physical monitor/keyboard (GPU passthrough) or remote desktop

## Temp setup - omarchy
- Set up ISO from macos
	- Insert USB drive and find it with `diskutil list` - e.g. `/dev/disk5 (external, physical)`
	- Unmount USB - `diskutil unmountDisk /dev/disk5`
	- `sudo gdd if=/Users/nikhilmaddirala/Downloads/omarchy-3.1.7.iso of=/dev/rdisk5 bs=4M status=progress`
	- On Macos at the end you'll get a message saying "The disk you attached was not readable by this computer."
- On the mini PC
	- Plug in the USB.
	- Power on → spam Del / F2 / F7 / F12 to get boot menu/BIOS.
	- Disable Secure Boot.
	- Choose the USB as boot device.
	- Boot into Omarchy installer and follow its guided steps (choose the internal SSD, etc.).


## Setup
[]()
1. **Install NixOS on host**
   - Install NixOS as headless (text console only)
   - Set up flake-based configuration
   - Enable QEMU/KVM, libvirt, virtualization support, and VFIO for GPU passthrough in flake

1. **Create Arch Linux VM**
   - Use `virt-manager` or `virsh` to create VM with GPU passthrough
   - Configure: 6GB RAM, 2 vCPUs, 100GB disk, VirtIO drivers
   - Set CPU shares (1024), enable memory ballooning
   - Install Arch Linux in VM

1.a. Optional: create Windows + Android VMs

3. **Configure access**
   - Set up SSH from MacBook to NixOS host
   - Configure remote desktop for Arch VM (optional)
   - Set up bridge networking for VM connectivity

4. **Set up services**
   - Deploy dev server and application server services on NixOS host
   - Configure Docker/Podman for containerized services
   - Set up firewall rules for external access

## Use Cases & Usage

**NixOS Server** (always running)
- **Access:** `ssh user@nixos-host` from MacBook
- **All management via flakes:** `sudo nixos-rebuild switch --flake .#hostname`
  - System updates, services, containers - all declared in flake configuration
  - No separate systemctl/docker commands - everything managed via nixos-rebuild

**Arch Linux Desktop** (on-demand QEMU/KVM VM)
- **Start/Stop:**
  - Start: `virsh start arch-desktop` (from NixOS host or via SSH from MacBook)
  - Stop: `virsh shutdown arch-desktop`
- **Access - Physical monitor/keyboard:**
  - Connect physical monitor via HDMI + keyboard to Mini PC
  - VM renders directly on physical display via GPU passthrough
  - Full native desktop experience for Wayland/Hyprland experimentation
- **Access - Remote desktop:**
  - From MacBook: VNC/RDP or Wayland-native remote protocol
  - Use when working remotely without physical access to Mini PC
- **Use cases:** Experiment with Wayland, Hyprland, tiling window managers

**Windows Apps**
- **Primary option:** Wine/Proton in Arch VM (compatibility layer, not VM/container)
  - Install Wine in Arch Linux desktop environment
  - Run Windows executables: `wine application.exe`
  - UI displays in Arch desktop (physical monitor or remote)
  - Note: Cannot run on headless NixOS host (no display server)
- **Fallback option:** Windows QEMU/KVM VM (deferred for now)
  - Full Windows VM similar to Arch setup
  - Managed via libvirt/virsh
  - Access via RDP

**Android Emulation**
- **Primary option:** Android-x86 in Arch VM (QEMU/KVM VM)
  - Full Android VM running in Arch Linux
  - UI displays in Arch desktop environment
  - Access via physical monitor or remote desktop
- **Alternative:** Waydroid in Arch VM (LXC container)
  - Install Waydroid in Arch Linux (which has Wayland compositor)
  - Container-based Android runtime
  - Note: Cannot run on headless NixOS host (requires Wayland)

---

## Appendices

### Appendix A: Configuration Options Considered

**Decision: Going with Option 2 (NixOS-Centric)**
- Server uptime is non-negotiable → NixOS as host OS ensures desktop experiments can't crash the server
- Primary use case (server) gets native performance with declarative NixOS config
- Secondary use case (Arch desktop) runs in VM with GPU passthrough for Wayland/Hyprland performance
- 5-10% VM overhead hits the "play" environment, not the production server

| **Configuration**                               | **Description**                           | **Use case: Arch Linux Desktop**                                                     | **Use case: NixOS Server**                                                     | **Use case: Windows Desktop**                                                      | **Use case: Android Emulation**                                                 | Key Characteristics                                                                                                                                                               | Nikhil's comments                                                                                |
| ----------------------------------------------- | ----------------------------------------- | ------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------ |
| **Option 1: Linux-Primary with Virtualization** | Arch Linux as host, other OSes in VMs     | Host OS (Arch) - native performance, physical monitor/keyboard + remote desktop      | VM or separate partition - full access, systemd services, containers           | KVM/QEMU VM - GPU passthrough for apps, remote desktop capable                     | Waydroid (native container) or Android-x86 VM - best performance                | ✅ Run multiple at once • Best for host OS, 5-10% overhead for VMs • SSH/VNC for server, local for host desktop, remote for VMs • Moderate complexity (KVM/libvirt)                | - Configuration is more complex vs. NixOS declarative<br>- Concerned about VM server performance |
| **Option 2: NixOS-Centric**                     | NixOS as host, other OSes in VMs          | VM (QEMU/libvirt) - good performance, remote desktop only                            | Host OS (NixOS) - native performance, full server capabilities                 | VM (QEMU/libvirt) - GPU passthrough possible, remote desktop                       | VM or Waydroid - good performance                                               | ✅ Run multiple at once • Best for host OS, 5-10% overhead for VMs • SSH/VNC for server, local for host desktop, remote for VMs • Moderate complexity (KVM/libvirt)                | - Like the configuration simplicity<br>- Concerned about desktop performance with VM setup       |
| **Option 3: Dual Boot**                         | Physical partitions for NixOS and Windows | VM within NixOS or Windows - limited tinkering, or replace one OS                    | Physical partition (NixOS) - native performance, always accessible via network | Physical partition (Windows) - native performance, physical monitor/keyboard + RDP | Either OS - Android Studio emulator or Waydroid in Linux, Bluestacks in Windows | ❌ One environment at a time • Best raw performance (native hardware) • Physical access when booted, SSH/RDP for non-booted OS • Simplest (traditional dual boot)                  |                                                                                                  |
| **Option 4: Proxmox Base**                      | Hypervisor base, all OSes as VMs          | Dedicated VM - excellent performance with GPU passthrough, remote desktop or console | Dedicated VM (always-on) - near-native performance, isolated services          | Dedicated VM - GPU passthrough, remote desktop                                     | Dedicated VM - good performance, isolated environment                           | ✅ Run multiple at once • Consistent 5-10% overhead, professional VM management • All accessible simultaneously via Proxmox web UI + VNC/RDP/SSH • Highest complexity (hypervisor) | - Don't like this option; don't want to use proxmox                                              |

### Appendix B: GPU Passthrough and Display Strategy

**Decision: Headless NixOS Host + GPU Passthrough to Arch VM**

**Problem:** How to run a desktop environment (Arch Linux with Wayland/Hyprland) on a server-focused host (NixOS) while preserving server stability and performance?

**Options Considered:**

| Option | Description | Pros | Cons |
|--------|-------------|------|------|
| **NixOS with Full Desktop** | Run desktop environment on NixOS host directly | • Simple setup<br>• Direct hardware access<br>• No virtualization overhead | • Desktop experiments can crash server<br>• Desktop consumes resources 24/7<br>• Violates server uptime priority |
| **NixOS with Minimal GUI + Arch VM** | Lightweight compositor on NixOS, Arch VM uses virtual display | • Some host GUI capability<br>• VM isolation | • Host still has GUI overhead<br>• VM doesn't get native GPU performance<br>• Complex display forwarding |
| **Headless NixOS + GPU Passthrough (CHOSEN)** | NixOS text console only, pass GPU to Arch VM via VFIO | • **Server completely isolated from desktop**<br>• **Arch VM gets native GPU performance**<br>• **Zero GUI overhead on host**<br>• Physical monitor controlled by VM | • More complex setup (VFIO)<br>• GPU unavailable to host when VM runs<br>• Only one VM can use GPU |

**How It Works:**
1. NixOS runs headless (text console/TTY only, no X11/Wayland)
2. Intel N97 GPU passed through to Arch VM via VFIO/PCI passthrough
3. Arch VM gets exclusive GPU control - outputs directly to physical HDMI monitor
4. When Arch VM is OFF: monitor shows NixOS text console or blank
5. When Arch VM is ON: monitor shows Arch desktop (Hyprland/Wayland)
6. NixOS host never touches display - runs blind/headless 24/7

**Implications for Other Use Cases:**
- **Wine apps:** Must run inside Arch VM (which has desktop environment), not on headless NixOS host
- **Waydroid:** Cannot run on headless NixOS (needs Wayland compositor) - must use Android-x86 VM in Arch instead

**Decision Rationale:**
- Aligns with server uptime priority (desktop can't crash server)
- Arch VM gets native GPU performance for Wayland/Hyprland experimentation
- NixOS host stays lean and focused on server workloads

### Appendix C: Resource Allocation Strategy

**Decision: Dynamic On-Demand Allocation**

**Problem:** How to ensure NixOS server gets full resources while allowing Arch desktop experimentation?

**Options Considered:**

| Approach | Description | Server Impact | Desktop Experience |
|----------|-------------|---------------|-------------------|
| **Static Allocation** | Pre-allocate fixed resources to each environment | Host always constrained to partial resources even when VM idle | Guaranteed VM resources but wasteful |
| **Always-On VM** | Keep Arch VM running 24/7 | Constant 5-10% overhead, reduced server RAM | Instant desktop access |
| **On-Demand Startup (CHOSEN)** | Start Arch VM only when needed | **Zero overhead when VM off** | Few seconds to start VM |

**Three-Part Implementation:**

1. **On-Demand VM Startup (Primary)**
   - Start Arch VM only when experimenting: `virsh start arch-desktop`
   - Shutdown when done: `virsh shutdown arch-desktop`
   - Result: Zero overhead when VM off (~11GB RAM, all 4 cores to NixOS)

2. **CPU Priority Scheduling (When VM Running)**
   - NixOS host: CPU shares=2048 (higher priority)
   - Arch VM: CPU shares=1024 (lower priority)
   - Result: Server workloads never starve, desktop gets leftover cycles

3. **Memory Ballooning (Optional Safety Net)**
   - Configure virtio-balloon driver in Arch VM
   - NixOS can reclaim unused memory from idle VM
   - Result: Protection if you forget to shut down VM

**Resource Distribution:**
```
When Arch VM is OFF:
  NixOS Host: ~11GB RAM, all 4 CPU cores, full disk I/O

When Arch VM is ON:
  NixOS Host: ~5-6GB RAM, 2 cores prioritized, shared disk I/O
  Arch VM:    ~5-6GB RAM, 2 cores, 100GB disk
```

**Decision Rationale:**
- Primary use case (server) gets 100% resources most of the time
- Desktop experimentation doesn't impact server performance
- Simple workflow: start VM when needed, shut down when done

### Appendix D: Technical Reference

#### VM Configuration Specifications

**Arch Linux Desktop VM (QEMU/KVM with libvirt):**
- **RAM:** 6GB allocated, memory ballooning enabled
- **CPU:** 2 vCPUs, CPU shares=1024, host-passthrough mode
- **Disk:** 100GB, VirtIO drivers for optimal performance
- **GPU:** Intel N97 passed through via VFIO/PCI passthrough
- **Network:** Bridge network for host/VM/MacBook connectivity

**Libvirt XML Configuration:**
```xml
<memoryBacking>
  <hugepages/>
</memoryBacking>
<memory unit='GiB'>6</memory>
<currentMemory unit='GiB'>6</currentMemory>
<memballoon model='virtio'/>

<cpu mode='host-passthrough'>
  <topology sockets='1' cores='2' threads='1'/>
</cpu>
<cputune>
  <shares>1024</shares>
</cputune>
```

#### Access Patterns

**From MacBook:**
- SSH to NixOS host → `ssh user@nixos-host` (primary workflow)
- Remote desktop to Arch VM → VNC/RDP/Wayland protocols
- RDP to Windows VM (future) → Remote desktop connection

**Physical Access:**
- NixOS text console: Available when Arch VM is off
- Arch VM desktop: Physical HDMI monitor + keyboard when VM is on (via GPU passthrough)

#### Network Architecture
- NixOS host: Bridge network for VM connectivity
- All VMs accessible from MacBook via host network
- VMs can access host services (dev server, containers)
- External services exposed via NixOS host firewall rules

#### Services on NixOS Host
- Dev server: Code repositories, development environments
- Application server: systemd services, container orchestration
- Network services: Accessible via SSH/HTTP(S) from MacBook
- All declared in NixOS flake configuration