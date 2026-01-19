# Keyboard Remapping Module

## Overview and Philosophy

This module implements a universal keyboard remapping system that works consistently across both macOS (MacBook US keyboard) and Linux (standard Windows keyboard). The design prioritizes muscle memory retention and ergonomic efficiency.

### Core Requirements

**Cross-Platform Consistency:**
- Universal keyboard behavior across macOS and Linux
- GUI key maps to Cmd on macOS, Win/Super on Linux
- Consistent hyper key bindings across platforms
- Seamless workflow when switching between operating systems

**Home Row Mods (CAGS Style):**
- Left hand: A=Ctrl, S=Alt, D=GUI, F=Shift
- Right hand: J=Shift, K=GUI, L=Alt, ;=Ctrl
- Reduce finger travel distance for common modifier combinations
- Maintain home row position during keyboard shortcuts

**Custom Hyper Keys:**
- Hyper1 (Caps Lock): Cmd+Ctrl+Alt (maps to `<Super><Ctrl><Alt>` in GNOME keybindings)
- Hyper2 (Right Meta): Cmd+Ctrl+Shift
- Hyper3 (Right Alt): Cmd+Alt+Shift
- Hyper4 (Right Ctrl): Ctrl+Alt+Shift
- Enable powerful window management and custom shortcuts

**Universal Clipboard Integration:**
- All applications write to system clipboard (no selection-only buffers)
- Neovim yanks go to clipboard
- Terminal selections go to clipboard
- GUI app standard copy-paste behavior
- Linux PRIMARY selection automatically syncs to CLIPBOARD
- Works in SSH sessions and terminal multiplexers (zellij/tmux)
- Remote clipboard accessible from local machine and vice versa

**Clipboard Management:**
- Clipboard history across all applications
- Quick access to previously copied items
- Persistent clipboard across sessions

### Implementation Mapping

| Requirement | Linux | macOS | Status |
|------------|-------|-------|--------|
| Home row mods (CAGS) + hyper keys | kanata | Karabiner | ⚠️ Linux ✅, macOS needs migration to kanata |
| Universal clipboard (incl. SSH/zellij) | Partial | Partial | ⚠️ Needs terminal and remote config |
| Clipboard manager | TBD | Built-in | ❌ Needs setup on Linux |

## Current Implementation Status

### ✅ Implemented: Home Row Mods and Hyper Keys (Linux)

**Current state:**
- Active kanata v1.9.0 service (v1.10 config ready)
- Configuration: `kanata.kbd`
- All CAGS home row mods functional
- All hyper keys (Caps Lock, Right Ctrl/Alt/Meta) remapped
- Service: `kanata.service` (enabled and running)

**To upgrade to kanata v1.10:**
1. Add kanata overlay to pin version to 1.10.0+ (nixpkgs is at 1.9.0)
2. Change config source in `kanata.nix` from `./kanata.kbd` to `./kanata-v1.10.kbd`
3. Restart service: `systemctl --user restart kanata.service`
4. Verify improved tap-hold behavior (reduced character transposition)

See Appendix A for technical details on tap-hold improvements.

### ⚠️ Action Needed: Migrate macOS from Karabiner to kanata

**Current state:**
- macOS uses Karabiner-Elements (`karabiner.json`)
- Same CAGS home row mods and hyper keys as Linux
- Works but inconsistent tooling across platforms

**Migration steps:**
1. Install kanata on macOS (via Homebrew or nix-darwin)
2. Port Karabiner configuration to kanata format
3. Create `kanata.nix` module for Darwin in this module
4. Test all home row mods and hyper keys
5. Disable Karabiner-Elements
6. Update `default.nix` to use kanata on both platforms

**Benefit:** Single configuration language and tooling across Linux and macOS.

### ⚠️ Action Needed: Universal Clipboard (Terminal and Remote)

**Current state:**
- Neovim: Uses system clipboard for yank/delete operations ✅
- GUI apps: Standard clipboard behavior works ✅
- Terminals: PRIMARY/CLIPBOARD not synced ❌
- SSH sessions: Clipboard not accessible ❌
- zellij/tmux: No clipboard integration ❌

**Implementation steps:**

**1. Terminal clipboard sync (Wayland):**
```bash
# Install wl-clipboard
nix shell nixpkgs#wl-clipboard

# Add to shell config to auto-sync PRIMARY to CLIPBOARD
# In ~/.zshrc or equivalent:
wl-paste --watch wl-copy --primary --clear
```

**2. zellij clipboard integration:**
```bash
# Add to zellij configuration (~/.config/zellij/config.kdl)
# Copy mode: yank to clipboard
# See: https://zellij.dev/documentation
```

