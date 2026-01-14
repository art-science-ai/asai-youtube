{ config, ... }:
{
  # Set the OCI containers backend
  virtualisation.oci-containers.backend = "podman";

  # Create directories for Open WebUI data
  systemd.tmpfiles.rules = [
    "d /var/lib/open-webui 0755 1000 1000 -"
    "d /var/lib/open-webui/data 0755 1000 1000 -"
  ];

  # Open WebUI container
  virtualisation.oci-containers.containers."open-webui" = {
    image = "ghcr.io/open-webui/open-webui:main"; # Assuming 'main' tag, adjust if a specific version is needed
    environment = {
      "WEBUI_NAME" = "Seasmoke Open WebUI";
      "WEBUI_SECRET_KEY" = "t0p-s3cr3t-k3yayyyy-test";
      "WEBUI_URL" = "https://openwebui.nikhilmaddirala.com";
      "WEBUI_USERNAME" = "admin";
      "WEBUI_PASSWORD" = "changeme";
    };
    ports = [ "127.0.0.1:${toString config.seasmoke.ports.openwebui}:8080" ]; # Host port 3001, container port 8080
    volumes = [
      "/var/lib/open-webui/data:/app/backend/data"
    ];
  };

  # Traefik configuration for Open WebUI
  services.traefik.dynamicConfigOptions.http = {
    services.open-webui.loadBalancer.servers = [
      { url = "http://localhost:${toString config.seasmoke.ports.openwebui}/"; } # Open WebUI listens on 8080 inside the container, mapped to host port 3001
    ];

    routers.open-webui = {
      rule = "Host(`openwebui.nikhilmaddirala.com`)"; # Adjust domain as needed
      tls.certResolver = "cloudflare";
      service = "open-webui";
      entrypoints = "websecure";
      middlewares = [ "default-headers" ];
    };
  };
}
