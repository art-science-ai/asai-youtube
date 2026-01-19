## Overview

- My setup for Niri + Noctalia shell on NixOS
- I am currently using GNOME + PaperWM and want to migrate to Niri + Noctalia shell while staying as close to existing setup as possible (e.g. using PaperWM keybinds)

## Setup
- The configuration is split into multiple files:
  - `default.nix`: Main entry point, imports other modules.
  - `niri.nix`: Configures the Niri window manager and its keybindings.
  - `noctalia.nix`: Configures the Noctalia shell.
  - `fuzzel.nix`: Configures the Fuzzel application launcher.
- `niri.nix` sets `noctalia-shell` to launch at startup.
- Keybindings are defined in `niri.nix` within the `programs.niri.settings.binds` attribute set.

## Problems

- We have a battery indicator in task bar even though this is a desktop
  - **Solution:** This is likely a default widget in `noctalia-shell`. To disable it, investigate the configuration options for `programs.noctalia-shell` in your `noctalia.nix` file. You may need to refer to the `noctalia` flake's documentation to find the specific setting to disable shell widgets.
- Hotkeys showing up in super + ? shortcut are not matching what i've set. Many basic hotkeys are showing "not bound" - e.g. basic things like moving focus, etc.
  - **Solution:** The hotkey overlay shows all *possible* actions, not just your bound ones. The "not bound" messages are expected for actions you haven't assigned a key to. To fix this, add bindings for these actions in `niri.nix`. A full list of available actions is in the Appendix.
- We need to map all the normal hotkeys from paperwm or use defaults.
  - **Solution Outline:** To replicate your `paperwm` workflow, you need to map its keybindings to `niri` actions in `niri.nix`. Based on your `gnome.nix`, here is a suggested mapping:
    | PaperWM Action | PaperWM Keys | Niri Action |
    | --- | --- | --- |
    | `close-window` | `<Super>w` | `close-window` |
    | `switch-left` | `<Super>h`, `<Super>Left` | `focus-column-left` |
    | `switch-right`| `<Super>l`, `<Super>Right` | `focus-column-right` |
    | `switch-up` | `<Super>k`, `<Super>Up` | `focus-window-up` |
    | `switch-down` | `<Super>j`, `<Super>Down` | `focus-window-down` |
    | `move-left` | `<Super><Ctrl>h` | `move-column-left` |
    | `move-right` | `<Super><Ctrl>l` | `move-column-right` |
    | `move-up` | `<Super><Ctrl>k` | `move-window-up` |
    | `move-down` | `<Super><Ctrl>j` | `move-window-down` |
    | `switch-monitor-left` | `<Super><Shift>h` | `focus-monitor-left` |
    | `switch-monitor-right`| `<Super><Shift>l` | `focus-monitor-right` |
    | `move-window-monitor-left`| `<Super><Shift><Ctrl>h`|`move-window-to-monitor-left`|
    | `move-window-monitor-right`|`<Super><Shift><Ctrl>l`|`move-window-to-monitor-right`|

- When I open windows there is a large empty space between top of window and taskbar.
  - **Solution:** This is controlled by `niri`'s `gaps` or `struts` settings. You can adjust this by adding a `layout` block to `programs.niri.settings` in `niri.nix`. For example, to remove the gaps:
    ```nix
    layout {
      gaps = 0;
    }
    ```
- Clipboard management is not working properly to copy paste from terminals with ctrl+shift+v - we need to replicate clipboard setup from GNOME
  - **Solution Outline:** Your observation that this works in GNOME but not `niri` is key. The problem isn't the terminal, but the environment. GNOME provides a fully integrated clipboard service that `wezterm` hooks into automatically. A minimal compositor like `niri` does not, so we must build this integration declaratively.
    1.  **Declarative PRIMARY -> CLIPBOARD Sync:** The `wl-paste --watch` command should be a declarative `systemd` user service. We will create a new Nix file (`clipboard-sync.nix`) to define this service and ensure it's managed by Nix.
    2.  **Terminal Clipboard Protocol:** We need to investigate how `wezterm` (and other terminals) discover and interact with the clipboard on Wayland. It might require explicit configuration to use a specific protocol (like `primary_selection_protocol`) or to correctly interface with `copyq` when not running inside GNOME's pre-configured environment. We will consult the `wezterm` Wayland documentation.

