# Zellij configuration

Terminal workspace and multiplexer with vim-zellij-navigator integration. See the parent terminal/ README for general terminal workflow information.

## Design philosophy

- **Manual session control**: Type `zellij` to start/attach (no auto-start on shell init)
- **Seamless neovim integration**: Same keybindings work in neovim and zellij
- **Modal-free workflow**: Common actions available without mode switching
- **Full visibility**: Status bar shows all available commands

## Core features

### Smart-splits.nvim + vim-zellij-navigator integration

- vim-zellij-navigator plugin detects if neovim is running in current pane
- When in neovim: passes Ctrl+hjkl/Alt+hjkl to smart-splits.nvim
- When NOT in neovim: Zellij handles pane navigation/resizing directly
- Same keybindings work seamlessly across neovim and zellij boundaries
- No configuration needed on Neovim side (smart-splits auto-detects via environment)

### Session management

- Manual control: SSH in → type `zellij` when ready
- Zellij automatically attaches to existing session if one exists
- Sessions persist across terminal closures (when linger is enabled)
- Type `zellij attach <name>` for multiple named sessions

### Visual indicators

- Enabled pane_frames for focused/unfocused visual feedback
- Theme: catppuccin-mocha
- Disabled advanced_mouse_actions to prevent hover confusion
- Full status bar displays all available keybindings

## Keybinding reference

### Navigation (works in both neovim and zellij)
- `Ctrl+h` - Move left
- `Ctrl+j` - Move down
- `Ctrl+k` - Move up
- `Ctrl+l` - Move right

### Resize (works in both neovim and zellij)
- `Alt+h` - Resize left
- `Alt+j` - Resize down
- `Alt+k` - Resize up
- `Alt+l` - Resize right

### Panes (zellij only)
- `Alt+n` - New pane
- `Alt+x` - Close current pane
- `Alt+f` - Toggle floating/fullscreen

### Tabs (zellij only)
- `Alt+1-9` - Go to tab 1-9
- `Alt+[` - Previous tab
- `Alt+]` - Next tab
- `Alt+t` - New tab
- `Alt+Shift+x` - Close current tab

### Other
- `Alt+s` - Enter scroll/search mode (for copy/paste)
- `Alt+g` - Lock/unlock mode (pass-through to terminal)
- `Ctrl+q` - Quit zellij

### Scroll mode
- `j/k` - Scroll down/up
- `h/l` - Page up/down
- `d/u` - Half page down/up
- `s` - Enter search mode
- `Esc/Ctrl+c` - Exit scroll mode

## Usage

### Starting zellij

```bash
# Start/attach to default session
zellij

# Start/attach to named session
zellij attach work

# List existing sessions
zellij list-sessions

# Kill specific session
zellij delete-session work
```

### Working with neovim in zellij

1. Open zellij: `zellij`
2. Create panes: `Alt+n`
3. Open neovim in a pane: `nvim file.txt`
4. Use Ctrl+hjkl to navigate between neovim splits
5. Use Ctrl+hjkl to move from neovim to adjacent zellij pane
6. Same keybindings work everywhere

### Terminal buffers in neovim

When in a neovim terminal buffer (`:terminal`, toggleterm):
- smart-splits ignores terminal buffers (`ignored_buftypes = ["terminal"]`)
- Ctrl+hjkl passes through to zellij for pane navigation
- This allows natural navigation from neovim terminal to zellij panes

**Known limitation - yazi.nvim**: When yazi is open inside neovim (via yazi.nvim), Ctrl+hjkl navigation to adjacent zellij panes doesn't work. This is because yazi (the terminal application) captures keys before they can reach zellij. **Workaround**: Press `q` to quit yazi, then use Ctrl+hjkl to navigate. Regular hjkl (without Ctrl) still works for yazi navigation.

## Implementation notes

- Zellij uses KDL (KDL Document Language) for configuration
- Config location: `~/.config/zellij/config.kdl`
- vim-zellij-navigator uses `zellij action list-clients` to detect neovim
- First time each direction is pressed may flash (known Zellij limitation)
- Works perfectly in Ghostty and other terminals
- WezTerm has bugs with vim-zellij-navigator (use WezTerm's native panes instead)

## Troubleshooting

### vim-zellij-navigator not working in WezTerm
- This is a known WezTerm-specific bug
- Solution: Use WezTerm's native pane system instead
- Works perfectly in Ghostty and other terminals

### Navigation not working from neovim to zellij
- Verify you're not in a neovim split (try closing all splits)
- Check if you're at the edge of the neovim window
- Ensure vim-zellij-navigator plugin is loaded (check zellij logs)
- Try `Alt+g` to enter lock mode, then `Alt+g` again to exit (resets state)

### Plugin not downloading
- Check zellij logs: `zellij setup --check`
- Ensure plugin URL is correct in config.kdl
- First-time use may have brief flash while plugin loads

### Session management
- Ensure `linger = true` is set in NixOS user config for session persistence
- Sessions automatically detach when terminal closes (instead of dying)
- Use `zellij list-sessions` to see all sessions
- Use `zellij delete-session <name>` to clean up old sessions

## Research sources

- [Zellij Keybindings Documentation](https://zellij.dev/documentation/keybindings.html)
- [Zellij Default Config (KDL)](https://github.com/zellij-org/zellij/blob/main/zellij-utils/assets/config/default.kdl)
- [vim-zellij-navigator Plugin](https://github.com/hiasr/vim-zellij-navigator)
- [smart-splits.nvim with Zellij Support](https://github.com/mrjones2014/smart-splits.nvim)
- [Zellij Themes Documentation](https://zellij.dev/documentation/themes.html)
