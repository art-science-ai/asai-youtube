# Nerd-Dictation Voice AI Module

Offline voice dictation for NixOS using Vosk speech recognition with intelligent command processing.

---

## ⚠️ SIMPLIFICATION NEEDED

**Status**: Module is DISABLED (see `modules/home/ai/default.nix`)

This module needs significant simplification before it's ready for use. The current implementation violates key Home Manager principles by making activation depend on heavy downloads and complex setup.

### Issues to Fix

1. **Heavy Download in Activation**
   - Current: Downloads 50MB Vosk model during `nh-home switch`
   - Problem: Blocks activation, slow first setup (~2-3 minutes), network-dependent
   - Fix needed: Download should be optional/manual, or use nixpkgs if available

2. **Too Complex for "One Command" Promise**
   - Current: UV environment creation + model download + Python deps in activation
   - Problem: Too many failure points, hard to debug, non-reproducible
   - Fix needed: Simplify to just package installation + docs

3. **Dependencies Not Available in nixpkgs**
   - Current: vosk and pyaudio not in nixpkgs
   - Problem: Requires UV/workaround, breaks reproducibility
   - Fix needed: Either package vosk/pyaudio for Nix OR document manual setup clearly

### Recommended Simplification Approach

**Option A: Purely Declarative (Recommended)**
- Remove `home.activation` entirely
- Document manual setup steps clearly
- Provide installation script that user runs manually
- Module only installs nerd-dictation package + config files
- Pros: Reproducible, predictable, no blocking downloads
- Cons: User runs one manual command after first switch

**Option B: Optional Setup Service**
- Create systemd user service (disabled by default)
- User enables service when ready: `systemctl --user enable --now nerd-dictation-setup`
- Service handles downloads and environment setup
- Pros: On-demand setup, doesn't block activation
- Cons: Extra step for user

**Option C: Hybrid with Nix-Managed Model**
- Package Vosk model as fixed-output derivation (partially done)
- Install model via `home.file` from Nix store (reproducible)
- Only UV environment setup in activation (lighter)
- Pros: Model is reproducible, activation is faster
- Cons: Still has activation complexity

### Work Remaining When Revisiting

1. Choose simplification approach (recommend Option A)
2. Remove `home.activation.setupNerdDictationEnv`
3. Create clear manual setup instructions
4. Add optional setup script (e.g., `~/.config/nix-config/modules/home/ai/nerd-dictation/setup.sh`)
5. Update documentation to reflect simplified approach
6. Test from clean state
7. Re-enable module in `modules/home/ai/default.nix`

### Reference Implementation Ideas

```bash
# Simplified manual setup script
#!/usr/bin/env bash
set -euo pipefail

echo "Setting up nerd-dictation..."

# Create UV environment
mkdir -p ~/.local/share/nerd-dictation
cd ~/.local/share/nerd-dictation
uv init --no-readme
uv add vosk pyaudio

# Download model
mkdir -p ~/.config/nerd-dictation/model
curl -L https://alphacephei.com/vosk/models/vosk-model-small-en-us-0.15.zip \
  -o /tmp/vosk-model.zip
unzip -q /tmp/vosk-model.zip -d ~/.config/nerd-dictation/
mv ~/.config/nerd-dictation/vosk-model-small-en-us-0.15/* ~/.config/nerd-dictation/model/
rmdir ~/.config/nerd-dictation/vosk-model-small-en-us-0.15
rm /tmp/vosk-model.zip

echo "✅ Ready! Press Super+D to start dictating."
```

---

## Table of Contents

