---
marp: true
theme: catppuccin-mocha
# theme: catppuccin-latte
# theme: catppuccin-frappe
# theme: catppuccin-macchiato
paginate: true
---

# Catppuccin Marp Theme Demo
## Soothing pastel themes for your presentations
By Nikhil Maddirala

---

## Theme Selection

To use a different theme, uncomment the corresponding line in the YAML frontmatter:

```yaml
---
marp: true
theme: catppuccin-mocha      # Darker theme 🍄
# theme: catppuccin-latte      # Light theme 🌻
# theme: catppuccin-frappe    # Medium dark theme 🪴
# theme: catppuccin-macchiato  # Dark theme 🌺
---
```

---

## Typography & Formatting

We support standard Markdown formatting with Catppuccin colors.

- **Bold Text** for emphasis
- *Italic Text* for subtlety
- ~~Strikethrough~~ for deprecated items
- `Inline Code` for technical terms
- [Links](https://github.com/catppuccin) differentiate clearly from text

---

## Lists & Tasks

Perfect for outlining your points.

1. **Ordered List Item 1**
2. **Ordered List Item 2**
   - Unordered Sub-item (Overlay0)
   - Another Sub-item
     1. Deeply nested item
3. **Task Lists:**
   - [x] Completed task (Green check)
   - [ ] Pending task

---

## Tables

Clean tables with distinct headers and borders.

| Feature | Support | Status |
| :--- | :---: | :--- |
| **Colors** | ✅ | Full Palette |
| **Syntax** | ✅ | Highlight.js |
| **Fonts** | ❌ | User defined |
| **Layout** | ❌ | Standard Marp |

---

## Syntax Highlighting: JavaScript

```javascript
/**
 * Greets the user with a Catppuccin flavor.
 * @param {string} flavor - The flavor name
 */
const flavor = "Mocha";
const contrast = 100;

function greet(name) {
  // This is a comment showing Overlay0 color
  if (contrast > 90) {
    console.log(`Hello, ${name}! Enjoy standard ${flavor}.`);
  }
  return true;
}
```

---

## Syntax Highlighting: Rust

Testing types, numbers, and operators.

```rust
// Rust Example
struct Theme {
    name: String,
    dark: bool,
}

fn main() {
    let mocha = Theme {
        name: String::from("Mocha"),
        dark: true,
    };

    let opacity: f32 = 0.95;
    println!("Loading {}... Opacity: {}", mocha.name, opacity);
}
```

---

## Math (KaTeX)

Mathematical equations should blend seamlessly with the text color.

**Euler's Identity:**
$$ e^{i\pi} + 1 = 0 $$

**Gaussian Integral:**
$$ \int_{-\infty}^{\infty} e^{-x^2} dx = \sqrt{\pi} $$

---

## Blockquotes

> "Catppuccin is a community-driven pastel theme that aims to be the middle ground between high and low contrast themes."
>
> — The Catppuccin Team

---

## Thank You! 💜

**Resources:**
- [GitHub Repository](https://github.com/catppuccin/marp)
- [Official Website](https://catppuccin.com)

Made with ❤️ by the Catppuccin community