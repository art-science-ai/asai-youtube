# Browsing Module

Comprehensive browser and web app configuration for declarative desktop environments.

## What This Module Does

**Installs and configures:**
- Zen Browser (Twilight variant) - primary browser
- Firefox - secondary/backup browser
- Default profiles for both browsers
- Zen set as system default browser (Linux only)
- Stylix theme integration
- Web apps: WhatsApp Web, Gmail (Linux only)

**Strategy:** Firefox Sync handles all browser data (bookmarks, passwords, history, settings, add-ons). This module handles OS-level integration and isolated web app instances.

## Module Structure

```
modules/home/browsing/
├── default.nix              # Main imports
├── README.md                # This file
├── browsers/                # Browser configs
│   ├── default.nix
│   └── zen-firefox.nix
├── finicky/                 # macOS URL routing
├── surfingkeys/             # Browser keyboard navigation
└── web-apps/                # Web app instances (Linux-only)
    ├── default.nix          # Conditional import
    ├── web-apps.nix         # Web app definitions
    └── icons/               # App icons (SVG)
        ├── gmail-web.svg
        └── whatsapp-web.svg
```

## Browser Configuration

### What's Installed

- **Zen Browser (Twilight)** - Primary browser with workspace features
- **Firefox** - Backup browser with full sync capabilities
- Default profile created for both
- Zen set as system default (Linux only)
- Stylix integration for theme consistency

### How It Works

Firefox Sync handles all user data across machines:
- Bookmarks, passwords, history
- Settings and preferences
- Browser extensions and add-ons

This module only manages:
- OS-level browser integration
- Desktop shortcuts and defaults
- Theme/styling via Stylix

### Related Configuration

- **1Password browser integration:** `modules/hosts/nixos-desktop/base.nix` (system level)
- **1Password SSH/Git:** `modules/home/auth/` (home-manager level)
- **Chromium:** `modules/hosts/nixos-desktop/base.nix` (system level, used for web apps)

## Zen Workspace Workflow

### Problem

Zen workspace sync doesn't reliably sync pinned tabs across machines.

### Solution

Use bookmarks as workspace manifests with a naming convention.

### Setup

Create bookmark folders manually in Zen (syncs via Firefox Sync):

```
Bookmarks Toolbar/Workspaces/
  W: Work/      (URLs for Work workspace)
  W: Personal/  (URLs for Personal workspace)
  W: Research/  (URLs for Research workspace)
```

### On New Machine

1. Sign in to Firefox Sync
2. For each workspace: Open bookmark folder → "Open All in Tabs" → Drag to Zen workspace → Pin
3. Optional: Use containers with naming convention like `[@work] Gmail`

### Updating Workspaces

Add/remove URLs from bookmark folders to keep workspace intent synced across machines.

## Web Apps (Linux Only)

Single Site Browser (SSB) instances for web applications, providing isolated browsing contexts with custom icons and desktop entries.

### Current Web Apps

- **WhatsApp Web** - WhatsApp messaging as a desktop app
- **Gmail** - Gmail as a desktop app

### How They Work

1. **Runtime:** System Chromium in app mode (`--app=<url>`)
2. **Isolation:** Each app has its own data directory (`~/.local/share/ssb/<app>/`)
3. **Integration:** Desktop entries for app launchers, custom icons, categorization
4. **Icons:** SVG files stored in repo and installed via home-manager

### Adding New Web Apps

Edit `modules/home/browsing/web-apps/web-apps.nix`:

```nix
myapp = {
  name = "My App";
  exec = "${pkgs.chromium}/bin/chromium --app=https://example.com --user-data-dir=${ssbDir}/myapp --app-id=myapp";
  icon = "myapp";
  categories = ["Network" "..."];
  settings = {
    StartupWMClass = "myapp";
  };
};
```

Then add the icon SVG to `web-apps/icons/myapp.svg` and add the home.file entry.

### Icon Management

Icons are stored as SVG files in the repo and installed to `~/.local/share/icons/` during home-manager activation. This ensures:
- Version control of icons
- Consistency across machines
- No external dependencies

---

## Appendix: SSB Link Handling

### Current Behavior & Issue

When you click external links in an SSB (e.g., a link in Gmail), it opens in Chromium instead of your default browser (Zen). This happens because:

- SSB instances run with isolated data directories (`--user-data-dir`)
- Chromium in isolated mode doesn't know about system browser defaults
- Each link triggers a new Chromium process with the same isolation

**User impact:** External links don't use your default browser preference.

### Proposed Alternatives

#### Option 1: Switch SSBs to Firefox (Recommended)

**Pros:**
- Firefox respects system browser defaults more naturally
- Built-in profile isolation system (cleaner than Chromium's approach)
- Consistency with Zen as default browser
- Better protocol handler delegation
- Lighter configuration needed

**Cons:**
- Slightly higher memory per SSB instance
- Different browser engine than main Chromium-based apps

**Implementation:** Create SSB launcher scripts using Firefox with `--profile` instead of Chromium with `--app`.

#### Option 2: Wrapper Script with Protocol Handlers

**Pros:**
- Keep Chromium for SSBs
- Use xdg-open delegation for external links
- Configurable per-app

**Cons:**
- More complex setup
- Requires wrapper script maintenance
- Still Chromium behavior for embedded navigation

**Implementation:** Create shell wrapper that configures Chromium preferences before launch, setting http/https handlers to use xdg-open.

#### Option 3: Accept Current Behavior

**Pros:**
- No code changes needed
- Everything stays in Chromium ecosystem

**Cons:**
- Links open in "wrong" browser
- Requires user to manually copy-paste links if they want Zen
- Less integrated feeling

### Recommendation

**Option 1 (Firefox-based SSBs)** is recommended because:
- Cleanest integration with system defaults
- Leverages existing Firefox Sync infrastructure
- Consistent with your primary browser (Zen)
- Simpler to maintain long-term
- No wrapper script complexity

To switch: Update `web-apps.nix` to use `pkgs.firefox` with `--ProfileManager` and profile path instead of Chromium with `--app`.
