# Glances real-time system monitoring web UI for seasmoke
# Accessible via Tailscale: http://seasmoke:61208
{ config, ... }:

{
  services.glances = {
    enable = true;
    port = config.seasmoke.ports.glances;
    extraArgs = [
      "--bind" "0.0.0.0"
      "--webserver"
    ];
  };
}
