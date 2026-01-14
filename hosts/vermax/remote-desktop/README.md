# Remote Desktop on Vermax

## Purpose

Access my Linux desktop remotely from moondancer (MacBook) over Tailscale. Vermax is a dual-use desktop/server that sometimes has its display asleep when I'm away.

Requirements:
- Use my CLI and desktop configurations (including PaperWM tiling)
- Work when display is asleep or no local login
- Remote management capability

## Solutions

Three remote desktop options for different use cases:
- **XRDP**: Remote login (works without active session, like Windows RDP)
- **Sunshine**: High-performance streaming (best for gaming/graphics, needs active session)
- **RustDesk**: Quick access and file transfer

## Get Vermax Tailscale IP

```bash
ssh nikhilmaddirala@vermax
tailscale ip -4
# Example: 100.126.196.6
```

## Comparison

| Solution | Best For | Performance | Client |
|----------|----------|-------------|--------|
| **XRDP** | Work access, remote login | Good | Microsoft RDP |
| **Sunshine** | Gaming, high-performance streaming | Excellent (4K@120Hz) | Moonlight |
| **RustDesk** | Quick access, file transfer | Good | RustDesk |

## Configuration

Enable/disable in `hosts/vermax/configuration.nix`:

```nix
myRemoteDesktop = {
  sunshine.enable = true;   # High-performance streaming
  rustdesk.enable = true;   # Quick access + file transfer
  xrdp.enable = true;       # Remote login (works without active session)
  gnomeRdp.enable = false;  # Alternative RDP (disabled, complex config)
};
```

## Sunshine + Moonlight

High-performance streaming for gaming and graphics work.

### Client Setup

```bash
brew install --cask moonlight
```

### First-Time Setup

1. Access web UI: `https://<vermax-tailscale-ip>:47990` (use HTTPS)
2. Accept the self-signed certificate warning
3. Create username and password (saved to `~/.config/sunshine/sunshine_state.json`)

### Connection

1. Open Moonlight, click "Add Host Manually"
2. Enter: `<vermax-tailscale-ip>:47989`
3. Get pairing PIN from Sunshine web UI and enter it in Moonlight

### Optimal Quality Settings for Retina Display

After pairing, configure Moonlight for best quality (click gear icon on host):

**Video Settings:**
- **Resolution**: 2560x1440 (recommended) or 3840x2160 (4K)
  - Choose based on your MacBook's retina display resolution
  - Sunshine will create a virtual display at this resolution regardless of physical monitor
- **FPS**: 60 (or 120 for ultra-smooth motion)
- **Bitrate**: 30-50 Mbps
  - Start at 30 Mbps, increase to 40-50 if bandwidth allows
  - Higher bitrate = sharper text and better quality
- **Video codec**: HEVC (H.265)
  - Better quality than H.264 at same bitrate
  - 30-40% more efficient compression

**Performance Settings:**
- **Hardware acceleration**: Enabled (default on Mac)
- **Optimize for streaming**: Off (prioritize quality over ultra-low latency)
- **V-Sync**: On (reduces screen tearing)

**Quality vs Performance Tradeoff:**

If you experience stuttering:
- Lower bitrate to 20-25 Mbps
- Try 1920x1080 resolution first
- Reduce FPS to 30

If you see blurriness:
- Increase bitrate to 40-50 Mbps
- Verify HEVC codec is selected
- Check network latency: `ping <vermax-tailscale-ip>`

### Troubleshooting

- **Can't find monitors**: Display is asleep. Wake it:
  ```bash
  ssh nikhilmaddirala@vermax "gdbus call --session --dest org.gnome.ScreenSaver --object-path /org/gnome/ScreenSaver --method org.gnome.ScreenSaver.SetActive false"
  ssh nikhilmaddirala@vermax "systemctl --user restart sunshine"
  ```
- **Black screen**: Not logged into graphical session
- **No audio**: Restart Sunshine: `systemctl --user restart sunshine`

## RustDesk

Simple remote access with built-in file transfer.

### Client Setup

```bash
brew install --cask rustdesk
```

### Connection

Via Tailscale (recommended):
1. Start RustDesk app on vermax
2. Open RustDesk on client
3. Choose "Direct IP Address"
4. Enter: `<vermax-tailscale-ip>`

Via public relay (simpler but slower):
1. Enter connection ID shown in RustDesk on vermax
2. Connect through public relay

## XRDP

Remote login capability. Works without active graphical session.

### Client Setup

```bash
brew install --cask microsoft-remote-desktop
```

### Connection

1. Open Microsoft Remote Desktop
2. Add PC: `<vermax-tailscale-ip>:3389`
3. Username: `nikhilmaddirala`
4. Password: Your vermax password

### Troubleshooting

- **Connection refused**: `systemctl status xrdp`
- **Port blocked**: `sudo nft list ruleset | grep 3389`
- **Service logs**: `journalctl -u xrdp -f`

## Common Issues

Can't connect to any service:
```bash
sudo tailscale status
tailscale ip -4
sudo systemctl restart tailscaled  # if needed
```

Poor performance:
- Use wired connection instead of WiFi
- Try Sunshine for better performance
- Lower resolution/bitrate in client settings

