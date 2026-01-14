{
  lib,
  pkgs,
  ...
}:
let
  couchdbAdminUser = "admin";
  couchdbAdminPass = "admin";
  livesyncUser = "livesync";
  livesyncPass = "livesync";

  obsidianLiveSyncInit = pkgs.writeShellApplication {
    name = "obsidian-livesync-init";
    runtimeInputs = [ pkgs.curl pkgs.coreutils ];
    text = ''
      set -euo pipefail

      base_url="http://127.0.0.1:5984"
      auth="${couchdbAdminUser}:${couchdbAdminPass}"
      livesync_user="${livesyncUser}"
      livesync_pass="${livesyncPass}"

      ready=""
      for _ in $(seq 1 30); do
        if curl -fsS -u "$auth" "$base_url/" > /dev/null; then
          ready="yes"
          break
        fi
        sleep 2
      done

      if [ "$ready" != "yes" ]; then
        echo "CouchDB is not ready at $base_url" >&2
        exit 1
      fi

      for db in _users _replicator _global_changes obsidian; do
        curl -fsS -u "$auth" -X PUT "$base_url/$db" > /dev/null || true
      done

      curl -fsS -u "$auth" -X PUT "$base_url/_users/org.couchdb.user:$livesync_user" \
        -H "Content-Type: application/json" \
        -d "{\"name\":\"$livesync_user\",\"password\":\"$livesync_pass\",\"roles\":[],\"type\":\"user\"}" \
        > /dev/null || true

      curl -fsS -u "$auth" -X PUT "$base_url/obsidian/_security" \
        -H "Content-Type: application/json" \
        -d "{\"admins\":{\"names\":[],\"roles\":[]},\"members\":{\"names\":[\"$livesync_user\"],\"roles\":[]}}" \
        > /dev/null || true
    '';
  };
in
{
  services.couchdb = {
    enable = true;
    adminUser = couchdbAdminUser;
    adminPass = couchdbAdminPass;
    bindAddress = "0.0.0.0";
    port = 5984;
    extraConfig = {
      couchdb = {
        single_node = true;
        max_document_size = 50000000;
      };
      chttpd = {
        require_valid_user = true;
        enable_cors = true;
        max_http_request_size = 4294967296;
      };
      chttpd_auth = {
        require_valid_user = true;
      };
      httpd = {
        "WWW-Authenticate" = "Basic realm=\"couchdb\"";
        enable_cors = true;
      };
      cors = {
        enable_cors = true;
        origins = "app://obsidian.md,capacitor://localhost,http://localhost";
        credentials = true;
      };
    };
  };

  # Initialize CouchDB databases for LiveSync
  systemd.services.obsidian-livesync-init = {
    description = "Initialize CouchDB for Obsidian LiveSync";
    after = [ "couchdb.service" ];
    wants = [ "couchdb.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${obsidianLiveSyncInit}/bin/obsidian-livesync-init";
    };
  };

  # Allow LAN access to CouchDB
  networking.firewall.allowedTCPPorts = lib.mkAfter [ 5984 ];
}