**3. tmux clipboard integration (if used):**
```bash
# Add to ~/.tmux.conf
bind-key -T copy-mode-vi y send-keys -X copy-pipe "wl-copy"
bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe "wl-copy"
```

**4. SSH clipboard forwarding:**

Option A - OSC 52 escape sequences (modern terminals):
```bash
# Most terminals support this automatically
# Test by running in remote shell:
printf "\033]52;c;$(base64 <<< 'test')\a"
```

Option B - Clipboard forwarding tool:
```bash
# Install lemonade or rbounce for SSH clipboard sync
nix shell nixpkgs#lemonade

# On remote machine, add to ~/.ssh/authorized_keys:
command="lemonade server" ssh-rsa ...

# Usage in SSH sessions:
echo "text" | lemonade copy  # Copy to local clipboard
lemonade paste                # Paste from local clipboard
```

**5. Neovim remote clipboard (via OSC 52):**
```lua
# Add to Neovim config (works in SSH)
vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
  },
}
```

See Appendix B for comprehensive clipboard reference.

### ❌ Action Needed: Clipboard Manager

**Linux:**
No clipboard manager currently installed. Needed for clipboard history, persistence, and quick access.

**Implementation steps:**

Option A - GNOME Shell extension (recommended):
```bash
# Install clipboard-indicator GNOME Shell extension
# Available through GNOME Extensions app or:
# https://extensions.gnome.org/extension/779/clipboard-indicator/

# Features:
# - Clipboard history (configurable size)
# - Persistent across reboots
# - Keyboard shortcut access (default: Ctrl+Alt+H)
# - Privacy mode (disable for specific apps)
```

Option B - Standalone clipboard manager:
```bash
# Install copyq via nix
nix shell nixpkgs#copyq

# Autostart copyq (add to systemd user service or GNOME startup apps)
copyq --start-server

# Features:
# - Advanced clipboard history with search
# - Edit and organize clipboard items
# - Scriptable and customizable
# - Supports images, files, and formatted text
```

**macOS:**
Built-in clipboard history available (Cmd+Shift+V on Ventura 13.0+), no action needed unless enhanced features desired. Optional: Maccy (open-source) or Paste (commercial).

## Implementation Details

### Active Configuration: kanata (Linux)

**Service status:**
```bash
systemctl --user status kanata.service  # Running
```

**Key mappings:**
- Caps Lock → Esc (tap) / Hyper1 (hold)
- Right Ctrl → Hyper4 (Ctrl+Alt+Shift)
- Right Alt → Hyper3 (Cmd+Alt+Shift)
- Right Meta → Hyper2 (Cmd+Ctrl+Shift)
- Home row mods: A/S/D/F and J/K/L/;

**Version notes:**
- Current: v1.9.0 (nixpkgs)
- Improved config available: `kanata-v1.10.kbd` (uses tap-hold-tap-keys)
- Upgrade needed for enhanced tap-hold behavior (see Appendix A)

### Active Configuration: Karabiner (macOS)

**Configuration file:** `karabiner.json`

Mirrors kanata layout:
- Same hyper key positions
- Same CAGS home row mods
- Platform-specific GUI key mapping (Cmd vs Win)

### Configuration Files

- `default.nix` - Platform detection and module imports
- `kanata.nix` - kanata service and configuration (Linux)
- `kanata.kbd` - Current kanata remapping configuration
- `kanata-v1.10.kbd` - Enhanced kanata config (requires v1.10+)
- `karabiner.nix` - Karabiner configuration (macOS)
- `karabiner.json` - Karabiner key remapping rules
- `xremap.nix` - xremap module (disabled - see Appendix C)
- `xremap.yml` - xremap configuration (unused)

---

## Appendix A: Home Row Mods Technical Details

### Tap-Hold Behavior: tap-hold vs tap-hold-release

The kanata configuration uses `tap-hold` with a 200ms timeout. Understanding the difference between `tap-hold` and `tap-hold-release` is important for understanding how the homerow mods work.

#### What tap-hold-release does

With tap-hold-release, kanata waits until you release the key to decide: was this a tap or a hold (modifier)?

During fast typing, this can cause problems because you often press the next key before releasing the previous one. This overlap is ambiguous, and kanata retroactively decides "that must have been a modifier." This retroactive decision can:

- Turn letters into modifiers
- Reorder emitted key events
- Cause character transpositions (fast → fats)

This is especially noticeable with rolling bigrams like fa, as, st.

#### What plain tap-hold does

With tap-hold, the decision is made earlier: either after a timeout or based on early press patterns. Crucially, this happens before release-based ambiguity. The key emits a tap immediately in most typing scenarios, and later keys don't retroactively change what already happened.