---

## Appendix

### Architecture

Vermax runs NixOS with GNOME and Hyprland. All solutions integrate with Tailscale VPN for secure remote access.

Firewall configuration:
- `tailscale0` added as trusted interface
- XRDP: TCP 3389 (auto-opened via services.xrdp.openFirewall)
- Sunshine: TCP 47984-47990, UDP 47998-48010
- RustDesk: Dynamic ports (Tailscale recommended)

### Sunshine Details

Configuration:
- User service (starts on graphical login)
- Performance preset (low latency over quality)
- HEVC (H.265) encoding for better quality at same bitrate
- 30 Mbps baseline bitrate (client can request higher)
- Wayland support via `capSysAdmin = true`
- Web UI: `https://localhost:47990` (HTTPS required for remote access)
- First-run credentials saved to `~/.config/sunshine/sunshine_state.json`
- Virtual display support via GNOME experimental features

Virtual Display Support:
- Streams at any resolution regardless of physical monitor
- GNOME's `scale-monitor-framebuffer` experimental feature enabled
- Sunshine captures high-resolution framebuffer and streams to client
- Perfect for retina displays: stream 1440p/4K even with 1080p monitor
- Zero performance penalty (no physical display driven at high resolution)

Limitations:
- Requires active graphical session
- Display must be awake (not in sleep mode)
- Must logout/login after NixOS rebuild

Performance:
- 4K @ 120Hz capable
- HEVC encoding: 30-40% better quality vs H.264 at same bitrate
- 10-20ms latency on LAN
- 50-100ms via Tailscale (long distance)

Wake display when asleep:
```bash
gdbus call --session --dest org.gnome.ScreenSaver --object-path /org/gnome/ScreenSaver --method org.gnome.ScreenSaver.SetActive false
systemctl --user restart sunshine
```

### RustDesk Details

Configuration:
- Manual start (user application)
- No systemd service
- Optional: Add to GNOME startup applications for auto-start

Connection methods:
- Public relay (works everywhere, slower)
- Direct via Tailscale (faster, more private)
- LAN (best performance locally)

### XRDP Details

Configuration:
- Native NixOS service with full declarative support
- Uses GNOME session as default window manager
- Firewall auto-configured (TCP 3389)
- Works without active graphical session
- Sleep/suspend disabled for uninterrupted remote sessions
- Auto-login disabled for security

Benefits:
- Simpler than GNOME Remote Desktop (no complex scripts)
- Better NixOS integration
- No polkit/pkexec authentication issues
- Proven, stable RDP implementation

### GNOME RDP Details (Alternative, Disabled)

Configuration approach:
- System daemon (`--system` mode) for headless remote login
- User daemon explicitly disabled to prevent conflicts
- TLS certificates auto-generated via `winpr-makecert`
- RDP backend auto-enabled via `grdctl` in systemd postStart

Why the complex configuration:
- NixOS lacks native options for gnome-remote-desktop configuration ([Issue #266774](https://github.com/NixOS/nixpkgs/issues/266774))
- Only has `services.gnome.gnome-remote-desktop.enable = true` option
- System daemon requires `grdctl --system` (no gsettings/dconf support)
- Scripts in preStart/postStart are the standard NixOS pattern for this service
- Fully declarative and reproducible despite using scripts

System vs User daemon:
- System: Remote login capability (like Windows RDP), works headlessly
- User: Session sharing (like TeamViewer), requires active session
- We use system daemon only to enable headless access

Known limitations:
- GNOME only (doesn't work with Hyprland)
- Poor multi-monitor performance (known upstream bug)
- Lower performance than Sunshine
- Scripts required due to missing NixOS options

### Implementation Notes

Modular design:
- `xrdp.nix` - Native NixOS RDP service
- `sunshine.nix` - User service configuration
- `rustdesk.nix` - Package installation only
- `gnome-rdp.nix` - Alternative RDP (disabled, complex config)

All modules are independent and can be enabled/disabled separately.

### Advanced Troubleshooting

XRDP:
```bash
# Check service status
systemctl status xrdp

# View logs
journalctl -u xrdp -f

# Check if listening on port 3389
sudo ss -tlnp | grep 3389

# Restart service
sudo systemctl restart xrdp
```

Sunshine:
```bash
# Check service status
systemctl --user status sunshine

# View logs
journalctl --user -u sunshine -f

# Restart service
systemctl --user restart sunshine
```

RustDesk:
```bash
# Verify installation
which rustdesk

# Check if running
ps aux | grep rustdesk
```

GNOME RDP:
```bash
# Check system service
systemctl status gnome-remote-desktop

# Verify configuration
sudo grdctl --system status

# View logs
journalctl -u gnome-remote-desktop -f

# Regenerate certificates
sudo rm -rf /var/lib/gnome-remote-desktop/rdp-tls.*
sudo systemctl restart gnome-remote-desktop
```

Verify only system daemon running:
```bash
# Should show only ONE process with --system flag
ps aux | grep gnome-remote-desktop | grep -v grep
```

### Self-Hosting RustDesk Relay (Optional)

Not implemented but possible via `services.rustdesk-server.enable = true`. Use Tailscale direct connection instead for better privacy without relay complexity.
