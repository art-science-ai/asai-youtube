# GTD Workflow for User + Assistant (Tasks)

## Overview

This workflow describes how a **user** and an **assistant** collaborate on tasks from the moment an idea is captured until it is fully completed.


| Stage            | Status      | Assigned To      | Main Action                                               | Next Stage |
| ---------------- | ----------- | ---------------- | --------------------------------------------------------- | ---------- |
| **1. Inbox**     | `inbox`     | user             | Capture and triage task                                   | Planning   |
| **2. Planning**  | `planning`  | user ↔ assistant | Create plan, review, iterate until approved               | Execution  |
| **3. Execution** | `execution` | user ↔ assistant | Execute plan, review deliverables, iterate until approved | Done       |
| **4. Blocked**   | `blocked`   | user or external | Unblock and return to previous stage                      | (varies)   |
| **5. Done**      | `done`      | -                | Task complete                                             | -          |

**Key Features:**
- **Simple status model**: Only 5 statuses (inbox, planning, execution, blocked, done)
- **Assignment-based handoffs**: `current_assignee` field tracks whose turn it is
- **Feedback loops**: Planning and execution naturally loop between user and assistant
- **Flexible blocking**: Tasks can be blocked at any stage, then resume where they left off
- **Scalable**: Works for individual tasks, projects, and reference notes


## GTD system description


### 2. Roles

- **User**
  - Owns goals and priorities
  - Decides what tasks exist and which ones matter
  - Approves/rejects plans and deliverables
  - Performs any actions that the assistant cannot (e.g. sending real emails, uploading files, accessing private systems)

- **Assistant**
  - Turns tasks into concrete plans
  - Executes as much of the plan as possible
  - Surfaces blockers and required user actions


### 3. Lifecycle at a Glance (Tasks)

**Status progression**: `inbox` → `planning` → `execution` → `done`

**Assignment handoffs** (via `current_assignee` field):
- **Inbox stage**: User captures and triages → assigns to assistant
- **Planning stage**: Assistant plans ↔ User reviews → cycles until approved
- **Execution stage**: Assistant executes ↔ User reviews → cycles until approved
- **Done stage**: Task complete

**Blocking**: At any stage, if work cannot proceed, status changes to `blocked` with `blocked_from` field tracking where to resume.


### 4. Stage-by-Stage Description

#### Stage 1 – Inbox

**Status:** `inbox`
**Assignment:** `current_assignee: user`

**What happens:**
- User creates a new task note with title and initial context
- User triages: confirms it's a task, adds priority and deadline
- User clarifies description so assistant can understand it
- When ready, user assigns to assistant: `current_assignee: assistant`

**Output:** Triaged task ready for planning

---

#### Stage 2 – Planning

**Status:** `planning`
**Assignment:** Cycles between `user` and `assistant`

**What happens:**
1. **Assistant planning** (`current_assignee: assistant`):
   - Creates detailed implementation plan
   - Identifies required inputs and user actions
   - When done, assigns back to user: `current_assignee: user`

2. **User review** (`current_assignee: user`):
   - Reviews the plan
   - Either approves (→ moves to Execution) or requests changes (→ assigns back to assistant)

**Feedback loop:** Planning cycles between assistant and user until approved

**Output:** Approved plan, ready for execution

---

#### Stage 3 – Execution

**Status:** `execution`
**Assignment:** Cycles between `user` and `assistant`

**What happens:**
1. **Assistant execution** (`current_assignee: assistant`):
   - Creates deliverables (code, documents, drafts, etc.)
   - Lists any user actions required
   - When done, assigns back to user: `current_assignee: user`

2. **User review** (`current_assignee: user`):
   - Reviews deliverables
   - Performs any required user actions (send email, upload file, etc.)
   - Either approves (→ moves to Done) or requests changes (→ assigns back to assistant)

**Feedback loop:** Execution cycles between assistant and user until approved

**Output:** Approved deliverables and completed user actions

---

#### Stage 4 – Blocked

**Status:** `blocked`
**Assignment:** Usually `current_assignee: user` or `external`

**What happens:**
- Task cannot proceed due to missing information, access, or external dependency
- `blocked_from` field tracks which stage was interrupted (planning or execution)
- `blocked_reason` explains what's needed
- Once unblocked, task returns to the stage it came from

**Output:** Task resumes at previous stage

---

#### Stage 5 – Done

**Status:** `done`
**Assignment:** None

**What happens:**
- Task is complete
- Outcome is recorded
- Any follow-on work is captured as new tasks

**Output:** Completed task

---

### 5. Generalization to Projects and Notes

This user–assistant workflow for tasks generalizes naturally:

- **Projects**
  - A project note can follow the same stages:
    - Capture → Triage (define as project) → Make plan (assistant drafts project roadmap) → Review plan (user approves) → Execute (assistant and user work through subtasks) → Review deliverables → Close project.
  - Individual tasks under the project then go through their own task lifecycle.

