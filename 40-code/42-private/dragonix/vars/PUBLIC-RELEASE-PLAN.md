# Public release plan

Generated: 2025-01-20
Last updated: 2025-01-20

This document outlines the plan for making dragonix public while keeping it as a daily-driver NixOS configuration.

## Executive summary

| Severity | Count | Status |
|----------|-------|--------|
| Critical | 3 | Fixed |
| High | 2 | Pending (Google OAuth, htpasswd hashes) |
| Medium | 4 | Pending (Service credentials) |

## Approach

- Keep: SOPS encrypted files, personal info (domain, IPs, email, username)
- Fix: Move hardcoded secrets into SOPS encryption
- Post-publish: Rotate Google OAuth credentials

### Why this is safe

SOPS-encrypted secrets (vars/secrets.yaml) are safe to publish - only you (with the Age keys derived from your SSH keys) can decrypt them. The issue is hardcoded secrets that bypassed SOPS.

---

## Fixed issues

### 1. Z.AI API token in zclaude.nix (fixed)

- File: `modules/home/ai/misc/zclaude.nix`
- Status: Fixed
- Solution: Now reads from `$ZAI_API_KEY` environment variable (loaded via sops shell integration)

```nix
export ANTHROPIC_AUTH_TOKEN="$ZAI_API_KEY"
```

### 2. OpenRouter API key in config.json (fixed)

- File: `modules/home/ai/claude-code-router/config.template.json`
- Status: Fixed
- Solution: Uses `$OPENROUTER_API_KEY` placeholder, substituted at runtime via `envsubst`

### 3. Z.AI API key in config.json (fixed)

- File: `modules/home/ai/claude-code-router/config.template.json`
- Status: Fixed
- Solution: Uses `$ZAI_API_KEY` placeholder, substituted at runtime via `envsubst`

---

## Pending issues

### 4. Google OAuth client secret in gemini-cli plugin (HIGH)

- Files:
  - `modules/home/ai/claude-code-router/plugins/dabstractor-gemini-cli.js`
  - `modules/home/ai/claude-code-router/dabstractor-ccr-config/plugins/dabstractor-gemini-cli.js`
- Line: ~497
- Type: OAuth client ID and secret
- Values exposed:
  - Client ID: `681255809395-oo8ft2oprdrnp9e3aqf6av3hmdib135j.apps.googleusercontent.com`
  - Client Secret: `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`
- Status: Pending
- Severity: CRITICAL - Must rotate after public release

Remediation options:
- Add `google-oauth-client-secret` to secrets-registry
- Modify plugin to read from environment variable
- Note: Some Google OAuth flows require embedded client secrets (investigate before changing)

### 5. HTTP Basic Auth passwords (HIGH)

Multiple services use the same weak htpasswd hash (`admin:password`):

| File | Line | Service |
|------|------|---------|
| `hosts/seasmoke/prod/traefik.nix` | 68 | Traefik dashboard |
| `hosts/seasmoke/dev/cockpit.nix` | 27 | Cockpit admin panel |
| `hosts/seasmoke/dev/netdata.nix` | 57 | Netdata monitoring |

- Type: htpasswd hash (APR1-MD5)
- Hash: `admin:$apr1$xEDvUe67$vUtDrC/2U22gHwyfq0TgX1`
- Plaintext: `admin:password` (extremely weak)
- Status: Pending

Remediation:
- Generate strong password: `openssl rand -base64 32`
- Create htpasswd hash: `htpasswd -nbB admin <password>`
- Add to sops as single secret, reference from all three files

### 6. CouchDB credentials - Obsidian LiveSync (MEDIUM)

- File: `hosts/vermax/obsidian/obsidian-livesync.nix`
- Lines: 7-10
- Type: CouchDB admin and app credentials
- Values:
  - Admin: `admin:admin`
  - App user: `livesync:livesync`
- Status: Pending

Remediation:
- Add `couchdb-admin-password` and `couchdb-livesync-password` to SOPS
- Update nix config to read from secret files

### 7. CouchDB password - Obsidian container (MEDIUM)

- File: `hosts/seasmoke/dev/obsidian.nix`
- Line: 44
- Type: CouchDB password
- Value: `password`
- Status: Pending

Remediation:
- Reference same SOPS secret as #6 or create separate one

### 8. n8n credentials (MEDIUM)

- File: `hosts/seasmoke/dev/n8n.nix`
- Line: 11
- Type: n8n authentication
- Values: `n8nuser:n8npassword`
- Status: Pending

Remediation:
- Add `n8n-password` to SOPS
- Update config to use environment variable from secret

### 9. Google Cloud Project ID (LOW)

- File: `modules/home/ai/claude-code-router/dabstractor-ccr-config/config.json`
- Line: 19
- Type: GCP Project ID
- Value: `gen-lang-client-0884090445`
- Status: Optional

