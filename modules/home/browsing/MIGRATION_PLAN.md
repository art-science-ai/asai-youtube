# Browser → Browsing Migration Plan

## Overview
Rename `browser` module to `browsing` and add web apps support (Linux-only).

## Target Structure
```
modules/home/browsing/
├── default.nix          # Main imports
├── browsers/            # Browser configs (Zen/Firefox, Linux-only)
│   ├── default.nix
│   └── zen-firefox.nix
├── finicky/             # macOS URL routing
├── surfingkeys/         # Browser keyboard navigation
└── web-apps/            # NEW: Web apps (Linux-only)
    ├── default.nix      # Conditional import (Linux only)
    └── web-apps.nix     # WhatsApp, Gmail SSBs
```

## Key Decisions

### Chromium
- **Keep at system level** (`nixos-desktop/base.nix`) - benefits all system users
- Web apps use system Chromium with `--app=<url>` flag
- No home-manager integration needed

### Web Apps (Linux-only)
- Runtime: System Chromium SSB mode
- Initial apps: WhatsApp Web, Gmail
- Profiles: `~/.local/share/ssb/<app-name>/` for isolation
- Icons: SVG files stored in repo at `web-apps/icons/`, installed via home.file

## Implementation Steps

### 1. Create Structure
```bash
# Create new module
mkdir -p modules/home/browsing/web-apps
cp -r modules/home/browser/* modules/home/browsing/

# Create web-apps files
touch modules/home/browsing/web-apps/{default.nix,web-apps.nix}
```

### 2. Update Files

**`browsing/default.nix`**:
```nix
{ config, lib, ... }:
{
  imports = [
    ./finicky
    ./surfingkeys
    ./browsers
    ./web-apps
  ];
}
```

**`browsing/web-apps/default.nix`**:
```nix
{ config, lib, pkgs, system, ... }:
let isLinux = !lib.hasSuffix "-darwin" system;
in {
  imports = if isLinux then [ ./web-apps.nix ] else [ ];
}
```

**`browsing/web-apps/web-apps.nix`**:
```nix
{ config, lib, pkgs, ... }:
let
  ssbDir = "${config.home.homeDirectory}/.local/share/ssb";
  iconsDir = ./icons;
in {
  # Install app icons
  home.file = {
    ".local/share/icons/whatsapp-web.svg".source = "${iconsDir}/whatsapp-web.svg";
    ".local/share/icons/gmail-web.svg".source = "${iconsDir}/gmail-web.svg";
  };

  xdg.desktopEntries = {
    whatsapp-web = {
      name = "WhatsApp";
      exec = "${pkgs.chromium}/bin/chromium --app=https://web.whatsapp.com --user-data-dir=${ssbDir}/whatsapp --class=WhatsAppWeb";
      icon = "whatsapp-web";
      categories = ["Network" "WebApplication"];
      startupWMClass = "WhatsAppWeb";
    };
    gmail = {
      name = "Gmail";
      exec = "${pkgs.chromium}/bin/chromium --app=https://mail.google.com --user-data-dir=${ssbDir}/gmail --class=GmailWeb";
      icon = "gmail-web";
      categories = ["Network" "WebApplication"];
      startupWMClass = "GmailWeb";
    };
  };
}
```

### 3. Update Imports (7 files)
Update `../modules/home/browser` → `../modules/home/browsing`:
- `home/aegon-seasmoke.nix`
- `home/nikhilmaddirala-{meleys,moondancer,seasmoke,vermax}.nix`
- `home/tyrion-seasmoke.nix`
- `modules/home/window-managers/gnome/gnome.nix`

### 4. Cleanup
```bash
rm -rf modules/home/browser/
```

### 5. Test
```bash
# Verify each home config builds
nix build .#homeConfigurations.<host>.activationPackage
```

## Benefits
- Semantic naming: "browsing" = browsers + web apps
- Clean separation: browsers vs web apps
- Extensible: Easy to add more SSB apps
- Consistent: Follows existing Linux-only patterns
