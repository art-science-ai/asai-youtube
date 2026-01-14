{ config, ... }:
{
  # Enable Tailscale VPN for all desktop systems
  services.tailscale.enable = true;

  # Manual login bootstrap:
  #   sudo tailscale up
  # After this works, switch to declarative auth with sops and:
  #   services.tailscale.authKeyFile = config.sops.secrets."tailscale/auth-key".path;
  # (Create and encrypt the auth key in sops, then remove the manual step.)
}
