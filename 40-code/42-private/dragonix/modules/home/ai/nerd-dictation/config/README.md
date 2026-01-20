# Nerd-Dictation Configuration

This directory contains configuration for nerd-dictation voice recognition system.

## ⚠️ Module Currently Disabled

This module is disabled pending simplification. See `README.md` for details.

To enable when ready:
1. Follow simplification guide in `../README.md`
2. Uncomment import in `../../default.nix`
3. Run `nh-home switch`

---

## Quick Setup (When Simplified)

**Once the module is simplified**, setup will be:

```bash
nh-home switch
# Then run manual setup script (to be created)
~/.config/nerd-dictation/setup.sh
```

## What Gets Configured

### Automatic (via home.activation)

1. **UV Environment** created at `~/.local/share/nerd-dictation/`
2. **Python Dependencies** (vosk, pyaudio) installed automatically
3. **Self-healing** - verifies and fixes missing dependencies on each switch

### Declarative (via Nix)

1. **Vosk Model** installed from Nix store at `~/.config/nerd-dictation/model/`
2. **Configuration Files** (README, commands, voice processor)
3. **Keybinding** (Super+D) configured in GNOME

## Usage

### Basic Dictation

1. Press **Super+D** - Start listening
2. Speak text
3. Release **Super+D** - Stop and process
4. Text appears at cursor

### Voice Commands

- "go to terminal" - Focus terminal window
- "move left" - Switch to window left
- "open browser" - Launch Vivaldi
- "period" → .
- "new line" → \n

See `commands.md` for complete reference.

## Files

- **README.md** - This file
- **commands.md** - Complete command reference
- **nerd-dictation.py** - Voice command processor (installed automatically)

## Troubleshooting

### Dependencies Missing

If you see `ModuleNotFoundError: No module named 'vosk'`:

```bash
cd ~/.local/share/nerd-dictation
uv add vosk pyaudio
```

### Model Not Found

Check model is installed:
```bash
ls ~/.config/nerd-dictation/model/
```

Should see: `am/`, `graph/`, `conf/`, `fst/`, `mdl/`, etc.

If missing, rebuild:
```bash
nh-home switch
```

### Microphone Issues

Test microphone:
```bash
arecord -f cd -d 5 test.wav
aplay test.wav  # Should hear your recording
```

## Advanced Configuration

### Custom Commands

Edit `~/.config/nerd-dictation/nerd-dictation.py` to add custom voice commands.

Example:
```python
if "play music" in t:
    execute_command("spotify &")
    return ""
```

Changes take effect immediately (no rebuild needed).

### Model Selection

The Small English Model is installed by default (~50MB). To use a different model:

1. Download from https://alphacephei.com/vosk/models
2. Create Nix package in `pkgs/nerd-dictation/vosk-model.nix`
3. Update `nerd-dictation-cli.nix` to use new model

## Performance

- **Latency**: < 0.5 seconds
- **CPU Usage**: 20-30% (8-core system)
- **Memory**: ~100-200MB
- **Accuracy**: ~95% (Small model)

## Resources

- nerd-dictation: https://github.com/ideasman42/nerd-dictation
- vosk models: https://alphacephei.com/vosk/models
- Module docs: `modules/home/ai/nerd-dictation/README.md`
