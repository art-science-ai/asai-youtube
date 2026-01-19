This guide is designed for your specific dual-environment setup: an M1 Mac and an 8-core Linux mini-PC (NixOS). Both configurations focus on local, CPU-optimized performance and the "keyboard-replacement" experience you requested.
1. macOS Setup (Optimized for M1)
On your Mac, we will use VoiceInk. It is native Swift, uses Core ML for near-zero CPU usage, and is specifically built for Apple Silicon.
Installation & Configuration
 * Install via Homebrew:
   brew install --cask voiceink

 * Permissions: Upon first launch, you must grant Microphone and Accessibility permissions. This allows the app to "type" into your terminal (Ghostty/WezTerm) and browser.
 * Optimization: * Open Settings and select the Base or Small model. On an M1, these are nearly instantaneous.
   * Set a global Push-to-Talk hotkey (e.g., Cmd + Shift + D).
   * Enable "Auto-paste" so text flows directly into your cursor.
2. Linux Setup (NixOS / 8-Core Mini-PC)
For Linux, we’ll use Nerd-dictation. It is the most lightweight option for a GPU-less setup and is highly scriptable for your "intelligent" command needs.
Step 1: NixOS Configuration
Add this to your home.nix or system config. This installs the engine and the Wayland typing tool (wtype).
{ pkgs, ... }:

let
  nerd-dictation = pkgs.python3Packages.buildPythonApplication {
    pname = "nerd-dictation";
    version = "unstable";
    src = pkgs.fetchFromGitHub {
      owner = "ideasman42";
      repo = "nerd-dictation";
      rev = "main";
      sha256 = "sha256-R3jL9v/7U6Bv9S8R5Z9X8P3L4M5N6O7P8Q9R0S1T2U3="; # Verify hash
    };
    propagatedBuildInputs = with pkgs.python3Packages; [ vosk pyaudio ];
  };
in {
  home.packages = [ nerd-dictation pkgs.wtype ];

  # Global Keybinds (Example for Hyprland/Sway)
  wayland.windowManager.hyprland.settings = {
    bind = [ "$mainMod, D, exec, nerd-dictation begin --input-tool=WTYPE" ];
    bindr = [ "$mainMod, D, exec, nerd-dictation end" ];
  };
}

Step 2: Download the Vosk Model
 * mkdir -p ~/.config/nerd-dictation/model
 * Download the Small English Model (~50MB) from Vosk Models.
 * Extract it so the files are directly inside the model folder.
3. The "Intelligent Assistant" Logic
This is where you replicate the CLI/API commands for your specific stack. Create or edit ~/.config/nerd-dictation/nerd-dictation.py:
import os
import subprocess

def nerddictation_process(text):
    t = text.lower().strip()

    # --- WINDOW MANAGEMENT (Hyprland example) ---
    if "go to neovim" in t:
        os.system("hyprctl dispatch focuswindow title:nvim")
        return ""

    # --- ZELLIJ COMMANDS ---
    if t == "new pane":
        os.system("zellij action new-pane")
        return ""

    # --- APP LAUNCHING ---
    if t == "open yazi":
        os.system("ghostty -e yazi &")
        return ""

    # --- PUNCTUATION & SYMBOLS ---
    replacements = {
        "period": ".", "comma": ",", "new line": "\n",
        "open bracket": "[", "close bracket": "]"
    }
    for word, symbol in replacements.items():
        t = t.replace(word, symbol)

    return t

4. Connecting Your Stack (API Cheatsheet)
To make your voice commands work across your tools, use these CLI hooks in the Python script above:
| Target | Tool/API | Command Pattern |
|---|---|---|
| Neovim | nvr | nvr --remote-send '<Esc>:w<CR>' (Save) |
| Zellij | zellij action | zellij action go-to-next-tab |
| Obsidian | REST API Plugin | curl -X POST http://localhost:27123/commands/... |
| Vivaldi | Wayland Keys | wtype -M ctrl -P tab -m ctrl (Next Tab) |
Summary of Workflow
 * Mac: Hold Cmd+Shift+D, talk to VoiceInk, release.
 * Linux: Hold Super+D, talk to Nerd-dictation, release.
 * Both: Your 8-core CPU handles the processing locally with ~0.5s latency.
Would you like me to write a Systemd User Service for the Linux side so the assistant is always active in the background?

