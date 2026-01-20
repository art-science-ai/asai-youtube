#!/usr/bin/env python3
"""
Nerd-dictation voice command processor
Intelligent command processing for window management, applications, and text

This script intercepts voice input from nerd-dictation and processes commands:
- Window management (focus, move via PaperWM)
- Application launching (terminal, browser, file manager)
- Punctuation and symbol replacement
- Text normalization

Installation:
  1. Copy this script to ~/.config/nerd-dictation/nerd-dictation.py
  2. Make it executable: chmod +x ~/.config/nerd-dictation/nerd-dictation.py
  3. Nerd-dictation will automatically use it if present

Usage:
  nerd-dictation begin --output-script=$HOME/.config/nerd-dictation/nerd-dictation.py
"""

import os
import subprocess
import sys


def process_command(text: str) -> str:
    """
    Process voice command and return text to type (or empty string for commands only).

    Args:
        text: The transcribed text from nerd-dictation

    Returns:
        Text to type at cursor, or empty string if command was executed
    """
    t = text.lower().strip()

    # ============================================================
    # WINDOW MANAGEMENT (PaperWM for GNOME)
    # ============================================================
    if "go to neovim" in t or "focus neovim" in t:
        focus_window_by_title("neovim")
        return ""

    if "go to terminal" in t or "focus terminal" in t:
        focus_window_by_title("ghostty")
        return ""

    if "go to browser" in t or "focus browser" in t:
        focus_window_by_title("vivaldi")
        return ""

    if "move left" in t or "switch left" in t:
        execute_paperwm_command("switch-left")
        return ""

    if "move right" in t or "switch right" in t:
        execute_paperwm_command("switch-right")
        return ""

    if "move up" in t or "switch up" in t:
        execute_paperwm_command("switch-up")
        return ""

    if "move down" in t or "switch down" in t:
        execute_paperwm_command("switch-down")
        return ""

    if "close window" in t:
        send_keybinding("<Super>w")
        return ""

    # ============================================================
    # APPLICATION LAUNCHING
    # ============================================================
    if t == "open terminal" or t == "launch terminal":
        execute_command("ghostty &")
        return ""

    if t == "open files" or t == "launch files":
        execute_command("ghostty -e yazi &")
        return ""

    if t == "open browser" or t == "launch browser":
        execute_command("vivaldi &")
        return ""

    if t == "open slack" or t == "launch slack":
        execute_command("slack &")
        return ""

    # ============================================================
    # PUNCTUATION & SYMBOLS
    # ============================================================
    replacements = {
        "period": ".",
        "comma": ",",
        "new line": "\n",
        "open paren": "(",
        "close paren": ")",
        "open bracket": "[",
        "close bracket": "]",
        "open brace": "{",
        "close brace": "}",
        "at sign": "@",
        "hash tag": "#",
        "dollar sign": "$",
        "percent": "%",
        "caret": "^",
        "ampersand": "&",
        "asterisk": "*",
        "underscore": "_",
        "plus sign": "+",
        "equals": "=",
        "minus": "-",
        "pipe": "|",
        "backslash": "\\",
        "forward slash": "/",
        "question mark": "?",
        "exclamation": "!",
        "colon": ":",
        "semi colon": ";",
        "quote": "'",
        "double quote": '"',
        "tilde": "~",
        "backtick": "`",
    }

    for word, symbol in replacements.items():
        t = t.replace(word, symbol)

    # ============================================================
    # TEXT NORMALIZATION
    # ============================================================
    # Capitalize first letter of sentences
    t = capitalize_sentences(t)

    # Add spacing around symbols for better readability
    t = add_symbol_spacing(t)

    return t


def focus_window_by_title(title: str) -> None:
    """Focus window by title using GNOME DBus."""
    try:
        subprocess.run(
            [
                "gdbus",
                "call",
                "--session",
                "--dest",
                "org.gnome.Shell",
                "--object-path",
                "/org/gnome/Shell",
                "--method",
                "org.gnome.Shell.Eval",
                f'global.display.focus_window_by_title("{title}")',
            ],
            check=True,
            capture_output=True,
        )
    except (subprocess.CalledProcessError, FileNotFoundError):
        # Fallback: try wmctrl
        try:
            subprocess.run(["wmctrl", "-a", title], check=True)
        except (subprocess.CalledProcessError, FileNotFoundError):
            pass


def execute_paperwm_command(command: str) -> None:
    """Execute PaperWM command via DBus."""
    try:
        subprocess.run(
            [
                "gdbus",
                "call",
                "--session",
                "--dest",
                "org.gnome.Shell",
                "--object-path",
                "/org/gnome/shell/extensions/paperwm",
                "--method",
                f"org.gnome.Shell.Extensions.PaperWM.{command}",
            ],
            check=True,
            capture_output=True,
        )
    except (subprocess.CalledProcessError, FileNotFoundError):
        pass


def send_keybinding(keybinding: str) -> None:
    """Send keybinding via appropriate tool (X11 or Wayland)."""
    # Try wtype for Wayland first
    try:
        subprocess.run(
            ["wtype", keybinding],
            check=True,
            capture_output=True,
        )
        return
    except (subprocess.CalledProcessError, FileNotFoundError):
        pass

    # Fallback to xdotool for X11
    try:
        subprocess.run(
            ["xdotool", "key", keybinding],
            check=True,
            capture_output=True,
        )
    except (subprocess.CalledProcessError, FileNotFoundError):
        pass


def execute_command(command: str) -> None:
    """Execute shell command in background."""
    try:
        subprocess.Popen(command, shell=True, start_new_session=True)
    except Exception:
        pass


def capitalize_sentences(text: str) -> str:
    """Capitalize the first letter of each sentence."""
    result = []
    capitalize_next = True

    for char in text:
        if capitalize_next and char.isalpha():
            result.append(char.upper())
            capitalize_next = False
        else:
            result.append(char)
            if char in ".!?":
                capitalize_next = True

    return "".join(result)


def add_symbol_spacing(text: str) -> str:
    """Add spacing around symbols for better readability."""
    # Remove extra spaces
    text = " ".join(text.split())

    # Add space after punctuation if missing (but not before)
    import re

    text = re.sub(r"([.,!?;:])(?=[a-zA-Z])", r"\1 ", text)

    return text


def main():
    """Main entry point for nerd-dictation script integration."""
    if len(sys.argv) > 1:
        # Read from stdin or file
        if sys.argv[1] == "process":
            text = sys.stdin.read()
            result = process_command(text)
            print(result, end="")
        else:
            # Direct invocation with text argument
            text = " ".join(sys.argv[1:])
            result = process_command(text)
            print(result, end="")
    else:
        # Interactive mode (for testing)
        print("Nerd-dictation command processor - Interactive mode")
        print("Type 'exit' to quit")
        print()

        while True:
            try:
                text = input("voice> ")
                if text.lower() == "exit":
                    break
                result = process_command(text)
                if result:
                    print(f"→ {result}")
                else:
                    print("→ (command executed)")
            except (EOFError, KeyboardInterrupt):
                break


if __name__ == "__main__":
    main()
