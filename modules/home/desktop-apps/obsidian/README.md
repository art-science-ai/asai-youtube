# Obsidian Configuration

Declarative home-manager configuration for Obsidian markdown editor with plugins and themes.

## Files

- `obsidian.nix` - Main configuration module
- `.obsidian-desktop/` - Complete Obsidian configuration directory
  - `plugins/` - All installed plugins with their configurations
  - `themes/` - Custom themes (AnuPpuccin, Catppuccin)
  - `snippets/` - Custom CSS snippets
  - Various config files (app.json, appearance.json, etc.)

## Configuration

### Obsidian Directory Management
- `.obsidian-desktop/` is linked using `mkOutOfStoreSymlink` from module
- Located at: `~/.config/obsidian/obsidian-desktop` → `/home/nikhilmaddirala/repos/nix-config/modules/home/obsidian/.obsidian-desktop`
- Allows Obsidian to modify plugins, settings, and themes freely
- Preserves all existing configuration and customizations

### XDG Compliance
- Uses XDG Base Directory specification
- Configuration placed in `~/.config/obsidian/`
- Compatible with Obsidian's default config location expectations

## Included Components

### Plugins
- **Productivity**: Advanced URI, Heading Shifter, Outliner
- **Navigation**: Git integration, Excalidraw
- **Appearance**: Style Settings, Zoom, VimRC support
- **Workflow**: Task Notes, Periodic Notes, Terminal
- **Search**: Settings Search, Omnisearch integration
- **Visual**: Custom themes, color schemes, table editor

### Themes
- **AnuPpuccin**: Custom theme variant
- **Catppuccin**: Popular dark theme integration

### Customizations
- CSS snippets for link colors and styling
- Vim configuration for Obsidian integration
- Custom workflow configurations

## Usage

Enable this module by importing it in your home-manager configuration:

```nix
imports = [ <nix-config>/modules/home/obsidian ];
```

Or enable via main home-manager configuration:

```nix
imports = [
  <nix-config>/modules/home/base.nix
  <nix-config>/modules/home/obsidian
  # ... other modules
];
```

## Migration Benefits

1. **Complete Preservation**: All plugins, themes, and settings maintained
2. **Mutable Configuration**: Obsidian can modify everything freely
3. **Version Control**: Changes tracked in git repository
4. **Clean Management**: Single symlink for entire config directory
5. **XDG Compliance**: Proper configuration directory placement

## Notes

- Plugin configurations and themes are preserved exactly as they were
- Obsidian will have full access to all existing customizations
- Configuration remains mutable for runtime changes
- All file permissions and structure maintained

This provides a complete, declarative approach to Obsidian configuration while maintaining the full flexibility of the original setup.