#### Why 200ms timeout

Typing speed vs timeout is important:
- Fast typists press keys 80-120ms apart
- Average typists: 150-250ms between keys
- 300ms creates reordering issues (too long)
- 200ms is a good balance: fast enough to avoid most reordering while still allowing comfortable mod usage

#### Trade-offs

**Using tap-hold (current/recommended):**
- Pros: Eliminates reordering bugs, feels more like normal typing, fixes 80-90% of HRM weirdness
- Cons: Requires more deliberate holds for modifiers, timing sensitive

**Using tap-hold-release:**
- Pros: More forgiving for mod usage
- Cons: Can cause reordering during fast typing

The config uses `tap-hold` because it eliminates the retroactive decision-making that causes character transpositions. Once a character is typed, it should never change later - this restores that fundamental typing expectation.

If you want to try tap-hold-release for more forgiving mod usage, be aware that it may cause character reordering during fast typing.

### kanata v1.10 Enhancement

The `kanata-v1.10.kbd` configuration uses `tap-hold-tap-keys`, a newer feature that provides better tap-hold behavior than standard `tap-hold`. This requires kanata v1.10.0 or higher.

To upgrade:
1. Wait for nixpkgs to update to kanata v1.10.0+, or
2. Add a custom overlay to pin kanata to a newer version

Once upgraded, change the config source in `kanata.nix` from `./kanata.kbd` to `./kanata-v1.10.kbd`.

---

## Appendix B: Clipboard Management Reference

This section provides comprehensive reference information about clipboard management on Linux (Wayland) and macOS.

### Linux Clipboard Management (Wayland)

Wayland uses a simplified clipboard model compared to X11:

#### Clipboard Selections (Wayland)

Wayland uses three clipboard selections, similar to X11 but with improved security:

- **PRIMARY** - Selection-based clipboard (text selected with mouse)
  - Automatically populated when you select text
  - Paste with middle-click or Shift+Insert in terminal applications
  - Temporary - lost when selection is cleared
  - Use case: Quick copy-paste within same context

- **CLIPBOARD** - Explicit clipboard (Ctrl+C/Ctrl+V)
  - Only populated when you explicitly copy
  - Standard copy-paste behavior
  - Persistent across applications
  - Use case: Traditional copy-paste workflow

- **SECONDARY** - Historically existed in X11, rarely used in Wayland
  - Generally ignore in practice

#### Clipboard Tools

**For Wayland:**
- `wl-clipboard` package (provides `wl-copy` and `wl-paste`)
  - Copy: `echo "text" | wl-copy`
  - Paste: `wl-paste > file.txt`
  - Copy to PRIMARY: `echo "text" | wl-copy --primary`
  - Paste from PRIMARY: `wl-paste --primary`
  - Watch for changes: `wl-paste --watch my-command`
  - Clear clipboard: `wl-copy --clear`

**Clipboard Managers:**
- `copyq` - Advanced clipboard manager with history, editing, and scripting
- `gpaste` - Clipboard management system with GNOME integration
- `clipboard-indicator` - GNOME Shell extension for clipboard history (recommended)

#### Recommended Linux Workflow

For Wayland (GNOME/KDE):
```bash
# Install clipboard tools
nix shell nixpkgs#wl-clipboard

# Basic usage
echo "important text" | wl-copy          # Copy to CLIPBOARD
wl-paste                                  # Paste from CLIPBOARD
wl-paste > saved.txt                      # Save clipboard to file

# Primary selection (mouse-based)
echo "quick text" | wl-copy --primary     # Copy to PRIMARY
wl-paste --primary                        # Paste from PRIMARY

# Auto-sync PRIMARY to CLIPBOARD (add to shell config)
wl-paste --watch wl-copy --primary --clear
```

For persistent clipboard history, consider using `copyq` or GNOME's `clipboard-indicator` extension.

### macOS Clipboard Management

