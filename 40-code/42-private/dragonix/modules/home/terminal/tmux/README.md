# Tmux Configuration

This module provides a robust Tmux configuration managed via Nix Home Manager, designed to replace Zellij with a familiar "modern" feel.

## ⚠️ Current Status (End of Day - Jan 18, 2026)

| Feature | Status | Notes |
| :--- | :--- | :--- |
| **Top Status Bar** | ✅ Working | Positioned at the top. |
| **Smart Splits** | ✅ Working | Seamless `Ctrl+h/j/k/l` navigation with Neovim. |
| **WezTerm Shortcuts** | ✅ Working | `Ctrl+Shift+t/w` and `Ctrl+Tab` cycle are active. |
| **Active Borders** | ⚠️ Partial | Set to `heavy` lines with **Rosewater** color, but limited to Tmux's single-line border capability. |
| **Tab Naming** | ⚠️ Glitchy | Catppuccin often defaults to `#T` (hostname). Forced `#W` in config, but may require a server restart. |
| **Which-Key** | ❌ Broken | Manual binding removed. Currently returns `127` (Command not found). |
| **Default Layout** | ❌ Broken | 70/30 split hook is not triggering reliably on startup. |

---

## Features

- **Top Status Bar**: Tabline is positioned at the top.
- **Smart Splits**: Seamless navigation between Tmux panes and Neovim splits.
- **Active Borders**: Active pane highlighted with a **Rosewater** heavy border.
- **Session Manager**: Uses `tmux-sessionx` (SessionX) bound to `<Leader> + f`.

## Workflow & Concepts

| Concept | Tmux Terminology | Equivalent to |
| :--- | :--- | :--- |
| **Workspace** | **Session** | Zellij Session / VS Code Workspace |
| **Tab** | **Window** | Browser Tab / Zellij Tab |
| **Split** | **Pane** | Vim Split / Zellij Pane |

## Keybindings

**Leader Key (Prefix)**: `Ctrl + b`

### Navigation (No Prefix needed)
| Key | Action |
| :--- | :--- |
| `Ctrl + h/j/k/l` | Move focus Left/Down/Up/Right (Smart Split aware) |
| `Ctrl + Shift + t` | **New Tab** (Window) |
| `Ctrl + Shift + w` | **Close Tab** (Window) |
| `Ctrl + Tab` | **Next Tab** (Cycle) |
| `Ctrl + Shift + Tab` | **Previous Tab** (Cycle) |
| `Alt + h/j/k/l` | Resize pane |

### Core Actions (Requires Prefix `Ctrl + b`)
| Sequence | Action |
| :--- | :--- |
| `Space` | **Which Key** (Currently Broken) |
| `f` | **SessionX** (Fuzzy find Project/Window) |
| `q` | **Quit Session** (Confirm then kill everything) |
| `d` | **Detach** (Keep session running in background) |

## CLI Cheat Sheet
- `tmux kill-server` (Required to apply config changes)
- `tmux a` (Attach to session)
- `tmux ls` (List sessions)