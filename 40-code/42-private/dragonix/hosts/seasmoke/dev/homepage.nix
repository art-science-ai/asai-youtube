# Homepage Dashboard service for seasmoke
{ config, pkgs, ... }:
{

  # Homepage Dashboard service
  services.homepage-dashboard = {
    enable = true;
    listenPort = config.seasmoke.ports.homepage;

    # Allow external access via Traefik
    allowedHosts = "homepage.nikhilmaddirala.com";

    # Homepage settings
    settings = {
      title = "Seasmoke Dashboard";
      theme = "dark";
      color = "slate";

      # Layout configuration
      layout = {
        "Services" = {
          style = "row";
          columns = 3;
        };
        "Information" = {
          style = "row";
          columns = 2;
        };
      };

      # Header links
      headerStyle = "boxed";
      hideVersion = true;
    };

    # Bookmarks configuration
    bookmarks = [
      {
        "Development" = [
          {
            name = "GitHub";
            abbr = "GH";
            href = "https://github.com";
          }
          {
            name = "NixOS Search";
            abbr = "NIX";
            href = "https://search.nixos.org";
          }
        ];
      }
      {
        "Documentation" = [
          {
            name = "Traefik Docs";
            abbr = "TF";
            href = "https://doc.traefik.io/traefik/";
          }
          {
            name = "Homepage Docs";
            abbr = "HP";
            href = "https://gethomepage.dev";
          }
        ];
      }
    ];

    # Widgets configuration
    widgets = [
      {
        "resources" = {
          cpu = true;
          memory = true;
          disk = "/";
        };
      }
      {
        "datetime" = {
          text_size = "xl";
          format = {
            dateStyle = "long";
            timeStyle = "short";
            hour12 = false;
          };
        };
      }
    ];

    # Services configuration
    services = [
      {
        "Infrastructure" = [
          {
            name = "Traefik";
            icon = "traefik";
            href = "https://traefik.nikhilmaddirala.com";
            description = "Reverse Proxy & Load Balancer";
            widget = {
              type = "traefik";
              url = "https://traefik.nikhilmaddirala.com";
            };
          }
        ];
      }
      {
        "Home Automation" = [
          {
            name = "Home Assistant";
            icon = "home-assistant";
            href = "https://hass.nikhilmaddirala.com";
            description = "Home Automation Platform";
            widget = {
              type = "homeassistant";
              url = "https://hass.nikhilmaddirala.com";
            };
          }
        ];
      }
      {
        "AI Services" = [
          {
            name = "Open WebUI";
            icon = "ollama";
            href = "https://openwebui.nikhilmaddirala.com";
            description = "Ollama Web Interface";
          }
          {
            name = "LibreChat";
            icon = "chatgpt";
            href = "https://librechat.nikhilmaddirala.com";
            description = "Multi-Provider AI Chat";
          }
        ];
      }
      {
        "Testing" = [
          {
            name = "Hello Web";
            icon = "nginx";
            href = "https://hello.nikhilmaddirala.com";
            description = "Test Web Service";
          }
        ];
      }
    ];
  };

  # Traefik configuration for Homepage
  services.traefik.dynamicConfigOptions.http.services.homepage = {
    loadBalancer = {
      servers = [
        { url = "http://127.0.0.1:${toString config.seasmoke.ports.homepage}"; }
      ];
    };
  };

  services.traefik.dynamicConfigOptions.http.routers.homepage = {
    rule = "Host(`homepage.nikhilmaddirala.com`)";
    service = "homepage";
    middlewares = [ "default-headers" ];
    entrypoints = [ "websecure" ];
    tls = {
      certResolver = "cloudflare";
    };
  };
}
