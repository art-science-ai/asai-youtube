# Directory Indexer

## What This Is

A lightweight CLI tool that creates and maintains markdown indices for external directories. Each file/directory gets a corresponding markdown file with YAML frontmatter containing auto-populated metadata and a markdown body for personal notes. The tool runs from one location and indexes target directories elsewhere, updating metadata while preserving manual notes on re-runs.

## Core Value

Lightweight and simple - minimal dependencies, clear purpose, easy to maintain.

## Requirements

### Validated

(None yet - ship to validate)

### Active

- [ ] CLI tool that accepts a target directory path as argument
- [ ] Creates markdown index files for each file/directory in target
- [ ] YAML frontmatter contains auto-populated metadata (path, size, modified date, type)
- [ ] Markdown body reserved for manual user notes
- [ ] Index files stored in current working directory (not target directory)
- [ ] Re-running updates metadata while preserving manual notes in markdown body
- [ ] Supports nested directory structures

### Out of Scope

- File content indexing - only metadata and structure, not file contents
- Search/query interface - this is an indexer, not a search tool
- Other output formats - markdown with YAML frontmatter only
- Advanced filtering/exclusion patterns - simple index everything approach

## Context

Personal tool for maintaining notes on files in external directories. The use case involves tracking files, adding context or thoughts about them, and having metadata stay current when the indexer runs again. The separation of index storage (current dir) from target directory means the tool can index read-only or external locations without modifying them.

## Constraints

- **Dependencies**: Few lightweight deps ok - prefer minimal external dependencies
- **Platform**: No specific constraint - Python-based assumed for tooling

## Key Decisions

| Decision | Rationale | Outcome |
|----------|-----------|---------|
| Manual CLI trigger | Simple, explicit, no daemon overhead | — Pending |
| Index storage in current dir | Keeps target directories pristine | — Pending |
| Metadata sync on re-run | Keep metadata current without losing notes | — Pending |
| Markdown + YAML frontmatter | Human-readable, editable, version-controllable | — Pending |

---
*Last updated: 2025-01-12 after initialization*
