{ config, lib, ... }:
{
  # Enable Tailscale VPN for server systems
  services.tailscale = {
    enable = true;
    # Enable SSH access through Tailscale
    extraSetFlags = [ "--ssh" ];
  };

  # Allow Tailnet access to services on this server via tailscale0
  # This enables SSH and other services to be accessible from the Tailnet
  networking.firewall.trustedInterfaces = [ "tailscale0" ];

  # Enable systemd-resolved for proper DNS management with Tailscale
  # This allows Tailscale MagicDNS to coexist with fallback nameservers
  # See: https://tailscale.com/kb/1235/resolv-conf
  services.resolved = {
    enable = true;
    # Fallback DNS servers when Tailscale MagicDNS fails
    fallbackDns = [ "8.8.8.8" "8.8.4.4" "1.1.1.1" ];
  };

  # Manual login bootstrap:
  #   sudo tailscale up
  # After this works, switch to declarative auth with sops and:
  #   services.tailscale.authKeyFile = config.sops.secrets."tailscale/auth-key".path;
  # (Create and encrypt the auth key in sops, then remove the manual step.)
}
