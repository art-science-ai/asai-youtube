# LibreChat service for seasmoke
# TODO: not working
{ config, pkgs, ... }:

{
  # Create directories for LibreChat data
  systemd.tmpfiles.rules = [
    "d /var/lib/librechat 0755 1000 1000 -"
    "d /var/lib/librechat/data 0755 1000 1000 -"
    "d /var/lib/librechat/logs 0755 1000 1000 -"
  ];

  # LibreChat systemd service
  systemd.services.librechat = {
    description = "LibreChat AI Chat Interface";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "simple";
      User = "librechat";
      Group = "librechat";
      WorkingDirectory = "/var/lib/librechat";
      ExecStart = "${pkgs.librechat}/bin/librechat";
      Restart = "always";
      RestartSec = 10;

      # Environment variables
      EnvironmentFile = "/var/lib/librechat/.env";

      # Security settings
      NoNewPrivileges = true;
      PrivateTmp = true;
      ProtectSystem = "strict";
      ProtectHome = true;
      ReadWritePaths = "/var/lib/librechat";
    };

    environment = {
      NODE_ENV = "production";
      HOST = "127.0.0.1";
      PORT = toString config.seasmoke.ports.librechat;
      DOMAIN_CLIENT = "http://127.0.0.1:${toString config.seasmoke.ports.librechat}";
      DOMAIN_SERVER = "http://127.0.0.1:${toString config.seasmoke.ports.librechat}";
      MONGO_URI = "mongodb://127.0.0.1:27017/LibreChat";
      NO_INDEX = "true";
      TRUST_PROXY = "1";
    };
  };

  # Create librechat user
  users.users.librechat = {
    isSystemUser = true;
    group = "librechat";
    home = "/var/lib/librechat";
    createHome = true;
  };

  users.groups.librechat = { };

  # MongoDB service (required by LibreChat)
  services.mongodb = {
    enable = true;
    bind_ip = "127.0.0.1";
    dbpath = "/var/lib/mongodb";
    extraConfig = ''
      net.port: 27017
    '';
  };

  # Create LibreChat environment file
  environment.etc."librechat.env" = {
    text = ''
      # LibreChat Configuration
      HOST=127.0.0.1
      PORT=${toString config.seasmoke.ports.librechat}
      DOMAIN_CLIENT=https://librechat.nikhilmaddirala.com
      DOMAIN_SERVER=https://librechat.nikhilmaddirala.com
      MONGO_URI=mongodb://127.0.0.1:27017/LibreChat
      NO_INDEX=true
      TRUST_PROXY=1

      # Security
      JWT_SECRET=16f8c0ef4a5d391b26034086c628469d3f9f497f08163ab9b40137092f2909ef
      JWT_REFRESH_SECRET=eaa5191f2914e30b9387fd84e254e4ba6fc51b4654968a9b0803b456a54b8418

      # Authentication
      ALLOW_EMAIL_LOGIN=true
      ALLOW_REGISTRATION=true
      ALLOW_SOCIAL_LOGIN=false
      ALLOW_PASSWORD_RESET=false
      ALLOW_UNVERIFIED_EMAIL_LOGIN=true

      # Session settings
      SESSION_EXPIRY=900000
      REFRESH_TOKEN_EXPIRY=604800000

      # Moderation
      OPENAI_MODERATION=false
      BAN_VIOLATIONS=true
      BAN_DURATION=7200000
      BAN_INTERVAL=20

      # Rate limiting
      LOGIN_MAX=7
      LOGIN_WINDOW=5
      REGISTER_MAX=5
      REGISTER_WINDOW=60
      LIMIT_CONCURRENT_MESSAGES=true
      CONCURRENT_MESSAGE_MAX=2

      # UI Settings
      APP_TITLE=Seasmoke LibreChat
      HELP_AND_FAQ_URL=https://librechat.ai

      # Search (disabled for now)
      SEARCH=false

      # RAG (disabled for now)
      # RAG_OPENAI_BASEURL=
      # RAG_OPENAI_API_KEY=
      # EMBEDDINGS_PROVIDER=openai
      # EMBEDDINGS_MODEL=text-embedding-3-small
    '';
    target = "/var/lib/librechat/.env";
  };

  # Traefik configuration for LibreChat
  services.traefik.dynamicConfigOptions.http.services.librechat = {
    loadBalancer = {
      servers = [
        { url = "http://127.0.0.1:${toString config.seasmoke.ports.librechat}"; }
      ];
    };
  };

  services.traefik.dynamicConfigOptions.http.routers.librechat = {
    rule = "Host(`librechat.nikhilmaddirala.com`)";
    service = "librechat";
    middlewares = [ "default-headers" ];
    entrypoints = [ "websecure" ];
    tls = {
      certResolver = "cloudflare";
    };
  };
}
