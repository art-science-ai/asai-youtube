# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

The m3tam3re-collection is a personal NixOS configuration collection focused on self-hosted services and infrastructure. It contains configurations for multiple hosts running various containerized applications and services, managed through NixOS flakes.

## Repository Architecture

### Core Structure
- **nixos-config/**: Main NixOS flake configuration
- **hosts/**: Host-specific configurations organized by hostname (m3-ares, m3-atlas, m3-helios, m3-kratos)
- **pkgs/**: Custom package definitions and derivations
- **secrets/**: Age-encrypted secrets managed by agenix
- **home/**: Home Manager configurations for user environments
- **modules/**: Custom NixOS and Home Manager modules
- **overlays/**: Nixpkgs overlays for package modifications

### Host Architecture
Each host follows a consistent structure:
- `default.nix`: Main host configuration entry point
- `configuration.nix`: System-level configuration
- `hardware-configuration.nix`: Hardware-specific settings
- `disko-config.nix`: Disk partitioning (where applicable)
- `services/`: Service-specific configurations
- `secrets.nix`: Age-encrypted secrets configuration

### Service Organization
Services are organized into two categories:
- **Native NixOS services**: Direct NixOS service configurations (gitea, postgres, traefik, etc.)
- **Container services**: Podman-based containerized applications in `containers/` subdirectories

## Essential Commands

### Flake Operations
```bash
# Navigate to nixos-config directory first
cd nixos-config/

# Show available configurations and packages
nix flake show

# Build specific host configuration
nix build .#nixosConfigurations.m3-atlas.config.system.build.toplevel

# Build custom packages
nix build .#packages.x86_64-linux.msty
nix build .#packages.x86_64-linux.zellij-ps
nix build .#packages.x86_64-linux.code2prompt

# Build Proxmox image for m3-hermes
nix build .#packages.x86_64-linux.proxmox-hermes-image
```

### Development Environment
```bash
# Enter infrastructure management shell
nix develop .#infraShell
```

### Host Management
```bash
# Rebuild host configuration (run on target host)
sudo nixos-rebuild switch --flake .#<hostname>

# Test configuration without switching
sudo nixos-rebuild test --flake .#<hostname>

# Build configuration remotely
nixos-rebuild switch --flake .#<hostname> --target-host <hostname>
```

### Secret Management
Secrets are managed using agenix with age encryption:
```bash
# Edit secrets (requires age key)
agenix -e secrets/<secret-file>.age

# Rekey all secrets after key changes
agenix -r
```

## Key Technologies

### Service Stack
- **Traefik**: Reverse proxy and load balancer with automatic HTTPS
- **PostgreSQL/MySQL**: Database backends for various applications
- **Podman**: Container runtime for containerized services
- **Tailscale/Headscale**: VPN networking between hosts
- **MinIO**: S3-compatible object storage
- **Various self-hosted apps**: Gitea, Vaultwarden, Paperless, N8N, etc.

### Infrastructure Components
- **Disko**: Declarative disk partitioning
- **Home Manager**: User environment management
- **Agenix**: Secret management with age encryption
- **Multiple Nixpkgs channels**: Stable, unstable, and pinned versions for different packages

### Custom Packages
The repository includes several custom packages:
- **msty**: Custom application
- **zellij-ps**: Process monitoring for Zellij terminal multiplexer
- **code2prompt**: Code extraction utility
- **pomodoro-timer**: Productivity timer
- **aider-chat-env**: AI coding assistant environment

## Host Configurations

### m3-atlas (Primary Services Host)
Runs the majority of self-hosted services including:
- Web applications (Ghost, Baserow, Outline)
- Development tools (Gitea, N8N, Kestra)
- Analytics and monitoring (Matomo)
- Media services (Restreamer)

### m3-helios (Network Services)
Focused on network infrastructure:
- AdGuard DNS filtering
- Traefik reverse proxy
- Dashboard services (Homarr)

### m3-ares & m3-kratos (Development/Testing)
Lighter configurations for development and testing purposes with basic services like N8N and PostgreSQL.

## Development Workflow

### Adding New Services
1. Create service configuration in appropriate `hosts/<hostname>/services/` directory
2. Add import to `services/default.nix`
3. Configure secrets in `secrets.nix` if needed
4. Test configuration with `nixos-rebuild test`
5. Apply with `nixos-rebuild switch`

### Managing Containers
Container services use Podman with a shared `web` network (10.89.0.0/24) for internal communication. Services are configured with:
- Environment files for secrets
- Volume mounts for persistent data
- Network configuration for Traefik integration

### Secret Management Workflow
1. Generate age keys for new hosts
2. Add public keys to `.agenix.nix`
3. Create encrypted secret files in `secrets/`
4. Reference secrets in host configurations
5. Rekey when adding new hosts or rotating keys

### Service Configuration on m3-atlas with Traefik

The `m3-atlas` host serves as the primary services host, managing a variety of self-hosted applications. Traefik is configured as the central reverse proxy, handling traffic routing, automatic HTTPS, and internal communication for these services.

**Traefik Base Configuration:**
Traefik is enabled as a NixOS service (`services.traefik.enable = true;`). Its core configuration includes:
- **Entrypoints:**
    - `web` (port 80): Redirects all HTTP traffic to `websecure` (HTTPS).
    - `websecure` (port 443): Handles all HTTPS traffic.
    - `rtmp` (port 1935) and `rtmps` (port 1945): Dedicated entrypoints for RTMP/RTMPS streaming protocols, primarily used by Restreamer.
- **Certificate Resolver:** `godaddy` is configured using Let's Encrypt's ACME v2 protocol with DNS challenges, ensuring automatic HTTPS certificate provisioning and renewal. Certificates are stored in `/var/lib/traefik/acme.json`.
- **Middlewares:**
    - `domain-redirect`: Redirects `www.m3tam3re.com` to `m3ta.dev`.
    - `strip-www`: Removes the `www.` prefix from hostnames.
    - `subdomain-redirect`: Redirects `*.m3tam3re.com` to `*.m3ta.dev`.
    - `auth`: Implements basic authentication for specific routes (e.g., Traefik's API dashboard).

**Service Hosting and Traefik Integration Details:**

Most containerized services on `m3-atlas` utilize a dedicated Podman `web` network (`10.89.0.0/24`) for internal communication. Traefik routes external requests to these services, which are typically exposed on `localhost` ports.

1.  **Baserow:**
    *   **Hosting:** Podman container (`docker.io/baserow/baserow`).
    *   **Configuration:** Mapped to `localhost:3001`, uses `baserow_data` volume, connects to an internal PostgreSQL instance.
    *   **Traefik:** Routes `br.m3ta.dev` and `br.m3tam3re.com` (with `subdomain-redirect` middleware) to `localhost:3001`.

2.  **Ghost:**
    *   **Hosting:** Podman container (`docker.io/ghost`).
    *   **Configuration:** Mapped to `localhost:3002`, uses `ghost_data` volume, connects to an internal MySQL instance.
    *   **Traefik:** Routes `m3ta.dev` and `www.m3ta.dev` (with `strip-www` middleware) to `localhost:3002`. Also handles redirects from `www.m3tam3re.com`.

3.  **Kestra:**
    *   **Hosting:** Podman container (`docker.io/kestra/kestra`).
    *   **Configuration:** Mapped to `localhost:3018`, mounts `/var/run/docker.sock` and a custom `application.yaml` config.
    *   **Traefik:** Routes `k.m3ta.dev` to `localhost:3018`.

4.  **Littlelink:**
    *   **Hosting:** Podman container (`ghcr.io/techno-tim/littlelink-server`).
    *   **Configuration:** Mapped to `localhost:3004`.
    *   **Traefik:** Routes `links.m3tam3re.com` to `localhost:3004`.

5.  **Matomo:**
    *   **Hosting:** Podman container (`docker.io/matomo`).
    *   **Configuration:** Mapped to `localhost:3011`, uses `matomo_data` volume, connects to an internal MySQL instance.
    *   **Traefik:** Routes `stats.nemoti.com` and `stats.m3tam3re.com` to `localhost:3011`.

6.  **Restreamer:**
    *   **Hosting:** Podman container (`docker.io/datarhei/restreamer`).
    *   **Configuration:** Mapped to `localhost:3006` (Web UI) and `localhost:1936` (RTMP).
    *   **Traefik:**
        *   **HTTP:** Routes `stream.m3ta.dev` to `localhost:3006`.
        *   **TCP (RTMP/RTMPS):** Routes RTMP traffic on port 1935 and RTMPS traffic on port 1945 (for `stream.m3tam3re.com`) to `localhost:1936`.

7.  **Slash (URL Shortener):**
    *   **Hosting:** Podman containers (`docker.io/yourselfhosted/slash`). Two instances are deployed.
    *   **Configuration:** Mapped to `localhost:3010` (for `l.m3ta.dev`) and `localhost:3016` (for `l.nemoti.art`).
    *   **Traefik:** Routes `l.m3ta.dev` to `localhost:3010` and `l.nemoti.art` to `localhost:3016`.

8.  **Gitea:**
    *   **Hosting:** Native NixOS service.
    *   **Configuration:** Configured with `HTTP_PORT = 3030`.
    *   **Traefik:** Routes `code.m3ta.dev` and `code.m3tam3re.com` (with `subdomain-redirect` middleware) to `localhost:3030`.

9.  **Headscale:**
    *   **Hosting:** Native NixOS service.
    *   **Configuration:** Listens on port 3009.
    *   **Traefik:** Routes `va.m3tam3re.com` to `localhost:3009`.

10. **MinIO:**
    *   **Hosting:** Native NixOS service.
    *   **Configuration:** Console on port 3007, API on port 3008.
    *   **Traefik:** Routes `minio.m3tam3re.com` to the console (`localhost:3007`) and `s3.m3tam3re.com` to the API (`localhost:3008`).

11. **N8N:**
    *   **Hosting:** Native NixOS service.
    *   **Configuration:** Configured with `webhookUrl = "https://wf.m3tam3re.com"`, listens on port 5678.
    *   **Traefik:** Routes `wf.m3ta.dev` to `localhost:5678`.

12. **Outline:**
    *   **Hosting:** Native NixOS service.
    *   **Configuration:** Listens on port 3019, `publicUrl = "https://ol.m3ta.dev"`.
    *   **Traefik:** Routes `ol.m3ta.dev` to `localhost:3019`.

13. **Paperless:**
    *   **Hosting:** Native NixOS service.
    *   **Configuration:** Listens on port 3012, `PAPERLESS_URL = "https://pl.m3ta.dev"`.
    *   **Traefik:** Routes `pl.m3ta.dev` to `localhost:3012`.

14. **Searx:**
    *   **Hosting:** Native NixOS service.
    *   **Configuration:** Listens on port 3005.
    *   **Traefik:** Routes `search.m3ta.dev` and `search.m3tam3re.com` (with `subdomain-redirect` middleware) to `localhost:3005`.

15. **Vaultwarden:**
    *   **Hosting:** Native NixOS service.
    *   **Configuration:** Listens on port 3013.
    *   **Traefik:** Routes `vw.m3ta.dev` to `localhost:3013`.

16. **Wastebin:**
    *   **Hosting:** Native NixOS service.
    *   **Configuration:** Listens on port 3003.
    *   **Traefik:** Routes `bin.m3ta.dev` and `bin.m3tam3re.com` (with `subdomain-redirect` middleware) to `localhost:3003`.

17. **Pangolin (VPN Management):**
    *   **Hosting:** Two Podman containers: `pangolin` (API/Next.js) and `gerbil` (WireGuard server).
    *   **Configuration:** `pangolin` exposes API on `localhost:3001` and Next.js on `localhost:3002`. `gerbil` exposes WireGuard on UDP port 51820.
    *   **Traefik:**
        *   **HTTP:** Routes `vpn.m3tam3re.com` to the Next.js frontend (excluding `/api/v1` paths) and to the API backend (for `/api/v1` paths).
        *   **Dynamic Configuration:** Traefik is configured to fetch additional dynamic routing rules directly from Pangolin's API (`http://localhost:3020/api/v1/traefik-config`), allowing Pangolin to manage its own Traefik configuration for VPN clients.
        *   **Firewall:** UDP port 51820 is opened for WireGuard.

This detailed setup demonstrates a robust and modular approach to service deployment and reverse proxying using NixOS and Traefik on the `m3-atlas` host.

### Adding a New Service and Traefik Integration

Adding a new service to the `m3tam3re-nixos-config` repository, especially for the `m3-atlas` host, follows a consistent and modular approach. This section outlines the steps to integrate a new service, whether it's a native NixOS service or a Podman container, and expose it via Traefik.

**1. Create the Service Configuration File**

First, create a new `.nix` file for your service within the appropriate directory under `hosts/m3-atlas/services/`.

*   **For a Podman Container:** Place the file in `hosts/m3-atlas/services/containers/your-service-name.nix`.
    ```nix
    # hosts/m3-atlas/services/containers/your-service-name.nix
    { config, ... }: {
      virtualisation.oci-containers.containers."your-service-name" = {
        image = "your-docker-image/name:tag";
        ports = ["127.0.0.1:YOUR_INTERNAL_PORT:CONTAINER_PORT"]; # Map to localhost
        volumes = ["your_data_volume:/path/in/container"];
        environment = {
          # Optional: Environment variables for your container
          YOUR_ENV_VAR = "value";
        };
        extraOptions = [
          "--ip=10.89.0.XX" # Assign a unique IP within the 'web' network
          "--network=web"   # Connect to the shared Podman 'web' network
          # Optional: Add --add-host for database connections if needed
          # "--add-host=postgres:10.89.0.1"
        ];
      };

      # Traefik configuration for this service (can be placed here or in traefik.nix)
      services.traefik.dynamicConfigOptions.http = {
        services.your-service-name.loadBalancer.servers = [
          { url = "http://localhost:YOUR_INTERNAL_PORT/"; }
        ];
        routers.your-service-name = {
          rule = "Host(`your-subdomain.m3ta.dev`)"; # Your desired hostname
          tls = {
            certResolver = "godaddy"; # Use the defined cert resolver
          };
          service = "your-service-name";
          entrypoints = "websecure"; # Always use websecure for HTTPS
        };
        # Optional: Add a redirect from the old domain if applicable
        # routers.your-service-name-old = {
        #   rule = "Host(`your-subdomain.m3tam3re.com`)";
        #   tls = { certResolver = "godaddy"; };
        #   service = "your-service-name";
        #   entrypoints = "websecure";
        #   middlewares = ["subdomain-redirect"];
        # };
      };
    }
    ```

*   **For a Native NixOS Service:** Place the file in `hosts/m3-atlas/services/your-service-name.nix`.
    ```nix
    # hosts/m3-atlas/services/your-service-name.nix
    { config, pkgs, ... }: {
      services.your-nixos-service = {
        enable = true;
        # Configure your NixOS service here
        # Example for a simple web server:
        # port = 8080;
        # documentRoot = "/var/www/your-service";
      };

      # Traefik configuration for this service
      services.traefik.dynamicConfigOptions.http = {
        services.your-nixos-service.loadBalancer.servers = [
          { url = "http://localhost:YOUR_SERVICE_PORT/"; } # Use the service's internal port
        ];
        routers.your-nixos-service = {
          rule = "Host(`your-subdomain.m3ta.dev`)";
          tls = {
            certResolver = "godaddy";
          };
          service = "your-nixos-service";
          entrypoints = "websecure";
        };
      };
    }
    ```

**2. Import the New Service Module**

You need to import your newly created service configuration file into the main `services/default.nix` for `m3-atlas`.

*   **For a Podman Container:** Add an `import` statement to `hosts/m3-atlas/services/containers/default.nix`.
    ```nix
    # hosts/m3-atlas/services/containers/default.nix
    {lib, ...}: {
      imports = [
        ./baserow.nix
        # ... other container services
        ./your-service-name.nix # Add this line
      ];
      # ... rest of the file
    }
    ```

*   **For a Native NixOS Service:** Add an `import` statement to `hosts/m3-atlas/services/default.nix`.
    ```nix
    # hosts/m3-atlas/services/default.nix
    {
      imports = [
        ./containers
        # ... other native services
        ./your-service-name.nix # Add this line
      ];
      # ... rest of the file
    }
    ```

**3. Manage Secrets (if applicable)**

If your service requires sensitive information (API keys, passwords, etc.), manage them using `agenix`.

*   Create an encrypted secret file in the `secrets/` directory (e.g., `secrets/your-service-secret.age`).
*   Add the secret to `secrets.nix` to define its public keys and path.
    ```nix
    # secrets.nix
    let
      # ... existing keys
    in {
      # ... existing secrets
      "secrets/your-service-secret.age".publicKeys = systems ++ users;
    }
    ```
*   Reference the secret in your service's `.nix` file using `config.age.secrets.your-service-secret.path`.

**4. Test and Deploy**

After making these changes, test and deploy your NixOS configuration:

1.  **Navigate to the `nixos-config` directory:**
    ```bash
    cd /path/to/your/nixos-config
    ```
2.  **Test the configuration (recommended):** This builds the configuration and checks for errors without applying it.
    ```bash
    sudo nixos-rebuild test --flake .#m3-atlas
    ```
3.  **Apply the configuration:** If the test is successful, switch to the new configuration.
    ```bash
    sudo nixos-rebuild switch --flake .#m3-atlas
    ```

By following these steps, your new service will be integrated into the NixOS system and exposed securely via Traefik with automatic HTTPS.