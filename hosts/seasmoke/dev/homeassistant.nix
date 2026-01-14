# Home Assistant service for seasmoke
{ config, pkgs, ... }:

{

  # Home Assistant service
  services.home-assistant = {
    enable = true;

    # Basic configuration
    config = {
      # Includes dependencies for a basic setup
      default_config = { };

      extraComponents = [
        "default_config"

        # Your lights
        "tplink" # TP-Link Kasa

        # Voice stack you wanted to try
        "conversation"
        "assist_pipeline"
        "openai_conversation"
        "wyoming" # protocol used by local STT/TTS/wakeword services
        "whisper" # STT integration
        "piper" # TTS integration

        # (Optional) other handy built-ins
        "google_translate" # TTS option
        "mobile_app"
        "backup"
      ];

      # HTTP configuration
      http = {
        use_x_forwarded_for = true;
        server_host = "127.0.0.1";
        server_port = config.seasmoke.ports.homeassistant;
        trusted_proxies = "127.0.0.1";
      };

      # Home Assistant instance settings
      homeassistant = {
        name = "Seasmoke Home";
        latitude = "40.7128"; # New York City coordinates as demo
        longitude = "-74.0060";
        elevation = "10";
        unit_system = "metric";
        time_zone = "America/New_York";
        external_url = "https://hass.nikhilmaddirala.com";
        internal_url = "https://hass.nikhilmaddirala.com";
      };

      # Frontend configuration
      frontend = {
        themes = "!include_dir_merge_named themes";
      };

      # Logging
      logger.default = "info";

      # Automation files
      "automation ui" = "!include automations.yaml";
      "scene ui" = "!include scenes.yaml";
      "script ui" = "!include scripts.yaml";

    };

    # Configuration directory
    configDir = "/var/lib/hass";

    # Make configuration writable for web interface
    configWritable = true;
  };

  # Create necessary directories and files
  systemd.tmpfiles.rules = [
    "f ${config.services.home-assistant.configDir}/automations.yaml 0755 hass hass"
    "f ${config.services.home-assistant.configDir}/scenes.yaml      0755 hass hass"
    "f ${config.services.home-assistant.configDir}/scripts.yaml     0755 hass hass"
    "d /var/lib/hass/backups 0750 hass hass"
  ];

  # Traefik configuration for Home Assistant
  services.traefik.dynamicConfigOptions.http.services.homeassistant = {
    loadBalancer = {
      servers = [
        { url = "http://127.0.0.1:${toString config.seasmoke.ports.homeassistant}"; }
      ];
    };
  };

  # WebSocket support through main router with headers middleware
  services.traefik.dynamicConfigOptions.http.middlewares.homeassistant-headers = {
    headers = {
      customRequestHeaders.X-Forwarded-Proto = "https";
      customRequestHeaders.X-Forwarded-Host = "hass.nikhilmaddirala.com";
    };
  };

  # Main router with WebSocket header support
  services.traefik.dynamicConfigOptions.http.routers.homeassistant = {
    rule = "Host(`hass.nikhilmaddirala.com`)";
    service = "homeassistant";
    middlewares = [
      "default-headers"
      "homeassistant-headers"
    ];
    entrypoints = [ "websecure" ];
    tls = {
      certResolver = "cloudflare";
    };
  };

}