## Appendix: full list of niri actions
- `quit`: Exit niri
- `power-off-monitors`: Power off all monitors via DPMS
- `power-on-monitors`: Power on all monitors via DPMS
- `spawn`: Spawn a command
- `spawn-sh`: Spawn a command through the shell
- `do-screen-transition`: Do a screen transition
- `screenshot`: Open the screenshot UI
- `screenshot-screen`: Screenshot the focused screen
- `screenshot-window`: Screenshot the focused window
- `toggle-keyboard-shortcuts-inhibit`: Enable or disable the keyboard shortcuts inhibitor (if any) for the focused surface
- `close-window`: Close the focused window
- `fullscreen-window`: Toggle fullscreen on the focused window
- `toggle-windowed-fullscreen`: Toggle windowed (fake) fullscreen on the focused window
- `focus-window`: Focus a window by id
- `focus-window-in-column`: Focus a window in the focused column by index
- `focus-window-previous`: Focus the previously focused window
- `focus-column-left`: Focus the column to the left
- `focus-column-right`: Focus the column to the right
- `focus-column-first`: Focus the first column
- `focus-column-last`: Focus the last column
- `focus-column-right-or-first`: Focus the next column to the right, looping if at end
- `focus-column-left-or-last`: Focus the next column to the left, looping if at start
- `focus-column`: Focus a column by index
- `focus-window-or-monitor-up`: Focus the window or the monitor above
- `focus-window-or-monitor-down`: Focus the window or the monitor below
- `focus-column-or-monitor-left`: Focus the column or the monitor to the left
- `focus-column-or-monitor-right`: Focus the column or the monitor to the right
- `focus-window-down`: Focus the window below
- `focus-window-up`: Focus the window above
- `focus-window-down-or-column-left`: Focus the window below or the column to the left
- `focus-window-down-or-column-right`: Focus the window below or the column to the right
- `focus-window-up-or-column-left`: Focus the window above or the column to the left
- `focus-window-up-or-column-right`: Focus the window above or the column to the right
- `focus-window-or-workspace-down`: Focus the window or the workspace below
- `focus-window-or-workspace-up`: Focus the window or the workspace above
- `focus-window-top`: Focus the topmost window
- `focus-window-bottom`: Focus the bottommost window
- `focus-window-down-or-top`: Focus the window below or the topmost window
- `focus-window-up-or-bottom`: Focus the window above or the bottommost window
- `move-column-left`: Move the focused column to the left
- `move-column-right`: Move the focused column to the right
- `move-column-to-first`: Move the focused column to the start of the workspace
- `move-column-to-last`: Move the focused column to the end of the workspace
- `move-column-left-or-to-monitor-left`: Move the focused column to the left or to the monitor to the left
- `move-column-right-or-to-monitor-right`: Move the focused column to the right or to the monitor to the right
- `move-column-to-index`: Move the focused column to a specific index on its workspace
- `move-window-down`: Move the focused window down in a column
- `move-window-up`: Move the focused window up in a column
- `move-window-down-or-to-workspace-down`: Move the focused window down in a column or to the workspace below
- `move-window-up-or-to-workspace-up`: Move the focused window up in a column or to the workspace above
- `consume-or-expel-window-left`: Consume or expel the focused window left
- `consume-or-expel-window-right`: Consume or expel the focused window right
- `consume-window-into-column`: Consume the window to the right into the focused column
- `expel-window-from-column`: Expel the focused window from the column
- `swap-window-right`: Swap focused window with one to the right
- `swap-window-left`: Swap focused window with one to the left
- `toggle-column-tabbed-display`: Toggle the focused column between normal and tabbed display
- `set-column-display`: Set the display mode of the focused column
- `center-column`: Center the focused column on the screen
- `center-window`: Center the focused window on the screen
- `center-visible-columns`: Center all fully visible columns on the screen
- `focus-workspace-down`: Focus the workspace below
- `focus-workspace-up`: Focus the workspace above
- `focus-workspace`: Focus a workspace by reference (index or name)
- `focus-workspace-previous`: Focus the previous workspace
- `move-window-to-workspace-down`: Move the focused window to the workspace below
- `move-window-to-workspace-up`: Move the focused window to the workspace above
- `move-window-to-workspace`: Move the focused window to a workspace by reference (index or name)
- `move-column-to-workspace-down`: Move the focused column to the workspace below
- `move-column-to-workspace-up`: Move the focused column to the workspace above
- `move-column-to-workspace`: Move the focused column to a workspace by reference (index or name)
- `move-workspace-down`: Move the focused workspace down
- `move-workspace-up`: Move the focused workspace up
- `move-workspace-to-index`: Move the focused workspace to a specific index on its monitor
- `set-workspace-name`: Set the name of the focused workspace
- `unset-workspace-name`: Unset the name of the focused workspace
- `focus-monitor-left`: Focus the monitor to the left
- `focus-monitor-right`: Focus the monitor to the right
- `focus-monitor-down`: Focus the monitor below
- `focus-monitor-up`: Focus the monitor above
- `focus-monitor-previous`: Focus the previous monitor
- `focus-monitor-next`: Focus the next monitor
- `focus-monitor`: Focus a monitor by name
- `move-window-to-monitor-left`: Move the focused window to the monitor to the left
- `move-window-to-monitor-right`: Move the focused window to the monitor to the right
- `move-window-to-monitor-down`: Move the focused window to the monitor below
- `move-window-to-monitor-up`: Move the focused window to the monitor above
- `move-window-to-monitor-previous`: Move the focused window to the previous monitor
- `move-window-to-monitor-next`: Move the focused window to the next monitor
- `move-window-to-monitor`: Move the focused window to a specific monitor
- `move-column-to-monitor-left`: Move the focused column to the monitor to the left
- `move-column-to-monitor-right`: Move the focused column to the monitor to the right
- `move-column-to-monitor-down`: Move the focused column to the monitor below
- `move-column-to-monitor-up`: Move the focused column to the monitor above
