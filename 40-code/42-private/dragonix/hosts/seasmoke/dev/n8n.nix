{ config, ... }:
{
  # Set the OCI containers backend
  virtualisation.oci-containers.backend = "podman";

  # n8n container
  virtualisation.oci-containers.containers."n8n" = {
    image = "docker.n8n.io/n8nio/n8n";
    environment = {
      "N8N_BASIC_AUTH_USER" = "n8nuser"; # Placeholder, replace with actual user
      "N8N_BASIC_AUTH_PASSWORD" = "n8npassword"; # Placeholder, replace with actual password
      "N8N_HOST" = "n8n.nikhilmaddirala.com";
      "N8N_PORT" = "5678";
      "WEBHOOK_URL" = "https://n8n.nikhilmaddirala.com/";
    };
    ports = [ "127.0.0.1:${toString config.seasmoke.ports.n8n}:5678" ];
    volumes = [ "n8n_data:/home/node/.n8n" ];
    # extraOptions = ["--add-host=postgres:10.89.0.1" "--ip=10.89.0.14" "--network=web"]; # Not including these for now, as they are specific to m3tam3re's setup
  };

  # Traefik configuration for n8n
  services.traefik.dynamicConfigOptions.http = {
    services.n8n.loadBalancer.servers = [
      { url = "http://localhost:${toString config.seasmoke.ports.n8n}/"; }
    ];

    routers.n8n = {
      rule = "Host(`n8n.nikhilmaddirala.com`)"; # Adjust domain as needed
      tls.certResolver = "cloudflare";
      service = "n8n";
      entrypoints = "websecure";
      middlewares = [ "default-headers" ];
    };
  };
}
