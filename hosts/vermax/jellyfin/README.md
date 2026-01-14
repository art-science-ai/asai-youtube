# Jellyfin Media Server Module

Free software media system for streaming media to devices on your network and via Tailscale.

## What is Jellyfin?

Jellyfin is a free software media system that puts you in control of managing and streaming your media library. It provides:

- Media organization for movies, TV shows, music, and photos
- Web-based interface for browsing and playback
- Mobile apps for iOS and Android
- Client apps for smart TVs, Roku, and other devices
- Subtitle support and transcoding capabilities
- Multi-user support with parental controls

## Configuration

This module enables Jellyfin with Tailscale integration for secure remote access.

### Ports

- **8096** - HTTP web UI and media streaming (primary port)

### Tailscale Access

Jellyfin is accessible via Tailscale using:

```bash
# Access Jellyfin web UI
http://vermax:8096
```

Or via your Tailnet IP:

```bash
# Get the Tailscale IP
tailscale ip -4

# Access via IP
http://<tailscale-ip>:8096
```

## Setup Instructions

### 1. Enable the Module

The module is enabled in `configuration.nix`:

```nix
myJellyfin.enable = true;
```

### 2. Initial Configuration

After rebuilding your system:

1. Access the web UI at `http://localhost:8096` or `http://vermax:8096` via Tailscale
2. Create your admin account
3. Set up your media library by adding folders containing:
   - Movies
   - TV shows
   - Music
   - Photos

### 3. Recommended Media Directory Structure

```
/media/
├── movies/
│   ├── Movie Name (Year)/
│   │   └── Movie Name (Year).mkv
├── tvshows/
│   └── Series Name/
│       ├── Season 01/
│       │   └── Series Name - S01E01.mkv
│       └── Season 02/
│           └── Series Name - S02E01.mkv
└── music/
    └── Artist Name/
        └── Album Name/
            └── 01 Song Name.mp3
```

### 4. Storage Configuration

For optimal performance, store media on a drive with adequate space:

```bash
# Create media directory (adjust path as needed)
sudo mkdir -p /media/{movies,tvshows,music}

# Set permissions so Jellyfin can read the media
sudo chown -R jellyfin:jellyfin /media
```

## Remote Access via Tailscale

Jellyfin is accessible from any device on your Tailnet:

1. Install Tailscale on your client device (phone, tablet, laptop)
2. Log in to the same Tailnet
3. Access Jellyfin using the hostname: `http://vermax:8096`

This provides:
- Encrypted remote streaming
- No need to open ports to the internet
- Access from anywhere with an internet connection

## Hardware Acceleration (Optional)

For hardware transcoding on Intel/AMD systems:

```nix
services.jellyfin = {
  enable = true;
  openFirewall = true;
  # Add VAAPI or VDPAU support if needed
};
```

## Client Apps

Install Jellyfin clients on your devices:

- **Web**: Browser-based (already included)
- **Android**: [Jellyfin Android](https://play.google.com/store/apps/details?id=org.jellyfin.mobile)
- **iOS**: [Jellyfin iOS](https://apps.apple.com/app/jellyfin-mobile/idid1457722624)
- **Smart TVs**: Check the [Jellyfin downloads](https://jellyfin.org/downloads/) page

## Troubleshooting

### Service Status

```bash
# Check if Jellyfin is running
systemctl status jellyfin

# View logs
journalctl -u jellyfin -f
```

### Firewall Issues

If you can't access Jellyfin remotely:

```bash
# Verify the port is open
sudo nmap -p 8096 localhost

# Check trusted interfaces include tailscale0
# This is automatically configured by the module
```

### Permission Issues

If Jellyfin can't access media files:

```bash
# Check Jellyfin user
sudo -u jellyfin groups

# Add jellyfin user to necessary groups
sudo usermod -aG video jellyfin  # For hardware acceleration
```

## Resources

- [Jellyfin Documentation](https://jellyfin.org/docs/)
- [Jellyfin Community Forum](https://forum.jellyfin.org/)
- [Tailscale Documentation](https://tailscale.com/kb/)
