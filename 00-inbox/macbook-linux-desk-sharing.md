
### The Concept

* **Keyboard/Mouse (Control Plane):** Your MacBook ("Server") captures your keystrokes and sends them over WiFi to Vermax ("Client") via **Input Leap**.
* **Video (Display Plane):** Vermax ("Server") pretends to be an Apple TV using **UxPlay**. Your MacBook ("Client") sends its video over WiFi to the Vermax monitor.

---

### The Setup Guide

#### Phase 1: Configure Vermax (NixOS)

You need to install the tools and, crucially, open the firewall for AirPlay (mDNS) and Input Leap.

Add this to your `configuration.nix` and rebuild (`sudo nixos-rebuild switch`):

```nix
{ config, pkgs, ... }:

{
  # 1. Install Packages
  environment.systemPackages = with pkgs; [
    input-leap  # The open-source fork of Barrier/Deskflow
    uxplay      # The AirPlay server
  ];

  # 2. Enable Avahi (Required for Mac to "see" Vermax via AirPlay)
  services.avahi = {
    enable = true;
    nssmdns4 = true; # Allow resolving .local domains
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
      userServices = true;
    };
  };

  # 3. Open Firewall Ports
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      24800       # Input Leap / Barrier
      7000 7001   # AirPlay (Video/Audio)
      7100        # AirPlay (Mirroring)
    ];
    allowedUDPPorts = [
      5353        # mDNS / Avahi (Discovery)
      6000 6001 7011 # AirPlay (Audio/Video sync)
    ];
  };
}

```

#### Phase 2: Configure Moondancer (MacBook)

**1. Set up Input Leap (Control)**

1. Download **Deskflow** (or Barrier/Input Leap) for macOS.
2. Open it and select **Server** (Share this computer's mouse and keyboard).
3. Click **Configure Server**.
4. Drag the "Screen" icon from the top right into the grid, placing it relative to your Mac (e.g., if Vermax monitor is behind the Mac, place it above).
5. Double-click that new screen icon and name it exactly: `vermax` (or whatever `hostname` your desktop reports).
6. Start the Server.

**2. Connect via AirPlay (Video)**

* *Wait until you start UxPlay on Vermax (see below).*

---

### The "Day-to-Day" Workflow

#### Step 1: Link the Controls (Input Leap)

On Vermax, open a terminal and run the client to connect to your Mac (replace `MOONDANCER_IP` with your Mac's IP address, or `moondancer.local` if multicast is working):

```bash
# Run this on Vermax
input-leapc --name vermax MOONDANCER_IP

```

* *Tip: You can add this to your window manager's startup config (e.g., Hyprland `exec-once`) so it happens automatically.*
* **Test:** Move your mouse off the Mac screen. It should appear on the Vermax monitor.

#### Step 2: Extend the Display (UxPlay)

When you want to use the Vermax monitor as a screen for the Mac:

1. **On Vermax:** Run the AirPlay server.
```bash
uxplay

```


* *You should see a "Server is listening..." message.*


2. **On Moondancer:**
* Open **Control Center** (top right).
* Click **Screen Mirroring**.
* Select **"UxPlay@vermax"**.
* Your Mac screen will appear on the Vermax monitor. Right-click the icon in the Mac menu bar to choose "Use as Separate Display" instead of "Mirror".



### Important Notes

* **Latency:** Input Leap (Keyboard) is usually near-instant. UxPlay (Video) depends heavily on your WiFi router. If it's laggy, try to use Ethernet on Vermax at least.
* **Wayland Users:** If Vermax runs Hyprland or standard GNOME (Wayland), `input-leap` might struggle to move the mouse cursor. If so, try running it with `WAYLAND_DISPLAY=wayland-1 input-leapc ...` or check if your compositor requires specific plugins for virtual input.
