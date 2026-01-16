---
description: Classify and prioritize tasks across PARA system and Zettelkasten with status tracking
---

# Task Triage Workflow

## Overview

This workflow classifies and prioritizes tasks across the PARA system and Zettelkasten with comprehensive status tracking. It should be used when users need to organize and prioritize their task backlog, review task status, and maintain effective task management across their knowledge system. Commands and agents should reference this workflow directly and follow the process exactly as written.

## Context

- **User provides**: Task triage criteria (timeframe, priority, context)
- **Workflow analyzes**: Existing tasks across vault, current status, and relationships
- **Workflow creates**: Prioritized task lists and status updates
- **Integration**: Works with tasknotes plugin and para-status metadata

## Process

### 1. Scan for existing tasks

- Search through vault for task-containing notes:
  - PARA projects (02-03/01-projects/*)
  - PARA areas (02-03/02-areas/*)
  - Resources (02-03/03-resources/*)
  - Zettelkasten (02-03/04-zettelkasten/*)
- Extract task items using regex patterns:
  - `- [ ]` for incomplete tasks
  - `- [x]` for completed tasks
  - `- [-]` for in-progress tasks
- Collect existing para-status and zettel-status metadata
- Identify task relationships and dependencies

### 2. Categorize tasks by urgency and importance

**Urgency Analysis:**
- High urgency: Due dates within 7 days, blocking tasks
- Medium urgency: Due dates within 30 days, important milestones
- Low urgency: Due dates beyond 30 days, nice-to-have items
- No urgency: Open-ended tasks, research items

**Importance Analysis:**
- High importance: Strategic projects, critical areas, core resources
- Medium importance: Regular operations, maintenance, learning
- Low importance: Administrative tasks, cleanup, nice-to-haves

**Classification Matrix:**
1. **High-Urgency/High-Importance**: Critical path tasks (immediate attention)
2. **High-Urgency/Low-Importance**: Interruption tasks (schedule time)
3. **Low-Urgency/High-Importance**: Strategic tasks (schedule time)
4. **Low-Urgency/Low-Importance**: Background tasks (delegate, postpone, or eliminate)

### 3. Apply PARA system classification

- **Projects**: Tasks with clear end goals and deliverables
  - Assign para-type: "project"
  - Track project milestones and dependencies
  - Update para-status: "planning" → "active" → "complete"
- **Areas**: Tasks supporting ongoing life/work domains
  - Assign para-type: "area"
  - Track recurring and maintenance tasks
  - Update para-status: "active" (ongoing), "archived" (no longer relevant)
- **Resources**: Tasks related to knowledge and tool maintenance
  - Assign para-type: "resource"
  - Track learning, research, and tool optimization
  - Update para-status: "active" → "archived" (when complete)
- **Archives**: Tasks related to completed or obsolete activities
  - Assign para-type: "archive"
  - Move to archive folder with completion status
  - Update para-status: "complete" or "archived"

### 4. Update task metadata and status

- Add task-specific metadata:
  - `task-priority`: high, medium, low
  - `task-urgency`: urgent, standard, low
  - `task-due`: due date (YYYY-MM-DD format)
  - `task-context`: work, personal, learning, etc.
- Update existing metadata:
  - `para-status`: Update based on task progress
  - `zettel-status`: For knowledge-related tasks
  - `global-modified`: Track last update
- Establish task relationships:
  - Link tasks to parent projects/areas
  - Connect dependent tasks
  - Link supporting resources and references

### 5. Generate prioritized task lists

- Create focused task views:
  - **Today's Focus**: Critical path tasks
  - **This Week**: High-urgency items
  - **This Month**: Important strategic tasks
  - **Backlog**: Lower priority items for future planning
- Export task lists in appropriate formats:
  - Checklists for daily planning
  - Reports for weekly reviews
  - Summaries for quarterly planning
- Update task tracking systems:
  - Integrate with tasknotes plugin
  - Update task status dashboard
  - Prepare for review cycles

## Guidelines

- **Maintain task context** - Keep tasks connected to their purpose and relationships
- **Use consistent prioritization** - Apply urgency/importance matrix consistently
- **Support review cycles** - Enable daily, weekly, monthly, and quarterly reviews
- **Track metadata accurately** - Update status and priority metadata consistently
- **Avoid over-categorization** - Some tasks may naturally span multiple categories
- **Preserve existing structure** - Work within current vault organization when possible
- **Use absolute paths** for all file operations to ensure accuracy
- **Provide clear visibility** into task status and priorities

## Final Review

Verify that the task triage workflow completed successfully:

- [ ] All tasks located and analyzed across vault
- [ ] Tasks properly categorized by urgency and importance
- [ ] PARA system classification applied correctly
- [ ] Metadata updated consistently across all task notes
- [ ] Task relationships established and documented
- [ ] Prioritized task lists generated for different timeframes
- [ ] Task tracking systems updated and integrated
- [ ] No metadata conflicts or duplications introduced
- [ ] Process supports established review cycles
- [ ] All changes preserved with proper version control