Note: Project IDs are not strictly secret but can be used for enumeration. Consider moving to SOPS or keeping as-is (low risk).

---

## Secrets registry status

Current secrets in `modules/common/secrets-registry.nix`:

| Secret | Defined | Used correctly |
|--------|---------|----------------|
| github-token | Yes | Yes (shell env) |
| github-username | Yes | Yes (shell env) |
| github-email | Yes | Yes (shell env) |
| openai-api-key | Yes | Yes (shell env) |
| openrouter-api-key | Yes | Yes (envsubst in ccr) |
| todoist-api-token | Yes | Yes (shell env) |
| cloudflare-seasmoke | Yes | Yes (traefik LoadCredential) |
| zai-api-key | Yes | Yes (zclaude.nix, envsubst in ccr) |

---

## Implementation plan

### Phase 1: Add new secrets to SOPS

Add to `vars/secrets.yaml`:

```yaml
google:
  oauth_client_id: "681255809395-oo8ft2oprdrnp9e3aqf6av3hmdib135j.apps.googleusercontent.com"
  oauth_client_secret: "<new-rotated-secret>"

traefik:
  htpasswd: "admin:$apr1$<new-strong-hash>"

couchdb:
  admin_password: "<generate-strong-password>"
  livesync_password: "<generate-strong-password>"

n8n:
  password: "<generate-strong-password>"
```

### Phase 2: Update secrets-registry.nix

Add to `modules/common/secrets-registry.nix`:

```nix
google-oauth-client-id = {
  sopsPath = "google/oauth_client_id";
  filePath = "/run/secrets/google/oauth_client_id";
  envVar = "GOOGLE_OAUTH_CLIENT_ID";
  owner = "nikhilmaddirala";
  mode = "0400";
};

google-oauth-client-secret = {
  sopsPath = "google/oauth_client_secret";
  filePath = "/run/secrets/google/oauth_client_secret";
  envVar = "GOOGLE_OAUTH_CLIENT_SECRET";
  owner = "nikhilmaddirala";
  mode = "0400";
};

traefik-htpasswd = {
  sopsPath = "traefik/htpasswd";
  filePath = "/run/secrets/traefik/htpasswd";
  owner = "root";
  mode = "0400";
};

couchdb-admin-password = {
  sopsPath = "couchdb/admin_password";
  filePath = "/run/secrets/couchdb/admin_password";
  envVar = "COUCHDB_ADMIN_PASSWORD";
  owner = "nikhilmaddirala";
  mode = "0400";
};

couchdb-livesync-password = {
  sopsPath = "couchdb/livesync_password";
  filePath = "/run/secrets/couchdb/livesync_password";
  envVar = "COUCHDB_LIVESYNC_PASSWORD";
  owner = "nikhilmaddirala";
  mode = "0400";
};

n8n-password = {
  sopsPath = "n8n/password";
  filePath = "/run/secrets/n8n/password";
  envVar = "N8N_PASSWORD";
  owner = "nikhilmaddirala";
  mode = "0400";
};
```

### Phase 3: Update config files

Files to modify:

| File | Change |
|------|--------|
| `modules/home/ai/claude-code-router/plugins/dabstractor-gemini-cli.js` | Use env vars for OAuth |
| `modules/home/ai/claude-code-router/dabstractor-ccr-config/plugins/dabstractor-gemini-cli.js` | Same |
| `hosts/seasmoke/prod/traefik.nix` | Load htpasswd from SOPS secret file |
| `hosts/seasmoke/dev/cockpit.nix` | Load htpasswd from SOPS secret file |
| `hosts/seasmoke/dev/netdata.nix` | Load htpasswd from SOPS secret file |
| `hosts/vermax/obsidian/obsidian-livesync.nix` | Load passwords from SOPS |
| `hosts/seasmoke/dev/n8n.nix` | Load password from SOPS |
| `hosts/seasmoke/dev/obsidian.nix` | Load password from SOPS |

### Phase 4: Generate new credentials

```bash
# Generate strong passwords
openssl rand -base64 32  # For each service password

# Generate htpasswd hash (bcrypt)
htpasswd -nbB admin "$(openssl rand -base64 32)"
```

---

## Verification commands

After remediation, verify no plaintext secrets remain:

```bash
cd /home/nikhilmaddirala/repos/monorepo/40-code/42-private/dragonix

# Check for Google OAuth secrets
grep -r "GOCSPX-" .
grep -r "681255809395" .

# Check for htpasswd hashes in nix files
grep -r '\$apr1\$' . --include="*.nix"

# Check for weak password patterns
grep -riE "password.*[:=].*password" . --include="*.nix"
grep -riE "admin.*[:=].*admin" . --include="*.nix"

# General secret patterns (review output manually)
grep -riE "(password|secret)\s*=\s*\"[^$]" . --include="*.nix" | grep -v "sops\|secrets\."

# Verify all secrets load correctly
sudo ls -la /run/secrets/
```

