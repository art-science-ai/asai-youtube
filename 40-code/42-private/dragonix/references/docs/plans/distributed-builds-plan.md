# Plan: Declarative Distributed Builds

## Problem

When flake inputs update (e.g., `llm-agents`), packages may not be in upstream binary caches yet, forcing local builds. We want seasmoke to act as both a remote builder and binary cache for vermax.

## Current state

- Manual setup: root SSH key at `/root/.ssh/id_ed25519_nix_build`
- Ad-hoc usage via `--builders @/tmp/nix-builders.conf`
- Works but not declarative or persistent

## Options

### Option 0: Justfile commands (already implemented)

Ad-hoc commands in `justfile` for immediate use without NixOS config changes.

```bash
# Fetch from seasmoke's store (substituter only)
just nh-home-sub

# Build on seasmoke (remote builder only)
just nh-home-remote

# Both - check store first, build if needed (recommended)
just nh-home-seasmoke
```

**Pros**: Works now; no config changes needed; easy to switch between modes
**Cons**: Not persistent; must remember to use correct command; only for home-manager

### Option A: Remote builder only (simplest)

Seasmoke builds packages, results copied back to vermax. No caching benefit for repeat builds.

```nix
# modules/hosts/nix-settings/distributed-builds.nix
nix.buildMachines = [{
  hostName = "91.99.176.80";
  systems = [ "x86_64-linux" ];
  sshUser = "nikhilmaddirala";
  sshKey = "/root/.ssh/id_ed25519_nix_build";
  maxJobs = 8;
  speedFactor = 2;
}];
nix.distributedBuilds = true;
```

**Pros**: Simple, no additional services
**Cons**: Rebuilds same package each time if not in vermax's store

### Option B: Remote builder + SSH store substituter (recommended)

Seasmoke builds AND vermax checks seasmoke's store before building.

```nix
# Same as Option A, plus:
nix.settings.substituters = lib.mkAfter [ "ssh-ng://nikhilmaddirala@91.99.176.80" ];
nix.settings.builders-use-substitutes = true;
```

**Pros**: Packages built once on seasmoke are reused; no extra services
**Cons**: SSH overhead for store queries; requires trusted-users on seasmoke

### Option C: nix-serve binary cache (most scalable)

Run `nix-serve` on seasmoke as an HTTP binary cache.

```nix
# On seasmoke
services.nix-serve = {
  enable = true;
  port = 5000;
  secretKeyFile = "/var/lib/nix-serve/cache-priv-key.pem";
};

# On vermax
nix.settings.substituters = lib.mkAfter [ "http://seasmoke:5000" ];
nix.settings.trusted-public-keys = lib.mkAfter [ "seasmoke:..." ];
```

**Pros**: Fast HTTP queries; can serve multiple clients; proper signing
**Cons**: Additional service to manage; key generation required

### Option D: GitHub Actions + Cachix (automated daily builds)

GitHub Actions runs `nix flake update` daily, builds all configurations, and pushes to Cachix. Local machines pull from cache.

```yaml
# .github/workflows/nix-build.yml
name: Nix Build and Cache
on:
  schedule:
    - cron: '0 4 * * *'  # Daily at 4am UTC
  workflow_dispatch:
  push:
    branches: [main]
    paths: ['flake.lock']

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: DeterminateSystems/nix-installer-action@main
      - uses: DeterminateSystems/magic-nix-cache-action@main
      - uses: cachix/cachix-action@v15
        with:
          name: dragonix
          authToken: '${{ secrets.CACHIX_AUTH_TOKEN }}'

      - name: Update flake inputs
        run: nix flake update

      - name: Build all configurations
        run: |
          nix build .#checks.x86_64-linux.vermax-config --no-link
          nix build .#checks.x86_64-linux.home-vermax --no-link
          nix build .#checks.x86_64-linux.seasmoke-config --no-link
          nix build .#checks.x86_64-linux.home-seasmoke --no-link

      - name: Commit updated flake.lock
        if: github.event_name == 'schedule'
        run: |
          git config user.name "github-actions[bot]"
          git config user.email "github-actions[bot]@users.noreply.github.com"
          git add flake.lock
          git diff --staged --quiet || git commit -m "chore: daily flake update"
          git push
```

