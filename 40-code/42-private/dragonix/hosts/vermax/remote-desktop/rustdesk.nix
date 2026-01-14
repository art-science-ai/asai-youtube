{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    myRemoteDesktop.rustdesk.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable RustDesk remote desktop client";
    };
  };

  config = lib.mkIf config.myRemoteDesktop.rustdesk.enable {
    environment.systemPackages = with pkgs; [
      rustdesk
    ];

    networking.firewall.trustedInterfaces = lib.mkAfter [ "tailscale0" ];
  };
}