macOS uses a single unified clipboard (PRIMARY/CLIPBOARD distinction doesn't exist):

#### Built-in Clipboard

- Standard clipboard: Cmd+C to copy, Cmd+V to paste
- Clipboard history: Cmd+Shift+V (macOS Ventura 13.0+)
- Universal Clipboard: Syncs clipboard across Apple devices (same iCloud account)

#### Clipboard Tools

**Built-in:**
- `pbcopy` - Copy to clipboard
  - Copy file: `cat file.txt | pbcopy`
  - Copy command output: `date | pbcopy`
  - Copy with MIME type: `echo "<b>bold</b>" | pbcopy -text/html`

- `pbpaste` - Paste from clipboard
  - Paste to terminal: `pbpaste`
  - Paste to file: `pbpaste > saved.txt`
  - Check if clipboard has image: `pbpaste -prefer txt | wc -l` (0 = image)

**Third-party Clipboard Managers:**
- `Maccy` - Open-source clipboard manager with keyboard shortcut (Cmd+Shift+C)
- `Paste` - Beautiful clipboard manager with pinning and collections
- `CopyClip` - Lightweight clipboard manager
- `Alfred` (with Powerpack) - Clipboard history feature

#### Recommended macOS Workflow

```bash
# Basic usage
echo "important text" | pbcopy            # Copy to clipboard
pbpaste                                    # Paste from clipboard
pbpaste > saved.txt                        # Save clipboard to file

# Check clipboard content type
pbpaste -prefer txt | wc -l                # If 0, likely image/non-text
file /dev/stdin <<< "$(pbpaste)"          # Detect content type

# Pipe clipboard through filters
pbpaste | tr '[:upper:]' '[:lower:]' | pbcopy    # Convert to lowercase
pbpaste | wc -w                            # Count words in clipboard
```

### Cross-Platform Considerations

When working across Linux and macOS:

1. **Clipboard protocols differ**
   - Linux: Wayland (PRIMARY/CLIPBOARD selections via wl-clipboard)
   - macOS: Single clipboard (pbcopy/pbpaste)
   - SSH sessions: Use terminal multiplexers (zellij/tmux) with OSC 52 escape sequences

2. **Terminal clipboard access**
   - Most modern terminals support OSC 52 for clipboard access (works over SSH)
   - zellij: Built-in clipboard integration (see configuration docs)
   - tmux: `bind-key -T copy-mode-vi y send-keys -X copy-pipe "wl-copy"` (Linux) or `"pbcopy"` (macOS)
   - For remote systems, clipboard forwarding tools (lemonade) can bridge local/remote clipboards

3. **SSH and remote clipboard**
   - Local clipboard doesn't automatically transfer to remote SSH sessions
   - OSC 52 escape sequences work in modern terminal emulators (WezTerm, kitty, Alacritty)
   - Tools like `lemonade` or `rbounce` can forward clipboard over SSH
   - No need for X11 forwarding on Wayland (unlike X11 setups)

4. **Clipboard history persistence**
   - Linux: Clipboard managers typically persist across reboots
   - macOS: Built-in clipboard cleared on reboot (use Maccy/Paste for persistence)
   - Consider using cloud-synced solutions for cross-device consistency

### Security Considerations

- Clipboards can contain sensitive data (passwords, tokens, personal info)
- Some clipboard managers log history to disk (encrypt if necessary)
- Web applications can read clipboard (browser permissions)
- Clear clipboard after sensitive operations: `echo "" | wl-copy` (Linux) or `echo "" | pbcopy` (macOS)
- On multi-user systems, be aware that clipboard contents may be accessible

---

## Appendix C: Historical Context - xremap Conflict

### The Original Problem

Previously, both kanata and xremap were enabled simultaneously, causing a conflict because both tools tried to grab `/dev/input/event*` devices:

1. kanata grabbed physical keyboard (`/dev/input/event0`)
2. xremap tried to grab same device → failed with "Device or resource busy"
3. xremap created virtual device (`/dev/input/event12`)
4. kanata grabbed xremap's virtual device
5. **Circular conflict** → xremap spun at 100% CPU → **keyboard/mouse freeze**

### Resolution

The conflict was resolved by disabling xremap in the configuration. Only kanata is now active, providing a clean, conflict-free setup.

**xremap status:**
- Files still exist (`xremap.nix`, `xremap.yml`)
- Not imported in `default.nix`
- Service not running
- Configuration preserved for potential future use

### Alternative Approaches (If Restoring xremap)

**Option 1: Use kanata only (Current - Recommended)**
- Keep kanata for all remapping
- Add Alt→Ctrl remapping to kanata.kbd if needed
- Pros: Single remapper, no conflicts, simpler
- Cons: Less application-aware than xremap

**Option 2: Use xremap only**
- Disable kanata completely
- Add hyper key mappings to xremap.yml
- Use xremap-flake module for proper GNOME integration
- Pros: Application-aware (can distinguish terminals from GUI apps)
- Cons: More complex setup, lose kanata's advanced features

**Option 3: Hybrid (Advanced)**
- Use kanata for low-level key remapping (Caps Lock → Esc)
- Use xremap only for application-specific remapping
- Configure xremap to read from kanata's virtual device
- Pros: Best of both worlds
- Cons: Most complex, requires careful device coordination
