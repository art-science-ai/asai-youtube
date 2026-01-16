# AI Collaboration Guide

This vault is optimized for collaboration with AI assistants like Claude Code. The structured approach and YAML schemas make it easy for AI to understand and work with your knowledge base.

## Essential Context for AI Sessions

When working with Claude Code, always provide these key files as context:

1. **@CLAUDE.md** - Core guidance for AI assistants working in this vault
2. **@README.md** - This file with workflow and structure information
3. **@97-Config/note-schemas.yaml** - Schema definitions for all note types

For specific tasks, also include:
- Relevant template files from `9-system/templates/`
- Example notes of the type you're working with
- Any existing notes that need modification

## Common AI Workflows

### Creating New Notes
```
Help me create a new [person/meeting/source/project/concept] note about [topic].
Use the appropriate template and follow the schema in 97-Config/note-schemas.yaml.
```

### Processing Inbox Items
```
Help me process the items in 0-inbox/. For each valuable item, create a properly 
structured note in 2-permanent/ using the appropriate template and schema.
```

### Connecting Related Notes
```
Review this note and suggest connections to other notes in the vault. 
Add appropriate [[wikilinks]] in both the content and YAML frontmatter.
```

### Schema Validation
```
Check all notes of type [person/meeting/etc] against the schema in 
97-Config/note-schemas.yaml and fix any inconsistencies.
```

### Batch Operations
```
Find all notes of type [X] and update them to include [new property/link/tag].
Ensure changes follow the schema in 97-Config/note-schemas.yaml.
```

### Content Analysis
```
Analyze my notes about [topic] and create a concept note that synthesizes 
the key insights. Link to all relevant source notes.
```

## Best Practices for AI Collaboration

1. **Always reference schemas**: Direct AI to use `97-Config/note-schemas.yaml` for structure
2. **Maintain linking**: Emphasize the importance of `[[wikilinks]]` for connections
3. **Preserve folder structure**: Keep the organized folder system intact
4. **Follow templates**: Use existing templates in `9-system/templates/` as starting points
5. **Update incrementally**: Make changes that build on the existing system rather than replacing it
6. **Validate changes**: Ask AI to verify schema compliance after modifications
7. **Maintain consistency**: Ensure new content matches existing style and structure

## Git Integration Notes

This vault uses automatic git backups via the obsidian-git plugin. When collaborating with AI:
- Changes are auto-committed every 10 minutes with timestamp
- Review git history to track AI-assisted changes
- Use meaningful commit messages for manual commits when needed
- Consider creating separate branches for experimental AI-generated content

## Troubleshooting Common Issues

### Schema Violations
If AI creates notes that don't match the schema:
```
Check this note against the schema in 97-Config/note-schemas.yaml and fix any issues.
```

### Missing Links
If notes lack proper connections:
```
Review this note and suggest relevant [[wikilinks]] based on existing vault content.
```

### Template Issues
If templates aren't being followed:
```
Use the template from 9-system/templates/[type].md and ensure all required fields are included.
```