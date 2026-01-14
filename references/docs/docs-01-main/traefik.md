# Traefik Reverse Proxy Setup

Traefik reverse proxy with Cloudflare wildcard DNS and automatic SSL certificates for seasmoke.

## Architecture

- **Wildcard DNS**: `*.nikhilmaddirala.com` → Traefik via Cloudflare proxy
- **SSL Certificates**: Automatic Let's Encrypt via Cloudflare DNS challenge
- **Reverse Proxy**: Traefik routes subdomains to backend services
- **Security**: HTTP→HTTPS redirect, security headers, basic auth for dashboard

## Current Services

- ✅ `hello.nikhilmaddirala.com` → nginx test service (port 8080)
- 🚧 `hass.nikhilmaddirala.com` → Home Assistant (port 8123) - *deployment timeout, needs retry*
- ✅ `traefik.nikhilmaddirala.com` → Traefik dashboard (basic auth: admin/password)

## Adding New Services

### 1. Configure Backend Service
```nix
services.myapp = {
  enable = true;
  port = 3000;
};
```

### 2. Add Traefik Route
```nix
services.traefik.dynamicConfigOptions.http = {
  services.myapp.loadBalancer.servers = [
    { url = "http://127.0.0.1:3000"; }
  ];
  
  routers.myapp = {
    rule = "Host(`myapp.nikhilmaddirala.com`)";
    service = "myapp";
    middlewares = ["default-headers"];
    entrypoints = ["websecure"];
    tls.certResolver = "cloudflare";
  };
};
```

### 3. Deploy
```bash
nix run github:serokell/deploy-rs .#seasmoke
```

The new subdomain automatically gets:
- DNS resolution (via wildcard)
- SSL certificate (via DNS challenge)
- Security headers
- HTTPS redirect

## Files

- `hosts/seasmoke/traefik.nix` - Main Traefik configuration
- `hosts/seasmoke/test-web.nix` - Example nginx backend service
- `hosts/seasmoke/cloudflare.nix` - DNS management (includes wildcard)

## Benefits

- **Zero DNS management**: New subdomains work instantly
- **Automatic SSL**: Certificates generated and renewed automatically  
- **Secure by default**: HTTPS everywhere with proper headers
- **Easy scaling**: Add services with just Nix configuration

## Known Issues

### Large Service Deployments
Services with many dependencies (like Home Assistant) may timeout during initial deployment due to the large build process. Solutions:
- Retry deployment with `nix run github:serokell/deploy-rs .#seasmoke`
- Build locally first: `nix build .#nixosConfigurations.seasmoke.config.system.build.toplevel`
- Use binary cache if available