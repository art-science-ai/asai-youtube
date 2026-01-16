# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is an Obsidian vault configured as a personal knowledge management system following a structured note-taking approach. The vault uses YAML frontmatter schemas and templates to maintain consistency across different note types.

## Core Architecture

### Folder Structure
- `0-inbox/`: Temporary holding area for unprocessed information
- `1-daily/`: Daily notes, journals, and logs  
- `2-permanent/`: Core vault content with structured, processed notes
- `3-bases/`: Database-like views and hubs for the vault
- `8-attachments/`: Non-note files (images, PDFs, etc.)
- `9-system/templates/`: Note templates for the Templater plugin
- `97-Config/`: Configuration files including note schemas

### Note Schema System
The vault uses a strict YAML frontmatter schema defined in `97-Config/note-schemas.yaml`. All notes must follow one of these types:
- **person**: Contact information and relationships
- **meeting**: Meeting notes with attendees and project links
- **source**: Books, articles, videos with reading status
- **project**: Project management with status tracking
- **concept**: Atomic ideas for Zettelkasten-style linking

### Templates
Templates are stored in `9-system/templates/` and correspond to each note type. They contain the required YAML frontmatter structure.

## Obsidian Configuration

### Enabled Plugins
- **obsidian-git**: Automatic vault backup with 10-minute intervals
- **terminal**: Terminal access within Obsidian

### Git Integration
The vault uses obsidian-git plugin with:
- Auto-commit every 10 minutes with message format: "vault backup: YYYY-MM-DD HH:mm:ss"
- Pull before push enabled
- Status bar integration

## Working with This Vault

### Creating New Notes
1. Always use the appropriate template from `9-system/templates/`
2. Ensure YAML frontmatter matches the schema in `97-Config/note-schemas.yaml`
3. Place processed notes in `2-permanent/` folder
4. Use `[[wikilinks]]` for connecting related notes

### File Modification Guidelines
- Preserve existing YAML frontmatter structure
- Maintain the folder organization system
- Respect the schema definitions when editing note properties
- Use proper linking syntax for relationships between notes

### Schema Validation
When editing notes, reference `97-Config/note-schemas.yaml` for:
- Required vs optional properties
- Proper data types (string, date, list, link)
- Valid status values for each note type