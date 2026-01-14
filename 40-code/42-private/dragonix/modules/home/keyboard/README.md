# Keyboard Remapping Module

## Overview
- The goal is to design a system that works across both macos (using macbook US keyboard) and linux (using standard windows keyboard)
- I have developed a system that works well with macos and my muscle memory - using a custom hyper key "caps lock" for window management 



## Current State

**Two conflicting keyboard remappers are installed:**

### kanata (keyboard.nix)
- **Status**: ✅ Currently running and working
- **Configuration**: `kanata.kbd`
- **Purpose**: Hyper key mappings
  - Caps Lock → Esc (tap) / Hyper1 (hold): Cmd+Ctrl+Alt
  - Right Ctrl → Hyper4: Ctrl+Alt+Shift
  - Right Alt → Hyper3: Cmd+Alt+Shift
  - Right Meta → Hyper2: Cmd+Ctrl+Shift
- **Systemd service**: `kanata.service` (user service, enabled)
- **Platform**: Linux only

### xremap (xremap.nix)
- **Status**: ❌ Currently enabled but FROZEN (100% CPU)
- **Configuration**: `xremap.yml`
- **Purpose**: macOS-style Alt→Ctrl remapping for GNOME
  - Alt+C/V/A/X/Z/Y → Ctrl+C/V/A/X/Z/Y (in GUI apps)
  - Alt+C → Ctrl+C (in terminals only)
- **Systemd service**: `xremap.service` (user service, enabled)
- **Platform**: Linux only (GNOME/Wayland)

## Problem

**Cannot run both kanata and xremap simultaneously** - they both try to grab `/dev/input/event*` devices:

1. kanata grabs physical keyboard (`/dev/input/event0`)
2. xremap tries to grab same device → fails with "Device or resource busy"
3. xremap creates virtual device (`/dev/input/event12`)
4. kanata grabs xremap's virtual device
5. **Circular conflict** → xremap spins at 100% CPU → **keyboard/mouse freeze**

## Solutions 

Choose **ONE** approach:

### Option 1: Use kanata only (Recommended)
- Keep kanata for hyper keys
- Add Alt→Ctrl remapping to kanata.kbd
- Disable xremap completely
- **Pros**: Single remapper, no conflicts, simpler
- **Cons**: Less application-aware than xremap

### Option 2: Use xremap only
- Disable kanata completely
- Add hyper key mappings to xremap.yml
- Use xremap-flake module for proper GNOME integration
- **Pros**: Application-aware (can distinguish terminals from GUI apps)
- **Cons**: More complex setup

### Option 3: Hybrid (Advanced)
- Use kanata for low-level key remapping (Caps Lock → Esc)
- Use xremap only for application-specific remapping
- Configure xremap to ignore devices kanata already grabbed
- **Pros**: Best of both worlds
- **Cons**: Most complex, requires careful device coordination

## Homerow Mods Configuration

The kanata config includes homerow mods using the **CAGS / SGAC arrangement**:

- **Left hand**: A=Ctrl, S=Alt, D=GUI, F=Shift
- **Right hand**: J=Shift, K=GUI, L=Alt, ;=Ctrl

### Tap-Hold Behavior: tap-hold vs tap-hold-release

The configuration uses `tap-hold` with a 200ms timeout. Understanding the difference between `tap-hold` and `tap-hold-release` is important for understanding how the homerow mods work.

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

## Files

- `keyboard.nix` - Main keyboard module (kanata setup)
- `kanata.kbd` - kanata configuration
- `karabiner.json` - macOS karabiner configuration (Darwin only)
- `xremap.nix` - xremap home-manager module (currently broken)
- `xremap.yml` - xremap configuration (macOS-style remapping)
- `default.nix` - Module imports

