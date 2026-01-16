---
name: obsidian-vault-automation
description: Expertise for automating Obsidian vault operations following PARA and Zettelkasten methodologies
---

# Obsidian Vault Automation Skill

## Overview

This skill provides expertise for automating personal knowledge management operations in Obsidian vaults following PARA and Zettelkasten methodologies. This skill should be used when users need to process content, manage tasks, extract web resources, and maintain their knowledge management workflows. Commands and agents should reference this skill to execute vault-specific automation workflows that align with established capture-process-execute-review cycles.

## Workflows

Use the appropriate workflow from the `workflows/` directory:

- **inbox-processor.md**: For processing captured content from inbox and journals into organized notes
- **task-triage.md**: For classifying and prioritizing tasks across PARA system and Zettelkasten
- **web-content-extractor.md**: For creating source notes from URLs (YouTube, web articles, research content)
- **template-validator.md**: For validating note compliance with templates and metadata standards

## Resources

- **scripts/**: Use for file operations, metadata extraction, and vault maintenance tasks
- **references/**: Load when understanding vault structure, PARA relationships, or Zettelkasten conventions
- **assets/**: Use in output when generating template examples or workflow documentation

## Guidelines

Follow these general guidelines when executing any workflow in this skill:

- **Always preserve existing vault structure** - automation should enhance, not replace established organization
- **Maintain metadata consistency** - follow global-*, zettel-*, source-*, idea-*, para-* property namespaces
- **Support multiple AI interfaces** - ensure workflows work with Claude Code, Gemini CLI, and Opencode
- **Validate before modification** - check for existing notes, conflicts, and proper formatting
- **Use absolute paths** for vault operations to ensure accuracy

## Additional Information

This section can contain any additional domain-specific information needed for the skill, such as:
- Domain concepts and terminology
- Integration patterns with other plugins
- Best practices and conventions
- Architecture patterns
- Troubleshooting guidance
- Examples and use cases

### Vault Architecture and Terminology

**PARA System Properties:**
- `para-status`: Current status (active, planning, complete, archived)
- `para-type`: Project, Area, Resource, or Archive
- `para-relationships`: Links to related PARA items

**Zettelkasten Properties:**
- `zettel-status`: Processing status (raw, processed, synthesized)
- `zettel-sources`: Links to source notes
- `zettel-related`: Links to related ideas and concepts

**Source Note Properties:**
- `source-url`: Original URL content was extracted from
- `source-type`: YouTube, Article, Research, etc.
- `source-title`: Original title of source content

**Idea Note Properties:**
- `idea-claim`: Core claim or thesis
- `idea-confidence`: Confidence level in the idea (1-5)
- `idea-evidence`: Links to supporting evidence

### Integration Patterns

**With Obsidian Plugins:**
- Leverage `obsidian-git` for automated version control
- Use `obsidian-advanced-uri` for enhanced linking
- Integrate with `tasknotes` for task management
- Support `obsidian-local-rest-api` for programmatic access

**With AI Interfaces:**
- Claude Code: Primary interface for complex workflows
- Gemini CLI: Alternative for web research tasks
- Opencode: Additional processing capability

**Version Control Integration:**
- Maintain existing commit format: `vault backup: YYYY-MM-DD HH:mm:ss`
- Preserve auto-commit functionality
- Support pull-before-push workflow

### Best Practices

**Content Processing:**
- Process inbox content within 24 hours of capture
- Maintain source note integrity with original attribution
- Follow numbered folder system (00-01 capture, 02-03 execute, 08-09 system)

**Task Management:**
- Regular status reviews (daily, weekly, monthly, quarterly)
- Maintain clear separation between capture and execute phases
- Use appropriate status flags for different note types

**Link Management:**
- Validate all internal links during processing
- Maintain bidirectional linking where appropriate
- Use consistent link formatting across all note types

### Troubleshooting Guidance

**Common Issues:**
- **Property conflicts**: Check for duplicate property names across namespaces
- **Link breaking**: Validate links after file moves or renames
- **Metadata loss**: Preserve existing properties when updating notes
- **Template violations**: Use template-validator workflow to identify compliance issues

**Recovery Procedures:**
- Use git history to restore accidentally modified notes
- Maintain backup copies of critical templates
- Document successful automation patterns for future reference