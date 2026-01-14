# Traefik reverse proxy configuration for seasmoke
{ config, pkgs, ... }:
{

  services.traefik = {
    enable = true;

    staticConfigOptions = {
      log = {
        level = "WARN";
      };

      # Certificate resolver using Cloudflare DNS challenge
      certificatesResolvers = {
        cloudflare = {
          acme = {
            email = "nikhil@nikhilmaddirala.com"; # Update with your email
            storage = "/var/lib/traefik/acme.json";
            caserver = "https://acme-v02.api.letsencrypt.org/directory";
            dnsChallenge = {
              provider = "cloudflare";
              resolvers = [
                "1.1.1.1:53"
                "8.8.8.8:53"
              ];
              delayBeforeCheck = "10s";
            };
          };
        };
      };

      # API for dashboard access
      api = { };

      # Entry points
      entryPoints = {
        web = {
          address = ":${toString config.seasmoke.ports.traefik.http}";
          http.redirections.entryPoint = {
            to = "websecure";
            scheme = "https";
          };
        };
        websecure = {
          address = ":${toString config.seasmoke.ports.traefik.https}";
        };
      };
    };

    dynamicConfigOptions = {
      http = {
        # Default security middleware
        middlewares = {
          default-headers = {
            headers = {
              frameDeny = true;
              forceSTSHeader = true;
              stsIncludeSubdomains = true;
              stsSeconds = 31536000; # 1 year
            };
          };

          # Basic auth for Traefik dashboard
          auth = {
            basicAuth = {
              users = [
                # Generated with: htpasswd -nb admin password
                "admin:$apr1$xEDvUe67$vUtDrC/2U22gHwyfq0TgX1" # admin:password
              ];
            };
          };
        };

        # Traefik dashboard route
        routers = {
          api = {
            rule = "Host(`traefik.nikhilmaddirala.com`)";
            service = "api@internal";
            middlewares = [
              "auth"
              "default-headers"
            ];
            entrypoints = [ "websecure" ];
            tls = {
              certResolver = "cloudflare";
            };
          };
        };
      };
    };
  };

  # Set Cloudflare credentials for DNS challenge
  # Use LoadCredential and set the correct environment variable
  systemd.services.traefik.serviceConfig = {
    LoadCredential = [ "cloudflare-token:${config.sops.secrets."cloudflare/api_token_seasmoke".path}" ];
    Environment = [ "CLOUDFLARE_DNS_API_TOKEN_FILE=%d/cloudflare-token" ];
  };

  # Open firewall ports
  networking.firewall.allowedTCPPorts = [
    config.seasmoke.ports.traefik.http
    config.seasmoke.ports.traefik.https
  ];
}
