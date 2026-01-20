# Plan: Add Nixflix Media Server Stack to Vermax

## Overview

Integrate the [nixflix](https://github.com/kiriwalawren/nixflix) NixOS module to create a declarative media server stack on vermax, with qBittorrent running remotely on sheepstealer.

**Architecture:**
- **vermax**: Jellyfin, Jellyseerr, Prowlarr, Radarr, Sonarr (management + streaming)
- **sheepstealer**: qBittorrent (seedbox) + media storage via SSHFS
- **Access**: All services via Tailscale (already configured)

**Reference implementation**: https://github.com/kiriwalawren/dotnix/tree/main/modules/nixos/server/nixflix

## Files to Create

### 1. `hosts/vermax/nixflix/default.nix`
Main nixflix module configuration:
- Import nixflix flake module
- Import individual service configs
- Configure SSHFS mount (migrate from existing jellyfin.nix)
- Set media directories and state paths
- Configure Tailscale firewall integration

```nix
{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    inputs.nixflix.nixosModules.default
    ./jellyfin.nix
    ./jellyseerr.nix
    ./prowlarr.nix
    ./radarr.nix
    ./sonarr.nix
  ];

  # Global nixflix configuration
  nixflix = {
    enable = true;
    mediaDir = "/mnt/media";
    downloadsDir = "/mnt/media/downloads";
    stateDir = "/var/lib/nixflix";
    nginx.enable = false;  # Using Tailscale direct access
    mediaUsers = [ "nikhilmaddirala" ];
  };

  # SSHFS mount from sheepstealer (migrated from jellyfin.nix)
  fileSystems."/mnt/media" = {
    device = "sheepstealer:/home/box_ring_fence/media";
    fsType = "fuse.sshfs";
    options = [
      "_netdev"
      "x-systemd.requires=network-online.target"
      "x-systemd.after=network-online.target"
      "x-systemd.requires=tailscaled.service"
      "x-systemd.after=tailscaled.service"
      "connecttimeout=10"
      "reconnect"
      "idmap=user"
      "allow_other"
      "default_permissions"
    ];
  };

  networking.firewall.trustedInterfaces = lib.mkAfter [ "tailscale0" ];

  systemd.tmpfiles.rules = [
    "d /var/lib/nixflix 0755 root media -"
  ];
}
```

### 2. `hosts/vermax/nixflix/prowlarr.nix`
Indexer manager configuration:

```nix
{ config, ... }:

{
  nixflix.prowlarr = {
    enable = true;
    openFirewall = false;  # Tailscale handles access
    config = {
      apiKeyPath = config.sops.secrets."nixflix/prowlarr/api_key".path;
    };
  };
}
```

### 3. `hosts/vermax/nixflix/radarr.nix`
Movie automation with remote qBittorrent:

```nix
{ config, ... }:

{
  nixflix.radarr = {
    enable = true;
    openFirewall = false;
    mediaDirs = [ "/mnt/media/movies" ];

    config = {
      apiKeyPath = config.sops.secrets."nixflix/radarr/api_key".path;
    };

    settings.downloadClients = {
      qbittorrent = {
        enable = true;
        name = "qBittorrent (sheepstealer)";
        implementationName = "QBittorrent";
        host = "sheepstealer";  # Tailscale hostname
        port = 8080;
        username = "admin";
        passwordPath = config.sops.secrets."nixflix/qbittorrent/password".path;
        movieCategory = "radarr";
        removeCompletedDownloads = true;
      };
    };

    settings.remotePathMappings = [{
      host = "sheepstealer";
      remotePath = "/home/box_ring_fence/media/downloads";
      localPath = "/mnt/media/downloads";
    }];
  };
}
```

### 4. `hosts/vermax/nixflix/sonarr.nix`
TV series automation:

```nix
{ config, ... }:

{
  nixflix.sonarr = {
    enable = true;
    openFirewall = false;
    mediaDirs = [ "/mnt/media/tv" ];

    config = {
      apiKeyPath = config.sops.secrets."nixflix/sonarr/api_key".path;
    };

    settings.downloadClients = {
      qbittorrent = {
        enable = true;
        name = "qBittorrent (sheepstealer)";
        implementationName = "QBittorrent";
        host = "sheepstealer";
        port = 8080;
        username = "admin";
        passwordPath = config.sops.secrets."nixflix/qbittorrent/password".path;
        tvCategory = "sonarr";
        removeCompletedDownloads = true;
      };
    };

    settings.remotePathMappings = [{
      host = "sheepstealer";
      remotePath = "/home/box_ring_fence/media/downloads";
      localPath = "/mnt/media/downloads";
    }];
  };
}
```

### 5. `hosts/vermax/nixflix/jellyfin.nix`
Media streaming server:

```nix
{ config, ... }:

{
  nixflix.jellyfin = {
    enable = true;
    openFirewall = false;

    network = {
      httpPort = 8096;
      httpsPort = 8920;
      autoDiscovery = true;
    };

    # Enable if vermax has Intel iGPU
    # encoding.hardwareAcceleration = "vaapi";
  };
}
```

### 6. `hosts/vermax/nixflix/jellyseerr.nix`
Request management interface:

```nix
{ config, ... }:

{
  nixflix.jellyseerr = {
    enable = true;
    openFirewall = false;
    port = 5055;
  };
}
```

## Files to Modify

### 1. `flake.nix`
Add nixflix flake input (after line ~50):

```nix
nixflix = {
  url = "github:kiriwalawren/nixflix";
  inputs.nixpkgs.follows = "nixpkgs";
};
```

### 2. `hosts/vermax/default.nix`
Update imports:

```nix
{ inputs, ... }:
{
  imports = [
    ../../modules/hosts/base
    ../../modules/hosts/nix-settings
    ../../modules/hosts/users-shells
    ../../modules/hosts/sops
    ../../modules/hosts/desktop
    ../../modules/hosts/nixos-server
    ./disk-config.nix
    ./swap.nix
    ./hibernate.nix
    ./hardware-configuration.nix
    ./configuration.nix
    ./snapper.nix
    ./remote-desktop/sunshine.nix
    ./remote-desktop/rustdesk.nix
    ./remote-desktop/gnome-rdp.nix
    ./remote-desktop/xrdp.nix
    # ./jellyfin/jellyfin.nix  # REMOVED: Replaced by nixflix
    ./nixflix                   # NEW: Nixflix media stack
    inputs.disko.nixosModules.disko
    inputs.sops-nix.nixosModules.sops
    inputs.nix-index-database.nixosModules.nix-index
    inputs.nix-flatpak.nixosModules.nix-flatpak
  ];

  nixpkgs.overlays = [
    (import ../../overlays/whisper-diarization.nix)
  ];
}
```

### 3. `hosts/vermax/configuration.nix`
Remove line 31: `myJellyfin.enable = false;`

### 4. `modules/common/secrets-registry.nix`
Add secret definitions inside `secretDefinitions`:

```nix
prowlarr-api-key = {
  sopsPath = "nixflix/prowlarr/api_key";
  filePath = "/run/secrets/nixflix/prowlarr/api_key";
  envVar = "PROWLARR_API_KEY";
  owner = "prowlarr";
  mode = "0400";
};

radarr-api-key = {
  sopsPath = "nixflix/radarr/api_key";
  filePath = "/run/secrets/nixflix/radarr/api_key";
  envVar = "RADARR_API_KEY";
  owner = "radarr";
  mode = "0400";
};

sonarr-api-key = {
  sopsPath = "nixflix/sonarr/api_key";
  filePath = "/run/secrets/nixflix/sonarr/api_key";
  envVar = "SONARR_API_KEY";
  owner = "sonarr";
  mode = "0400";
};

jellyfin-api-key = {
  sopsPath = "nixflix/jellyfin/api_key";
  filePath = "/run/secrets/nixflix/jellyfin/api_key";
  envVar = "JELLYFIN_API_KEY";
  owner = "jellyfin";
  mode = "0400";
};

jellyseerr-api-key = {
  sopsPath = "nixflix/jellyseerr/api_key";
  filePath = "/run/secrets/nixflix/jellyseerr/api_key";
  envVar = "JELLYSEERR_API_KEY";
  owner = "jellyseerr";
  mode = "0400";
};

qbittorrent-password = {
  sopsPath = "nixflix/qbittorrent/password";
  filePath = "/run/secrets/nixflix/qbittorrent/password";
  envVar = "QBITTORRENT_PASSWORD";
  owner = "root";
  mode = "0400";
};
```

### 5. `vars/secrets.yaml`
Add encrypted values (encrypt manually with SOPS):

```yaml
nixflix:
  prowlarr:
    api_key: ENC[...]
  radarr:
    api_key: ENC[...]
  sonarr:
    api_key: ENC[...]
  jellyfin:
    api_key: ENC[...]
  jellyseerr:
    api_key: ENC[...]
  qbittorrent:
    password: ENC[...]
```

## Service Ports (via Tailscale)

| Service | Port | URL |
|---------|------|-----|
| Jellyfin | 8096 | http://vermax:8096 |
| Jellyseerr | 5055 | http://vermax:5055 |
| Prowlarr | 9696 | http://vermax:9696 |
| Radarr | 7878 | http://vermax:7878 |
| Sonarr | 8989 | http://vermax:8989 |

## Directory Structure on sheepstealer

Ensure these directories exist:

```
/home/box_ring_fence/media/
├── movies/           # Radarr managed
├── tv/               # Sonarr managed
└── downloads/        # qBittorrent downloads
    ├── radarr/       # Category for movie downloads
    └── sonarr/       # Category for TV downloads
```

Configure qBittorrent categories to save to these paths.

## Remote Path Mapping

Critical for connecting remote qBittorrent to local Arr services:

| Location | Path |
|----------|------|
| sheepstealer (remote) | `/home/box_ring_fence/media/downloads` |
| vermax (local via SSHFS) | `/mnt/media/downloads` |

When qBittorrent reports a download at the remote path, Radarr/Sonarr look at the local path.

## Implementation Sequence

1. **Secrets setup**
   - Add definitions to `modules/common/secrets-registry.nix`
   - Generate API keys for each service (can be any random string initially)
   - Get qBittorrent WebUI password from sheepstealer
   - Encrypt values in `vars/secrets.yaml`

2. **Flake update**
   - Add nixflix input to `flake.nix`
   - Run: `nix flake update nixflix`

3. **Create nixflix directory**
   - Create `hosts/vermax/nixflix/` directory
   - Add all service configuration files

4. **Update host configuration**
   - Modify `hosts/vermax/default.nix` imports
   - Clean up `hosts/vermax/configuration.nix`

5. **Directory setup on sheepstealer**
   - Create media directory structure
   - Configure qBittorrent categories (radarr, sonarr)
   - Ensure SSHFS user has write permissions

6. **Build and test**
   ```bash
   nix build .#nixosConfigurations.vermax.config.system.build.toplevel
   ```

7. **Deploy**
   ```bash
   deploy .#vermax
   ```

8. **Post-deployment configuration**
   - Access each service via Tailscale URLs
   - Complete initial setup wizards
   - Configure indexers in Prowlarr (add your preferred indexers)
   - Verify download client connections in Radarr/Sonarr
   - Set up Jellyfin libraries
   - Configure Jellyseerr to integrate with Jellyfin + Arr services

## Verification Checklist

- [ ] Access Jellyfin at http://vermax:8096
- [ ] Access Jellyseerr at http://vermax:5055
- [ ] Access Prowlarr at http://vermax:9696 and add indexers
- [ ] Access Radarr at http://vermax:7878 and verify qBittorrent connection
- [ ] Access Sonarr at http://vermax:8989 and verify qBittorrent connection
- [ ] Test end-to-end: Request in Jellyseerr -> Arr grabs -> qBittorrent downloads -> Import to library

## Notes

- **PostgreSQL**: Using default SQLite initially; can migrate later for performance
- **Hardware transcoding**: Enable in Jellyfin if vermax has Intel iGPU (VAAPI)
- **Existing jellyfin/**: Can be deleted after nixflix is verified working
- **Nixflix docs**: https://kiriwalawren.github.io/nixflix/
