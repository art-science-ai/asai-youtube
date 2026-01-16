---
description: Process captured content from inbox and journals into organized notes following vault standards
---

# Inbox Processor Workflow

## Overview

This workflow processes captured content from inbox and journals into organized notes following vault standards and methodologies. It should be used when users have captured content that needs to be processed, organized, and integrated into the PARA and Zettelkasten systems. Commands and agents should reference this workflow directly and follow the process exactly as written.

## Context

- **User provides**: Content to process (file paths, text content, or specific notes)
- **Workflow validates**: Inbox/journal structure, existing notes, and vault organization
- **Workflow creates**: Organized notes with proper metadata and linking structure
- **Vault structure**: Follows numbered folder system (00-01 capture, 02-03 execute)

## Process

### 1. Identify and validate content sources

- Locate inbox/journal content in capture folder (00-01/*)
- Validate content is in markdown format with proper structure
- Check for existing processed versions to avoid duplication
- Identify content type (raw notes, links, tasks, ideas)

### 2. Extract and categorize content

- Parse markdown content for key elements:
  - Task items and action items
  - Ideas and concepts
  - Links and references
  - Raw notes and observations
- Categorize content by:
  - Content type (task, idea, note, reference)
  - Priority level (high, medium, low)
  - Due dates (if applicable)
  - PARA classification (project, area, resource, archive)

### 3. Create destination notes

- For **Tasks**: Create/organize in appropriate PARA context
  - High priority: Projects folder (02-03/01-projects)
  - Medium priority: Areas folder (02-03/02-areas)
  - Low priority: Resources folder (02-03/03-resources)
- For **Ideas**: Create Zettelkasten atomic notes
  - Place in 02-03/04-zettelkasten folder
  - Assign unique identifiers and proper metadata
- For **References**: Create source notes
  - Place in 02-03/05-references folder
  - Add source-* metadata (URL, type, title)
- For **Raw Notes**: Process into actionable items or archive
  - Convert to Zettelkasten notes if valuable
  - Archive in 02-03/06-archive if not immediately useful

### 4. Apply metadata and linking

- Add appropriate global-* metadata:
  - `global-created`: Current date
  - `global-type`: Content type (task, idea, note, reference)
  - `global-modified`: Current timestamp
- Add specific metadata based on content type:
  - Tasks: `para-status`, `para-type`, due dates
  - Ideas: `idea-confidence`, `idea-claim`
  - References: `source-url`, `source-type`
- Establish bidirectional links:
  - Link tasks to related projects/areas
  - Link ideas to source content and related concepts
  - Link references to original context

### 5. Clean up and validate

- Move processed content from inbox to appropriate folders
- Remove duplicate or obsolete entries
- Validate all links and metadata
- Update inbox status tracking
- Commit changes to git with descriptive message

## Guidelines

- **Preserve original content** - Never delete source material, only reorganize
- **Follow metadata namespaces** - Use global-*, zettel-*, source-*, idea-*, para-* consistently
- **Maintain link integrity** - Validate all internal links after processing
- **Support incremental processing** - Process content in batches as needed
- **Resist over-processing** - Some content may be better left unprocessed initially
- **Use absolute paths** for all file operations to ensure accuracy
- **Provide clear feedback** about what was processed and where

## Final Review

Verify that the inbox processing workflow completed successfully:

- [ ] All identified content sources located and validated
- [ ] Content properly categorized and extracted
- [ ] Destination notes created in appropriate folders
- [ ] Metadata applied correctly following namespace conventions
- [ ] Links established bidirectionally where appropriate
- [ ] Inbox cleaned up and status updated
- [ ] Changes committed with descriptive message
- [ ] No link breakages or metadata conflicts introduced
- [ ] Process respects existing vault organization and methodology