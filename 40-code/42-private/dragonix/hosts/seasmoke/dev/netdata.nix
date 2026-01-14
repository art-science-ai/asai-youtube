# Netdata real-time performance monitoring for seasmoke
{ config, pkgs, ... }:

{

  # Netdata service configuration
  services.netdata = {
    enable = true;
    config = {
      global = {
        # Bind to localhost only, access through Traefik
        "bind to" = "127.0.0.1:${toString config.seasmoke.ports.netdata}";

        # Performance and resource settings
        "memory deduplication (ksm)" = "yes";
        "update every" = "1"; # Update frequency in seconds
        "history" = "86400"; # Keep 24 hours of history
      };

      # Web interface configuration
      web = {
        "web files owner" = "netdata";
        "web files group" = "netdata";
      };

      # Plugin configuration for comprehensive monitoring
      plugins = {
        # Enable plugins for system monitoring
        "enable running new plugins" = "yes";
        "check for new plugins every" = "60";

        # Containers monitoring
        "cgroups" = "yes";

        # System monitoring
        "proc" = "yes";
        "diskspace" = "yes";
        "tc" = "yes"; # Traffic control monitoring
      };
    };
  };

  # Traefik service definition for Netdata
  services.traefik.dynamicConfigOptions.http.services.netdata = {
    loadBalancer = {
      servers = [
        { url = "http://127.0.0.1:${toString config.seasmoke.ports.netdata}"; }
      ];
    };
  };

  # Middleware for Netdata with basic auth
  services.traefik.dynamicConfigOptions.http.middlewares.netdata-auth = {
    basicAuth = {
      users = [
        # Generated with: htpasswd -nb admin password
        "admin:$apr1$xEDvUe67$vUtDrC/2U22gHwyfq0TgX1" # admin:password
      ];
    };
  };

  # Traefik router for Netdata
  services.traefik.dynamicConfigOptions.http.routers.netdata = {
    rule = "Host(`netdata.nikhilmaddirala.com`)";
    service = "netdata";
    middlewares = [
      "netdata-auth"
      "default-headers"
    ];
    entrypoints = [ "websecure" ];
    tls = {
      certResolver = "cloudflare";
    };
  };

}