- **Notes (reference)**
  - Capture → Triage as a **note** instead of a task.
  - Assistant can help **organize, summarize, and link** notes as part of the planning/execution for tasks or projects.

By keeping the stages conceptually the same (Capture → Triage → Make plan → Review plan → Execute → Review deliverables → Close), you get a consistent mental model whether you are dealing with a single task, a multi-step project, or a body of notes that support your work.

---

## 6. Implementation in Obsidian

### 6.1. Frontmatter Schema

Each task note uses this minimal frontmatter structure:

```yaml
---
# Core identification
title: "Clear task title"
type: "task"  # task, project, note

# Status and assignment
status: "inbox"  # inbox | planning | execution | blocked | done
task_owner: "user"  # Who owns this task overall
current_assignee: "user"  # Whose turn it is now (user | assistant | external)

# Optional metadata
priority: "p2"  # See priority definitions below
created: "2025-01-27"
modified: "2025-01-27"
deadline: ""  # Optional

# For blocked tasks only
blocked_from: ""  # planning | execution (which stage was interrupted)
blocked_reason: ""  # Why it's blocked

# Tags and organization
tags: ["gtd"]
---
```

**Priority Definitions (Eisenhower Matrix):**
- `p1`: Urgent + Important (do immediately)
- `p2`: Not urgent + Important (schedule time for this)
- `p3`: Urgent + Not important (delegate or do quickly)
- `p4`: Neither urgent nor important (defer or drop)

### 6.2. View Definitions

#### User Views

**1. My Actions** (all tasks waiting for user)
```dataview
TABLE status, priority, deadline
FROM "tasks"
WHERE current_assignee = "user" AND status != "done"
SORT priority DESC, status ASC
```

**2. Tasks to Triage** (inbox tasks)
```dataview
TABLE priority, created
FROM "tasks"
WHERE status = "inbox" AND current_assignee = "user"
SORT created DESC
```

**3. Plans to Review**
```dataview
TABLE priority, deadline
FROM "tasks"
WHERE status = "planning" AND current_assignee = "user"
SORT priority DESC, deadline ASC
```

**4. Deliverables to Review**
```dataview
TABLE priority, modified as "Last Modified"
FROM "tasks"
WHERE status = "execution" AND current_assignee = "user"
SORT priority DESC, modified DESC
```

**5. Recently Completed**
```dataview
TABLE modified as "Completed", priority
FROM "tasks"
WHERE status = "done" AND modified >= date(today) - dur(7 days)
SORT modified DESC
```

#### Assistant Views

**1. My Queue** (all tasks assigned to assistant)
```dataview
TABLE status, priority, deadline
FROM "tasks"
WHERE current_assignee = "assistant" AND status != "done"
SORT priority DESC, deadline ASC
```

**2. Planning Tasks** (specifically in planning)
```dataview
TABLE priority, task_owner, created
FROM "tasks"
WHERE status = "planning" AND current_assignee = "assistant"
SORT priority DESC, created ASC
```

**3. Execution Tasks** (specifically in execution)
```dataview
TABLE priority, deadline
FROM "tasks"
WHERE status = "execution" AND current_assignee = "assistant"
SORT priority DESC, deadline ASC
```

**4. Blocked Tasks** (across all stages)
```dataview
TABLE blocked_from as "Stage", current_assignee as "Waiting For", blocked_reason
FROM "tasks"
WHERE status = "blocked"
SORT priority DESC
```

### 6.3. Template System

#### Task Template

```markdown
---
title: ""
type: "task"
status: "inbox"
task_owner: "user"
current_assignee: "user"
priority: "p2"
created: "{{date}}"
modified: "{{date}}"
deadline: ""
blocked_from: ""
blocked_reason: ""
tags: ["gtd"]
---

# {{title}}

## Context
<!-- Initial request/idea -->

## Plan
<!-- Assistant fills this during planning stage -->

## Notes
<!-- Any additional notes during execution -->

## Outcome
<!-- Final result when completed -->
```

### 6.4. Workflow Transition Rules

**Status transitions:**
- `inbox` → `planning`: User triages and assigns to assistant
- `planning` → `execution`: User approves plan
- `execution` → `done`: User approves deliverables and completes any user actions
- Any status → `blocked`: Task cannot proceed
- `blocked` → previous status: Task is unblocked

**Assignment handoffs:**
- User assigns to assistant by setting `current_assignee: assistant`
- Assistant assigns back to user by setting `current_assignee: user`
- Always update `modified` timestamp when changing status or assignee

**Blocking:**
- When blocking, set `status: blocked`, `blocked_from: [previous-status]`, `blocked_reason: [explanation]`
- When unblocking, restore `status: [blocked_from]` value and clear blocking fields

This simplified system provides clear collaboration patterns while remaining flexible enough for various task types and workflows.