---

## Post-publish checklist

After making the repository public:

- [ ] Rotate Google OAuth credentials in Google Cloud Console
  - Go to: APIs & Services > Credentials
  - Create new OAuth client secret
  - Update in SOPS secrets
  - Test gemini-cli still works
- [ ] Verify all services work with SOPS-based secrets
  - Traefik dashboard login
  - Cockpit login
  - Netdata login
  - Obsidian LiveSync
  - n8n
- [ ] Monitor for unauthorized access attempts (the old credentials will be in monorepo git history)

---

## References

- sops-nix documentation: https://github.com/Mic92/sops-nix
- Secrets registry: `modules/common/secrets-registry.nix`
- Sops configuration: `vars/.sops.yaml`
- Encrypted secrets: `vars/secrets.yaml`
- htpasswd generator: `htpasswd -nbB username password`

---

## Appendix A: Future secrets management approaches

Currently secrets are maintained in two places:
- SOPS for NixOS/nix configuration (system-level secrets)
- 1Password for UI usage (logging into web apps like n8n)

This appendix explores options for unifying secrets management.

### Option 1: 1Password as single source of truth (recommended)

Use the `op` CLI to fetch secrets at runtime instead of SOPS:

```nix
# Example: systemd service loading secret from 1Password
systemd.services.n8n = {
  serviceConfig = {
    ExecStartPre = "${pkgs._1password}/bin/op read 'op://Vault/n8n/password' > /run/secrets/n8n-password";
    # Or use environment injection
    EnvironmentFile = "/run/secrets/n8n.env";
  };
};
```

Pros:
- Single source of truth
- 1Password UI for management
- Secrets never in git (even encrypted)
- Easy sharing with family/team vaults

Cons:
- Requires network access during service start
- Requires 1Password CLI authentication (service account or biometric)
- Boot-time secrets need special handling

### Option 2: agenix + 1Password hybrid

Use agenix for system secrets, but generate them from 1Password:

```bash
# Script to sync 1Password → agenix secrets
op read "op://Infrastructure/n8n/password" | age -r "ssh-ed25519 AAAA..." > secrets/n8n-password.age
```

Pros:
- Secrets in git are encrypted (like SOPS)
- 1Password remains the "edit" interface
- Works offline after initial sync

Cons:
- Still two systems, but with clear sync direction
- Manual sync step (can be automated in a hook)

### Option 3: 1Password Connect (self-hosted)

Run 1Password Connect on your server (seasmoke) for API-based secret access:

```nix
# Fetch secrets via HTTP API at runtime
services.n8n.environment = {
  N8N_BASIC_AUTH_PASSWORD_FILE = "/run/secrets/n8n-password";
};

# Systemd unit fetches from 1Password Connect
systemd.services.n8n.serviceConfig.ExecStartPre = ''
  ${pkgs.curl}/bin/curl -H "Authorization: Bearer $OP_CONNECT_TOKEN" \
    "http://localhost:8080/v1/vaults/.../items/.../fields/password" \
    -o /run/secrets/n8n-password
'';
```

Pros:
- Server-side, no interactive auth needed
- 1Password as single source
- Works well for servers

Cons:
- Extra service to run
- Still need to bootstrap the connect token somehow

### Option 4: Keep both, but with clear workflow

Accept the duplication but make it manageable:

```
1Password (source of truth for credentials you type)
    ↓ copy when creating
SOPS secrets.yaml (source of truth for system injection)
```

Document which secrets are "typed" (1Password only) vs "injected" (SOPS):
- Typed: n8n login, traefik dashboard, web UIs
- Injected: API keys, tokens, service-to-service auth

Pros:
- Simple, works now
- Clear mental model
- No new infrastructure

Cons:
- Manual sync when passwords change
- Duplication

### Recommended hybrid approach

Given the current setup, consider:

```nix
# In secrets-registry.nix, categorize secrets by source:

# 1Password-sourced (services you log into via UI)
op-secrets = {
  n8n-password = "op://Infrastructure/n8n/password";
  traefik-dashboard = "op://Infrastructure/traefik/password";
  couchdb-admin = "op://Infrastructure/couchdb/admin-password";
};

# SOPS-sourced (API keys you never "log in" with)
sops-secrets = {
  github-token = "github/token";
  openai-api-key = "openai/api_key";
  cloudflare-token = "cloudflare/api_token_seasmoke";
};
```

Then create a systemd service or activation script that:
1. Authenticates to 1Password (via service account for servers)
2. Fetches `op-secrets` to `/run/secrets/`
3. Services read from there (same interface as SOPS)

This gives you:
- 1Password as single source for "login" credentials
- SOPS for API tokens (which you manage less frequently)
- Consistent `/run/secrets/` interface for all services