- [⚠️ Simplification Needed](#-simplification-needed) **READ THIS FIRST**
- [Overview](#overview)
- [Architecture](#architecture)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Voice Command Reference](#voice-command-reference)
- [Troubleshooting](#troubleshooting)
- [File Structure](#file-structure)
- [References](#references)

## Overview

This module provides offline voice dictation using Vosk speech recognition, optimized for CPU-only systems. It supports push-to-talk activation and intelligent command processing for:

- Window management (PaperWM integration)
- Application launching
- Text dictation with punctuation
- Symbol replacement

**Keybinding**: Super+D (press and hold to speak, release to process)

## Architecture

### Fully Declarative Setup

This module uses a hybrid approach for optimal user experience:

**Declarative (Nix-managed):**
- Vosk model installed from Nix store (reproducible, cached)
- Configuration files (README, commands, voice processor)
- System integration (keybindings, packages)

**Automated (home.activation):**
- UV environment created automatically on first switch
- Python dependencies (vosk, pyaudio) installed automatically
- Self-healing (verifies and fixes missing dependencies)

**Benefits:**
1. One command setup: `nh-home switch`
2. Model is reproducible (fixed-output derivation in Nix store)
3. Fast iteration - modify voice commands without rebuilds
4. Fully automated - no manual steps required

### Components

```
nerd-dictation/
├── Package (pkgs/nerd-dictation/)
│   ├── package.nix          # Main package definition
│   └── vosk-model.nix       # Vosk model (fixed-output derivation)
│
├── Overlay (overlays/nerd-dictation.nix)
│   └── Exposes packages to system
│
└── Module (modules/home/ai/nerd-dictation/)
    ├── default.nix                    # Module entry point
    ├── nerd-dictation-cli.nix         # Main configuration
    ├── config/
    │   ├── README.md                  # Quick setup guide
    │   ├── commands.md                # Command reference
    │   └── nerd-dictation.py          # Voice command processor
    └── README.md                      # This file
```

## Features

### Core Capabilities

- **Offline Operation**: No network connection required
- **CPU-Optimized**: Efficient on 8-core systems (no GPU needed)
- **Push-to-Talk**: Activate with Super+D
- **Intelligent Commands**: Process voice commands for window/app management
- **Extensible**: Easy to add custom commands
- **Low Latency**: < 0.5 seconds from release to text

### Voice Commands

- **Window Management**: Focus windows, navigate workspaces
- **Application Launching**: Open terminal, browser, file manager
- **Punctuation**: Period, comma, new line, quotes, etc.
- **Symbols**: At sign, hash tag, dollar sign, etc.

See [Voice Command Reference](#voice-command-reference) for complete list.

## Installation

### One-Command Setup

```bash
nh-home switch
```

That's it! Everything is automated:

1. **Vosk model** installed from Nix store (~50MB, reproducible)
2. **UV environment** created automatically
3. **Python dependencies** (vosk, pyaudio) installed automatically
4. **Configuration files** placed in `~/.config/nerd-dictation/`

First activation will take a few minutes while dependencies are installed. Subsequent switches are instant.

### Verification

```bash
# Check package is installed
which nerd-dictation

# Check model is installed
ls ~/.config/nerd-dictation/model/
# Should see: am/ graph/ conf/ fst/ mdl/ etc.

# Check UV environment
ls ~/.local/share/nerd-dictation/.venv/bin/python
```

## Usage

### Basic Dictation

1. Press **Super+D** - Start listening
2. Speak text
3. Release **Super+D** - Stop and process
4. Text appears at cursor

### Voice Commands

**Window Management:**
- "go to terminal" - Focus terminal
- "move left" - Switch to window left
- "move right" - Switch to window right
- "close window" - Close current window

**Application Launching:**
- "open terminal" - Launch Ghostty
- "open files" - Launch Yazi file manager
- "open browser" - Launch Vivaldi

**Punctuation:**
- "period" → .
- "comma" → ,
- "new line" → \n
- "open paren" → (

See [Voice Command Reference](#voice-command-reference) for complete list.

### Manual Testing

Test without keybinding:

```bash
# Start recording
nerd-dictation begin

# Speak your text...

# Stop and process
nerd-dictation end
```

## Configuration

### Custom Commands

Edit `~/.config/nerd-dictation/nerd-dictation.py`:

```python
def process_command(text: str) -> str:
    t = text.lower().strip()

    # Add your custom command
    if "play music" in t:
        execute_command("spotify &")
        return ""

    # ... rest of function
```

Then test immediately (no rebuild needed):
```bash
# Press Super+D and try your command
```

### Model Selection

The Small English Model is installed by default. To use a different model:

1. Download from https://alphacephei.com/vosk/models
2. Create Nix package for it (follow `vosk-model.nix` pattern)
3. Update module to use new model

Or manually replace `~/.config/nerd-dictation/model/` contents (not recommended - breaks reproducibility).

### Keybinding Customization

Edit `modules/home/window-managers/gnome/gnome.nix`:

```nix
"org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/nerd-dictation" = {
  binding = "<Super>d";  # Change to desired binding
};
```

Then rebuild:
```bash
nh-home switch
```

## Voice Command Reference

### Window Management (PaperWM)

| Command | Action |
|---------|--------|
| "go to neovim" | Focus Neovim window |
| "go to terminal" | Focus terminal window |
| "go to browser" | Focus browser window |
| "move left" | Switch to window left |
| "move right" | Switch to window right |
| "move up" | Switch to window above |
| "move down" | Switch to window below |
| "close window" | Close current window |

### Application Launching

| Command | Action |
|---------|--------|
| "open terminal" | Launch Ghostty |
| "launch terminal" | Launch Ghostty |
| "open files" | Launch Yazi file manager |
| "open browser" | Launch Vivaldi |
| "open slack" | Launch Slack |

### Punctuation

| Command | Result |
|---------|--------|
| "period" | . |
| "comma" | , |
| "new line" | \n |
| "open paren" | ( |
| "close paren" | ) |
| "open bracket" | [ |
| "close bracket" | ] |
| "open brace" | { |
| "close brace" | } |
| "at sign" | @ |
| "hash tag" | # |
| "dollar sign" | $ |
| "question mark" | ? |
| "exclamation" | ! |

### Examples

```
Voice: "hello world period new line how are you question mark"
Text: "Hello world.\nHow are you?"
```

```
Voice: "go to terminal"
Action: Focus terminal window
```

```
Voice: "open browser new line github period com"
Action: Launch browser, then type "\ngithub.com"
```

## Troubleshooting

### Module Not Available

**Symptom**: `nerd-dictation: command not found`

**Solution**: Verify overlay is applied in `flake.nix`:
```bash
grep -A5 "overlays =" ~/.config/nix-config/flake.nix
```

Should show:
```nix
overlays = [
  (import ./overlays/whisper-diarization.nix)
  (import ./overlays/nerd-dictation.nix)
];
```

### Keybinding Not Working

**Symptom**: Pressing Super+D does nothing

**Solutions**:

1. Check keybinding is registered:
```bash
gsettings get org.gnome.settings-daemon.plugins.media-keys.custom-keybindings/nerd-dictation binding
```
Should return: `'<Super>d'`

2. Check all custom keybindings:
```bash
gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings
```
Should include nerd-dictation path.

3. Log out and back in (GNOME sometimes needs reload)

### Python Dependencies Missing

**Symptom**: `ModuleNotFoundError: No module named 'vosk'`

**Solution**: The activation script should handle this automatically. If not:

```bash
cd ~/.local/share/nerd-dictation
uv add vosk pyaudio
```

Verify:
```bash
ls .venv/lib/python*/site-packages/ | grep -E "(vosk|pyaudio)"
```

### Model Not Found

**Symptom**: `Model not found` or similar error

**Solutions**:

1. Check model location:
```bash
ls ~/.config/nerd-dictation/model/
```
Should see: `am/`, `graph/`, `conf/`, `fst/`, `mdl/`, etc.

2. If missing, rebuild:
```bash
nh-home switch
```

The model should be installed from Nix store automatically.

### No Text Appears

**Symptom**: Text doesn't appear after speaking

**Checks**:

1. Test microphone:
```bash
arecord -f cd -d 5 test.wav
aplay test.wav  # Should hear your recording
```

2. List audio devices:
```bash
pactl list sources short
```

3. Test nerd-dictation manually:
```bash
nerd-dictation begin
# Speak...
nerd-dictation end
```

### Slow Response Time

**Symptom**: Takes > 1 second for text to appear

**Solutions**:

1. Ensure using **Small English Model** (installed by default)
2. Check CPU load:
```bash
htop
```
Should be < 80% during dictation

3. Close unnecessary applications
4. First run is slower (model loads into memory)

### Poor Recognition Accuracy

**Symptoms**: Words misrecognized, poor accuracy

**Solutions**:

1. Speak clearly and at moderate pace
2. Use quiet environment
3. Position microphone close to mouth
4. Test microphone quality:
```bash
arecord -f cd -d 10 test.wav
# Listen for clarity
```

## Performance Expectations

| Metric | Expected Value |
|--------|----------------|
| Latency | < 0.5 seconds |
| CPU Usage | 20-30% (8-core system) |
| Memory | ~100-200MB (Small model) |
| Recognition Accuracy | ~95% (Small model) |

## File Structure

### Package Files

```
pkgs/nerd-dictation/
├── package.nix              # Main package definition
└── vosk-model.nix           # Vosk model (fixed-output derivation)
```

### Overlay Files

```
overlays/
└── nerd-dictation.nix       # Exposes packages to system
```

### Module Files

```
modules/home/ai/nerd-dictation/
├── default.nix              # Module entry point
├── nerd-dictation-cli.nix   # Main configuration
├── config/
│   ├── README.md            # Quick setup guide
│   ├── commands.md          # Command reference
│   └── nerd-dictation.py    # Voice command processor
└── README.md                # This file
```

### Configuration Files (User Home)

```
~/.config/nerd-dictation/
├── model/                   # Vosk model files (symlink to Nix store)
│   ├── am/
│   ├── graph/
│   ├── conf/
│   ├── fst/
│   └── mdl/
├── README.md                # Setup instructions
├── commands.md              # Command reference
└── nerd-dictation.py        # Voice command processor

~/.local/share/nerd-dictation/
├── .venv/                   # UV virtual environment (auto-created)
│   └── lib/python*/site-packages/
│       ├── vosk/
│       └── pyaudio/
└── pyproject.toml           # UV project file (auto-created)
```

## References

### External Resources

- **nerd-dictation**: https://github.com/ideasman42/nerd-dictation
- **vosk models**: https://alphacephei.com/vosk/models
- **vosk documentation**: https://alphacephei.com/vosk/api/doc

### Internal Documentation

- **Voice AI Design**: `~/repos/monorepo/00-inbox/voice-ai.md`
- **Package Definition**: `pkgs/nerd-dictation/package.nix`
- **Module Configuration**: `modules/home/ai/nerd-dictation/nerd-dictation-cli.nix`

### Related Projects

- **whisper-diarization**: Similar hybrid approach pattern
- **vicinae**: Launcher that integrates with voice commands
- **PaperWM**: Tiling window manager for GNOME

## Support

For issues or questions:

1. Check [Troubleshooting](#troubleshooting) section
2. Review `~/.config/nerd-dictation/README.md` for quick reference
3. See `~/.config/nerd-dictation/commands.md` for command list
4. Check upstream issues: https://github.com/ideasman42/nerd-dictation/issues

## License

This module follows the licenses of the included packages:
- nerd-dictation: GPL-3.0-or-later
- vosk: Apache-2.0
