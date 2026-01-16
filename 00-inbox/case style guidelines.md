---
created: 2025-10-24
type: reference
tags:
  - style-guide
  - conventions
---

## Overview

This guide defines casing conventions for Obsidian notes, configuration files, and code. Quick reference:

- **snake_case**: Obsidian frontmatter properties, YAML/TOML/JSON keys, Python variables
- **kebab-case**: File names, folder names, URLs, CSS classes
- **Title case**: Markdown headers (only first word capitalized)
- **camelCase**: JavaScript/TypeScript variables and functions
- **PascalCase**: Classes, types, and components

## Obsidian and markdown files

### Frontmatter properties

Use **snake_case** for all YAML frontmatter property keys.

**Why**: Snake case is the standard for YAML keys and is highly readable for multi-word properties. It's also consistent with Python conventions if you process these files programmatically.

**Examples**:
- `created_date`
- `last_modified`
- `source_url`
- `author_name`

### File names

Use **kebab-case** for all markdown file names.

**Why**: Hyphens work universally across operating systems, don't require escaping in URLs or terminals, and are standard for web-friendly naming.

**Examples**:
- `case-style-guidelines.md`
- `project-setup-notes.md`
- `meeting-notes-2025-10.md`

### Folder names

Use **kebab-case** for folder names.

**Why**: Consistency with file naming and avoids spaces that can cause issues in command-line tools.

**Examples**:
- `00-inbox/`
- `project-planning/`
- `reference-docs/`

### Headers

Use **Title case** where only the first word is capitalized.

**Why**: This is cleaner and more readable than capitalizing every word. It's also faster to write.

**Examples**:
- `## Overview`
- `## Project timeline and milestones`
- `## Appendix`

**Not**: ~~Project Timeline And Milestones~~

## Configuration files

### Keys and properties

Use **snake_case** for keys in YAML, TOML, and JSON files.

**Why**: Most configuration file ecosystems use snake_case as the standard (Python, Ruby, etc.). It's readable and avoids special character issues.

**Examples**:

```yaml
# YAML
database_host: localhost
max_connections: 100
retry_timeout: 30
```

```toml
# TOML
[database]
connection_string = "..."
max_pool_size = 10
```

```json
{
  "api_key": "...",
  "base_url": "https://example.com",
  "timeout_seconds": 30
}
```

### File names

Use **kebab-case** for configuration file names.

**Why**: Standard convention across most ecosystems and avoids ambiguity.

**Examples**:
- `config.yaml`
- `database-config.toml`
- `api-settings.json`
- `.prettierrc`

## Code snippets and examples

When including code in your notes or writing actual code:

### Variables and functions

- **JavaScript/TypeScript**: Use **camelCase**
  - `const userName = "..."`
  - `function calculateTotal() { }`

- **Python**: Use **snake_case**
  - `user_name = "..."`
  - `def calculate_total():`

### Classes and types

Use **PascalCase** across all languages.

**Why**: This is the universal convention for class names and makes them visually distinct from variables.

**Examples**:
- `class UserProfile { }`
- `type DatabaseConfig = { }`
- `class ConfigurationManager:`

### Constants

Use **SCREAMING_SNAKE_CASE** for constants.

**Why**: Makes constants immediately recognizable and prevents accidental modification.

**Examples**:
- `const MAX_RETRY_ATTEMPTS = 3`
- `API_BASE_URL = "https://api.example.com"`

## Appendix

### Edge cases and special situations

**Multi-word acronyms**: Treat as single words
- Good: `apiKey`, `ApiClient`, `api-config.json`
- Avoid: `aPIKey`, `APIClient`

**Numbers in names**: Attach directly without separators
- Good: `version2`, `config-v2.yaml`, `attempt_3`
- Avoid: `version_2` (in camelCase contexts), `config-v-2.yaml`

**Private properties** (in code): Prefix with underscore
- `_internalState`
- `_cache`

**When mixing conventions**: Maintain consistency within each context
- A single YAML file should use all snake_case keys
- A single codebase should pick one convention per language
- Don't mix `user_name` and `userName` in the same file
