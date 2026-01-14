# Themes Configuration

Unified visual and color configuration for both Darwin (macOS) and Linux using Stylix, Catppuccin, custom fonts, and document tools.

## Architecture

The module integrates four systems:
- **Stylix** - Manages color schemes and applies them system-wide to supported programs
- **Catppuccin** - Provides theme support for specific applications
- **Custom fonts** - Installs and configures fonts across platforms
- **Document tools** - TexLive, Pandoc, and Typst for document generation

## Adding New Fonts

Edit the `let` block in `colors-fonts.nix` to define new font variables:

```nix
let
  myCustomFont = pkgs.my-awesome-font;
  myFonts = with pkgs; [
    myCustomFont
    # ... other fonts
  ];
```

Then update the stylix fonts configuration:

```nix
fonts = {
  monospace = {
    package = myCustomFont;
    name = "My Awesome Font";
  };
  # ...
};
```

## Setting Color Schemes

Stylix uses Base16 YAML themes. Change the color scheme by updating the `base16Scheme` path:

```nix
stylix = {
  base16Scheme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
  # Available flavors: macchiato (dark), mocha (dark), latte (light), frappe (light)
};
```

For light theme, use the `specialisation.light` configuration:

```nix
specialisation.light.configuration = {
  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
    polarity = "light";
  };
};
```

## Using TexLive with Catppuccin

The module includes a custom TexLive environment with Catppuccin palette support (configured in `docs.nix`):

```nix
myTexlive = pkgs.texlive.combine {
  inherit (pkgs.texlive) scheme-small catppuccinpalette;
};
```

To add more TeX packages, extend the inherit clause:

```nix
myTexlive = pkgs.texlive.combine {
  inherit (pkgs.texlive) scheme-small catppuccinpalette beamer tikz;
};
```

Available schemes: `scheme-minimal`, `scheme-small`, `scheme-medium`, `scheme-full`

## Converting Markdown to PDF with Catppuccin

Two methods are supported for markdown-to-PDF conversion:

**Pandoc + LaTeX** (xelatex + catppuccinpalette):
```bash
pandoc -d pdf-latex input.md -o output.pdf
```

**Pandoc + Typst** (modern typesetter):
```bash
pandoc -d pdf-typst input.md -o output.pdf
```

### How It Works

Templates and defaults files are installed to `~/.local/share/pandoc/`:

- **`pdf-latex.yaml`** - Pandoc defaults file that configures xelatex engine, loads catppuccinpalette with latte flavor, and applies accent colors to headings (blue, mauve, maroon)
- **`pdf-typst.yaml`** - Pandoc defaults file that configures typst engine and references the typst template
- **`catppuccin.typ`** - Typst template that imports and applies the official @preview/catppuccin package with latte flavor

Both default to latte (light) theme with proper heading hierarchy. Customize by editing the defaults files or passing pandoc options (e.g., `pandoc -M title="My Doc"`).

## Platform Notes

- **fontconfig** is enabled for compatibility with both Darwin and Linux
- Stylix automatically applies colors to supported terminals and CLI tools
- Catppuccin flavors sync across enabled programs (yazi, bat, fish)
