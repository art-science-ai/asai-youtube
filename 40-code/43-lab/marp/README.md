# Catppuccin for Marp 🌻🪴🌺🍄

A collection of soothing Marp themes following the Catppuccin color palette.

## About

This repository provides Catppuccin-themed styles for Marp, a Markdown-based presentation tool. Each theme corresponds to one of the four Catppuccin flavors:

- **Latte** (🌻) - Light, warm theme
- **Frappé** (🪴) - Medium dark theme  
- **Macchiato** (🌺) - Dark theme
- **Mocha** (🍄) - Darker theme

### Theme Philosophy

These themes follow a **minimal color-only approach**:
- ✅ **Colors only** - No font overrides, margins, or layout changes
- ✅ **Marp compatibility** - Uses standard CSS selectors
- ✅ **User control** - Lets users control their own fonts and spacing
- ✅ **Clean imports** - Follows Marp's theme structure with `@import "default"`

## Usage

Clone this repository and copy the `themes/` directory into your project's `themes/` folder:

```
your-project/
  slides.md
  themes/
    catppuccin-latte.css
    catppuccin-frappe.css
    catppuccin-macchiato.css
    catppuccin-mocha.css
```

Marp automatically loads all themes inside a `themes/` folder, so you can run:

```bash
marp --pdf demos/demo.md -o demos/demo.pdf --theme-set ./themes
marp -p demos/demo.md --theme-set ./themes
```

