# GTD Workflow Implementation Plan

## Overview

This document provides step-by-step instructions for implementing the simplified GTD workflow system in Obsidian.

## Folder Structure

```
vault-root/
├── tasks/                    # All task notes live here
│   ├── inbox/               # New captured tasks (optional subfolder)
│   ├── active/              # Tasks in planning or execution (optional)
│   └── done/                # Completed tasks (optional)
├── templates/               # Obsidian templates
│   └── task-template.md     # Task template
└── views/                   # Dataview queries (optional - can be in dashboard)
    ├── user-dashboard.md    # User views
    └── assistant-dashboard.md  # Assistant views
```

**Note**: The subfolder organization under `tasks/` is optional. You can keep all tasks flat in `/tasks` and rely on status filtering instead.

## Step 1: Create Task Template

Create: `templates/task-template.md`

```markdown
---
title: {{title}}
type: task
status: inbox
task_owner: user
current_assignee: user
priority: p2
created: {{date:YYYY-MM-DD}}
modified: {{date:YYYY-MM-DD}}
deadline:
blocked_from:
blocked_reason:
tags:
  - gtd
---

# {{title}}

## Context


## Plan


## Notes


## Outcome

```

## Step 2: Create User Dashboard

Create: `views/user-dashboard.md`

```markdown
# My Tasks Dashboard

## My Actions
All tasks currently assigned to me:

```dataview
TABLE status, priority, deadline
FROM "tasks"
WHERE current_assignee = "user" AND status != "done"
SORT priority DESC, status ASC
```

## Tasks to Triage
New tasks in inbox:

```dataview
TABLE priority, created
FROM "tasks"
WHERE status = "inbox" AND current_assignee = "user"
SORT created DESC
```

## Plans to Review
Plans waiting for my review:

```dataview
TABLE priority, deadline
FROM "tasks"
WHERE status = "planning" AND current_assignee = "user"
SORT priority DESC, deadline ASC
```

## Deliverables to Review
Completed work waiting for my review:

```dataview
TABLE priority, modified as "Last Modified"
FROM "tasks"
WHERE status = "execution" AND current_assignee = "user"
SORT priority DESC, modified DESC
```

## Recently Completed
Tasks completed in the last 7 days:

```dataview
TABLE modified as "Completed", priority
FROM "tasks"
WHERE status = "done" AND modified >= date(today) - dur(7 days)
SORT modified DESC
```

## Priority Guide
- **p1**: Urgent + Important (do immediately)
- **p2**: Not urgent + Important (schedule time)
- **p3**: Urgent + Not important (delegate/quick)
- **p4**: Neither (defer or drop)
```

## Step 3: Create Assistant Dashboard

Create: `views/assistant-dashboard.md`

```markdown
# Assistant Task Queue

## My Queue
All tasks assigned to me:

```dataview
TABLE status, priority, deadline
FROM "tasks"
WHERE current_assignee = "assistant" AND status != "done"
SORT priority DESC, deadline ASC
```

## Planning Tasks
Tasks where I need to create/revise plans:

```dataview
TABLE priority, task_owner, created
FROM "tasks"
WHERE status = "planning" AND current_assignee = "assistant"
SORT priority DESC, created ASC
```

## Execution Tasks
Tasks where I need to execute/deliver:

```dataview
TABLE priority, deadline
FROM "tasks"
WHERE status = "execution" AND current_assignee = "assistant"
SORT priority DESC, deadline ASC
```

## Blocked Tasks
Tasks blocked across all stages:

```dataview
TABLE blocked_from as "Stage", current_assignee as "Waiting For", blocked_reason
FROM "tasks"
WHERE status = "blocked"
SORT priority DESC
```
```

## Step 4: Create Example Task

Create: `tasks/example-setup-gtd-system.md`

```markdown
---
title: Setup GTD system in Obsidian
type: task
status: execution
task_owner: user
current_assignee: user
priority: p2
created: 2025-01-27
modified: 2025-01-27
deadline:
blocked_from:
blocked_reason:
tags:
  - gtd
  - meta
---

# Setup GTD system in Obsidian

## Context

Setting up the simplified GTD workflow system for user-assistant collaboration. This task tracks the implementation of the system itself.

## Plan

1. Create folder structure (tasks/, templates/, views/)
2. Create task template
3. Create user dashboard with all views
4. Create assistant dashboard
5. Test workflow with this example task
6. Document any issues or improvements

## Notes

Following the implementation plan from `implementation_plan.md`.

Using the simplified 5-status model:
- inbox
- planning
- execution
- blocked
- done

## Outcome

GTD system is fully functional and ready to use for real tasks.
```

## Step 5: Setup Instructions

### Configure Obsidian Template Plugin

1. Open Settings → Core Plugins → Enable "Templates"
2. Settings → Templates → Template folder location: `templates`
3. Optionally set a hotkey for "Insert template"

### Using the System

**To create a new task:**
1. Create a new note in `/tasks` folder
2. Insert the task template
3. Fill in title and context
4. Status will be `inbox` by default
5. Set priority and deadline if known

**To triage a task (User):**
1. Open task in inbox
2. Clarify context and set priority
3. When ready for planning, change `current_assignee: assistant`

**To plan a task (Assistant):**
1. Check "My Queue" in assistant dashboard
2. Fill in the Plan section
3. When done, change `current_assignee: user`

**To review a plan (User):**
1. Check "Plans to Review"
2. Review the plan
3. If approved: change `status: execution`, `current_assignee: assistant`
4. If changes needed: leave status as `planning`, `current_assignee: assistant`, add feedback in Notes

**To execute a task (Assistant):**
1. Check "Execution Tasks"
2. Create deliverables, update Notes section
3. When done, change `current_assignee: user`

**To review deliverables (User):**
1. Check "Deliverables to Review"
2. Review the work
3. If approved: change `status: done`, fill in Outcome
4. If changes needed: leave status as `execution`, `current_assignee: assistant`, add feedback

**To block a task:**
1. Set `status: blocked`
2. Set `blocked_from: [previous-status]` (planning or execution)
3. Set `blocked_reason: [explanation]`
4. Set `current_assignee: user` or `external` as appropriate

**To unblock a task:**
1. Restore `status: [value from blocked_from]`
2. Clear `blocked_from` and `blocked_reason`
3. Set appropriate `current_assignee`

## Step 6: Optional Enhancements

### Subfolder Organization

If you prefer organizing tasks into subfolders by status:

- Move tasks to appropriate subfolder when status changes
- Update view queries to search recursively: `FROM "tasks" AND -"tasks/archive"`

### Keyboard Shortcuts

Set up QuickAdd or Commander plugin shortcuts for:
- Create new task (insert template in /tasks folder)
- Assign to assistant (set current_assignee: assistant)
- Mark done (set status: done)

### Mobile Templates

If using Obsidian mobile, ensure the Templates core plugin is enabled on mobile as well.

### Periodic Review

Create a weekly review note that includes your dashboards to review:
- All active tasks
- Blocked tasks
- Recently completed tasks

## Troubleshooting

**Views show no results:**
- Check that tasks are in `/tasks` folder
- Verify FROM path matches your folder structure
- Ensure frontmatter fields are spelled correctly

**Template not inserting:**
- Verify Templates plugin is enabled
- Check template folder location in settings
- Make sure template file is in correct location

**Dataview not working:**
- Install Dataview community plugin
- Enable it in Settings → Community Plugins
- Refresh views after enabling

## Next Steps

1. Create your first real task using the template
2. Walk through the full workflow (inbox → planning → execution → done)
3. Adjust views and template based on your preferences
4. Consider adding project-level notes that link to task notes
