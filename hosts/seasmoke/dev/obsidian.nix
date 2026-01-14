{ config, ... }:
{
  # Set the OCI containers backend
  virtualisation.oci-containers.backend = "podman";

  # Create directories for Obsidian data
  systemd.tmpfiles.rules = [
    "d /opt/obsidian 0755 1000 1000 -"
    "d /opt/obsidian/vaults 0755 1000 1000 -"
    "d /opt/obsidian/config 0755 1000 1000 -"
    "d /opt/obsidian/couchdb 0755 1000 1000 -"
    "d /opt/obsidian/couchdb/data 0755 1000 1000 -"
  ];
  # Obsidian web interface container
  # https://github.com/sytone/obsidian-remote
  virtualisation.oci-containers.containers."obsidian" = {
    image = "ghcr.io/sytone/obsidian-remote:latest";
    environment = {
      "PUID" = "1000";
      "PGID" = "1000";
      "TZ" = "America/Los_Angeles";
      "CUSTOM_PORT" = "8080";
      "CUSTOM_HTTPS_PORT" = "8443";
      # "CUSTOM_USER" = "obsidian";
      # "PASSWORD" = "obsidian123";
      "TITLE" = "Obsidian on Seasmoke";
    };
    ports = [
      "127.0.0.1:${toString config.seasmoke.ports.obsidian.web}:8080"
      "127.0.0.1:${toString config.seasmoke.ports.obsidian.https}:8443"
    ];
    volumes = [
      "/opt/obsidian/vaults:/vaults"
      "/opt/obsidian/config:/config"
    ];
  };

  # LiveSync backend container (CouchDB)
  # https://github.com/vrtmrz/obsidian-livesync/blob/main/docker-compose.traefik.yml
  virtualisation.oci-containers.containers."obsidian-livesync" = {
    image = "couchdb:latest";
    user = "1000:1000";
    environment = {
      "COUCHDB_PASSWORD" = "password";
      "COUCHDB_USER" = "admin";
    };
    ports = [ "127.0.0.1:${toString config.seasmoke.ports.obsidian-livesync}:5984" ];
    volumes = [
      "/opt/obsidian/couchdb/data:/opt/couchdb/data"
    ];
  };

  # Traefik configuration
  services.traefik.dynamicConfigOptions.http = {
    middlewares.obsidiancors = {
      headers = {
        accessControlAllowMethods = "GET,PUT,POST,HEAD,DELETE";
        accessControlAllowHeaders = "accept,authorization,content-type,origin,referer";
        accessControlAllowOriginList = "app://obsidian.md,capacitor://localhost,http://localhost";
      };
    };

    services = {
      obsidian.loadBalancer.servers = [
        # No need to use 8443 https port because Traefik handles SSL
        { url = "http://localhost:${toString config.seasmoke.ports.obsidian.web}/"; }
      ];
      obsidian-livesync.loadBalancer.servers = [
        { url = "http://localhost:${toString config.seasmoke.ports.obsidian-livesync}/"; }
      ];
    };

    routers = {
      obsidian = {
        rule = "Host(`obsidian.nikhilmaddirala.com`)";
        tls.certResolver = "cloudflare";
        service = "obsidian";
        entrypoints = "websecure";
        middlewares = [ "default-headers" ];
      };
      obsidian-livesync = {
        rule = "Host(`obsidian-livesync.nikhilmaddirala.com`)";
        tls.certResolver = "cloudflare";
        service = "obsidian-livesync";
        entrypoints = "websecure";
        middlewares = [ "obsidiancors" ];
      };
    };
  };
}
