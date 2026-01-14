# Centralized port allocation for seasmoke host
# This file defines all host ports to prevent conflicts and provide a single source of truth
{ config, lib, ... }:

{
  options = {
    seasmoke.ports = lib.mkOption {
      type = lib.types.attrsOf lib.types.anything;
      description = "Port mappings for seasmoke services";
      readOnly = true;
    };
  };

  config = {
    seasmoke.ports = {
      # Infrastructure
      traefik = {
        http = 80;
        https = 443;
      };

      # Web services
      homepage = 3000;

      # AI/ML services
      ollama = 11434;
      ollama-ui = 3002;
      openwebui = 3001;
      librechat = 3080;

      # Automation
      n8n = 5678;
      homeassistant = 8123;

      # Knowledge management
      obsidian = {
        web = 8080;
        https = 8443;
      };
      obsidian-livesync = 5984;

      # System monitoring
      cockpit = 9090;
      netdata = 19999;
      glances = 61208;
    };
  };
}
