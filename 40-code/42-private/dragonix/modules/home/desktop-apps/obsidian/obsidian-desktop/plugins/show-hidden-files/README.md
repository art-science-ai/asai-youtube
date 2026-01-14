# Show Hidden Files

Plugin source: https://github.com/polyipseity/obsidian-show-hidden-files

Version: 2.5.0

## Installation

Installed following the manual installation instructions from the plugin's README:
1. Created directory show-hidden-files under .obsidian/plugins
2. Downloaded manifest.json, main.js, and styles.css from the latest release
3. Placed files in the directory (without git submodule)

## Configuration

A `data.json` file has been created with default exclusions to prevent Obsidian from freezing when scanning dot folders with many files:

```json
{
    "showingRules": [
        "+/",
        "-/\\.git(?:\\/|$)/u",
        "-/\\.venv(?:\\/|$)/u",
        "-/node_modules(?:\\/|$)/u",
        "-/\\.DS_Store(?:\\/|$)/u",
        "-/\\.gitignore$/u",
        "-/\\.obsidian[^/]*(?:\\/|$)/u",
        "-/\\.trash(?:\\/|$)/u"
    ]
}
```

This excludes by default:
- .git, .venv, and node_modules folders
- .DS_Store files
- .gitignore files
- .obsidian* directories (including .obsidian, .obsidian-desktop, etc.)
- .trash folders

Add additional patterns for other dot folders with many files if needed.

## Setup

1. Enable the plugin in Obsidian settings
2. Enable "Files & links > Detect all file extensions" in Obsidian settings for proper functionality