```nix
# Add to nix.settings.substituters
nix.settings.substituters = lib.mkAfter [ "https://dragonix.cachix.org" ];
nix.settings.trusted-public-keys = lib.mkAfter [
  "dragonix.cachix.org-1:XXXX..."
];
```

**Pros**:
- Fully automated - builds happen before you need them
- Free CI minutes (GitHub Actions)
- Cachix provides fast global CDN
- Updates tested in CI before local apply
- No local/seasmoke resources used for builds

**Cons**:
- Cachix free tier has limits (5GB storage)
- ~30 min delay between push and cache availability
- Requires GitHub repo (dragonix is private, needs paid GitHub or self-hosted runner)
- macOS builds need paid GitHub runners or self-hosted

### Option E: Self-hosted GitHub runner on seasmoke (best of both)

Run a self-hosted GitHub Actions runner on seasmoke. Gets CI automation benefits while using own hardware.

```nix
# On seasmoke - add GitHub runner service
services.github-runners.dragonix = {
  enable = true;
  url = "https://github.com/nikhilmaddirala/dragonix";
  tokenFile = config.sops.secrets.github-runner-token.path;
  extraLabels = [ "nix" "x86_64-linux" ];
  extraPackages = with pkgs; [ cachix ];
};
```

```yaml
# .github/workflows/nix-build.yml
jobs:
  build:
    runs-on: [self-hosted, nix]  # Uses seasmoke
    # ... same steps as Option D
```

**Pros**:
- Free unlimited builds on own hardware
- Automatic daily updates with CI validation
- Cachix or local nix-serve for distribution
- Works with private repos
- seasmoke's store acts as local cache too

**Cons**:
- Runner setup and maintenance
- seasmoke must be online for CI

## Recommendation

**Immediate**: Option 0 - use `just nh-home-seasmoke` now. Already working.

**Short-term**: Option B - make it declarative via `distributed-builds.nix`. No extra services, leverages existing SSH infrastructure.

**Long-term**: Option E - self-hosted runner on seasmoke provides automated daily updates, CI validation, and cache population. Best for "always have cached builds ready" workflow.

## Implementation

### Files to create

**`modules/hosts/nix-settings/distributed-builds.nix`**:
```nix
{ config, lib, ... }:

let
  hostname = config.networking.hostName;
  isSeasmoke = hostname == "seasmoke";
  isVermax = hostname == "vermax";
in
{
  config = lib.mkMerge [
    (lib.mkIf isSeasmoke {
      nix.settings.trusted-users = [ "nikhilmaddirala" ];
    })

    (lib.mkIf isVermax {
      nix.buildMachines = [{
        hostName = "91.99.176.80";
        systems = [ "x86_64-linux" ];
        protocol = "ssh-ng";
        maxJobs = 8;
        speedFactor = 2;
        supportedFeatures = [ "big-parallel" "kvm" ];
        sshUser = "nikhilmaddirala";
        sshKey = "/root/.ssh/id_ed25519_nix_build";
      }];

      nix.distributedBuilds = true;
      nix.settings.builders-use-substitutes = true;
      nix.settings.substituters = lib.mkAfter [
        "ssh-ng://nikhilmaddirala@91.99.176.80"
      ];
    })
  ];
}
```

### Files to modify

**`modules/hosts/nix-settings/default.nix`** - add import:
```nix
imports = [
  ./common.nix
  ./distributed-builds.nix  # Add this
  # ... platform-specific
];
```

### Manual prerequisite

Ensure root SSH key exists (already done):
```bash
sudo ls /root/.ssh/id_ed25519_nix_build  # Should exist
```

## Testing

After applying:
```bash
# Should use seasmoke for builds
nix build --max-jobs 0 nixpkgs#hello

# Check build machine status
nix show-config | grep builders
```
