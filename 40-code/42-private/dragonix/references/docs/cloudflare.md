# Cloudflare DNS Management for Seasmoke

Declarative Cloudflare DNS management that automatically keeps DNS records in sync with your seasmoke server through deploy-rs.

## Setup

### 1. Create Cloudflare API Token

1. Go to [Cloudflare API Tokens](https://dash.cloudflare.com/profile/api-tokens)
2. Create Custom token with:
   - **Permissions**: Zone:DNS:Edit + Zone:Zone:Read
   - **Zone Resources**: Your domain (e.g., `example.com`)

### 2. Add Token to Secrets

```bash
sops hosts/seasmoke/secrets.yaml
```

Add:
```yaml
cloudflare:
  api_token: "your_api_token_here"
```

### 3. Deploy

```bash
nix run github:serokell/deploy-rs .#seasmoke
```

## Configuration Example

```nix
services.cloudflare-dyndns = {
  enable = true;
  apiTokenFile = config.sops.secrets."cloudflare/api_token".path;
  domains = [ "seasmoke.example.com" ];
  ipv4 = true;
  ipv6 = false;
  proxied = true;  # Enable Cloudflare proxy/CDN
};
```

## Usage

**Automatic**: DNS records update automatically on deployments and system boots

**Manual**:
```bash
# Check status
ssh seasmoke systemctl status cloudflare-dyndns

# View logs  
ssh seasmoke journalctl -u cloudflare-dyndns -n 20
```

## Troubleshooting

- **Not updating**: Check API token permissions and service logs
- **Service failing**: Verify sops secrets are decrypted properly
- **Rate limits**: Reduce update frequency in configuration