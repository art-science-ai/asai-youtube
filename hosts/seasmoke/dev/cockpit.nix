# Cockpit web-based server management interface for seasmoke
{ config, pkgs, ... }:

{

  # Cockpit service configuration
  services.cockpit = {
    enable = true;
    port = config.seasmoke.ports.cockpit;
    openFirewall = false; # Managed through Traefik
  };

  # Traefik service definition for Cockpit
  services.traefik.dynamicConfigOptions.http.services.cockpit = {
    loadBalancer = {
      servers = [
        { url = "http://127.0.0.1:${toString config.seasmoke.ports.cockpit}"; }
      ];
    };
  };

  # Middleware for Cockpit with basic auth
  services.traefik.dynamicConfigOptions.http.middlewares.cockpit-auth = {
    basicAuth = {
      users = [
        # Generated with: htpasswd -nb admin password
        "admin:$apr1$xEDvUe67$vUtDrC/2U22gHwyfq0TgX1" # admin:password
      ];
    };
  };

  # Traefik router for Cockpit
  services.traefik.dynamicConfigOptions.http.routers.cockpit = {
    rule = "Host(`cockpit.nikhilmaddirala.com`)";
    service = "cockpit";
    middlewares = [
      "cockpit-auth"
      "default-headers"
    ];
    entrypoints = [ "websecure" ];
    tls = {
      certResolver = "cloudflare";
    };
  };

}
