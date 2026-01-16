## 1 Overview
### 1.1 Introduction
This is Nikhil's personal Obsidian "second brain" vault system, combining **PARA** (Projects, Areas, Resources, Archives) methodology with **Zettelkasten** principles for capturing, organizing, and synthesizing knowledge.

### 1.2 PARA System
Modified version of Tiago Forte's PARA system for life/work organization and task management:

- Areas: ongoing responsibilities (organized into three groups based on Maslow's hierarchy)
	- **Self-esteem & actualization**: Career; Learning & creativity
	- **Love & belonging**: Marriage & family; Community; Recreation
	- **Scaffolding**: Physical health; Mental health; Productivity; Wealth; Home
- Projects: temporary goals with deadlines
- Resources: ...
- Archive: ...

More info in [[README - PARA]].

### 1.3 Zettelkasten System
Modified version of the Zettelkasten system for knowledge capture via source notes and atomic ideas to build a web of interconnected knowledge:

- **Source notes**: Capture external content (videos, articles, books) with metadata, AI summaries, and raw content
- **Idea notes**: Atomic, testable claims synthesized from sources with evidence and connections
- **Fleeting notes**: Temporary thoughts to be developed or discarded

Key principle: Optimize for retrieval, not storage. Use keywords and links based on "when would I want to rediscover this?" rather than rigid categorization.

### 1.4 Workflows and automations
- This vault implements a progressive workflow from raw information to synthesized knowledge: Capture → Process → Execute → Review
- **AI and automations**: Use AI and automations to help with processing and preparing notes.

### 1.5 TODO - Initial Setup
- [ ] Finalize File and folder organization section in this readme - clarify high level templates and properties per file/folder
- [ ] Finalize Workflows section in this readme - clarify workflow steps and corresponding state changes in properties (e.g. source note status changed to "drafted"; task status changed to "reviewed", etc.)
- [ ] Create initial set of templates and test initial workflows - start by processing inbox items

---
## 2 File and Folder Organization

### 2.1 Folder Structure and Properties

| **Folder**                            | **Required Properties**                         | **Optional Properties**                                                                                                      | **Purpose**                                |
| ------------------------------------- | ----------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------ |
| `00-inbox/`                           | —                                               | —                                                                                                                            | Temporary holding for captured information |
| `01-journals/daily` / `weekly` / etc. | —                                               | —                                                                                                                            | Daily capture, journaling, work log        |
| `02-zettel/sources/`                  | `source-url`, `source-title`, `zettel-status`   | `source-type`, `source-creators`, `source-platform`, `source-published-date`, `source-fetched-date`, `source-length-minutes` | External content (videos, articles, books) |
| `02-zettel/ideas/`                    | `idea-claim`, `zettel-status`, `zettel-sources` | `idea-confidence`, `idea-scope`, `idea-aliases`                                                                              | Atomic knowledge synthesis with evidence   |
| `02-zettel/fleeting/`                 | —                                               | —                                                                                                                            | Temporary thoughts to develop or discard   |
| `03-para/areas/`                      | `para-category`, `para-vision`                  | `para-projects`, `para-tasks`                                                                                                | Ongoing life/work responsibilities         |
| `03-para/projects/`                   | `para-status`, `para-area`                      | `para-deadline`, `para-success-criteria`, `para-tasks`                                                                       | Goal-oriented work with deadlines          |
| `03-para/tasks/`                      | `para-status`                                   | `para-project`, `para-area`, `para-resources`, `para-due-date`, `para-priority`                                              | Actionable items linked to projects/areas  |
| `03-para/resources/`                  | `para-category`                                 | `para-projects`, `para-areas`                                                                                                | Reference materials and documentation      |
| `03-para/archive/`                    | `para-archived-date`                            | `para-status`                                                                                                                | Completed/inactive projects                |
| `04-misc/`                            | —                                               | (varies)                                                                                                                     | Flexible space for non-standard notes      |
| `08-system/bases/`                    | —                                               | —                                                                                                                            | Dataview queries and aggregated views      |
| `08-system/templates/`                | —                                               | —                                                                                                                            | Note templates for different types         |
| `08-system/assets/`                   | —                                               | —                                                                                                                            | Media files (images, PDFs, etc.)           |
| `09-tmp/`                             | —                                               | (varies)                                                                                                                     | Scratch work, not for long-term storage    |


### 2.2 Property Namespaces

- Obsidian native
	- Obsidian built-in: `tags` `aliases` `cssclasses`
	- File properties for bases: `file.backlinks`, `file.links`, `file.ctime`, etc. [See here](https://help.obsidian.md/bases/syntax#File+properties)
- **`global-*`**: Shared across all types
	- Required: `global-type`
	- Optional - Obsidian built-in: `tags` `aliases` `cssclasses`
- **`zettel-*`**: Zettelkasten shared properties
	- Status: `zettel-status` (for sources and ideas)
	- Relationships: `zettel-sources` (ideas link to sources)
- **`source-*`**: Source-specific metadata (`source-url`, `source-title`, `source-type`, `source-creators`, `source-platform`, `source-published-date`, `source-fetched-date`, `source-length-minutes`)
- **`idea-*`**: Idea-specific properties (`idea-claim`, `idea-confidence`, `idea-scope`, `idea-aliases`)
- **`para-*`**: PARA shared properties (status, relationships, metadata)
	- Status: `para-status` (for all PARA notes: projects, tasks, areas, resources)
	- Relationships: `para-project`, `para-area`, `para-resources`, `para-projects`, `para-tasks`
	- Metadata: `para-category`, `para-vision`, `para-deadline`, `para-success-criteria`, `para-due-date`, `para-priority`, `para-archived-date`

### 2.3 Design Principles

- **Structure vs. Content**: Templates encode patterns. Properties enable queries.
- **Minimal Required**: Only require non-negotiable properties. Everything else optional.
- **Consistency**: Kebab-case with namespace prefixes. Controlled vocabularies for status.
- **Progressive Disclosure**: Required first, optional last. Make deletable elements obvious.
- **Emerge from Practice**: Add structure after 5+ notes reveal patterns.

### 2.4 Conventions
**Folder numbering:** 00-01 (capture) | 02-03 (execute) | 04-07 (misc/reserved) | 08-09 (system/temp)

**Create new folders rarely** — only when you have ≥10 notes of a distinct type with clear boundaries and a defined template/workflow.

**Properties:**
- Names: Lowercase kebab-case with namespace prefix (`global-type`, `source-url`)
- Dates: `YYYY-MM-DD`
- Lists: `["item1", "item2"]`
- Links: `[[Note Title]]`
- Citations: `@ 00:11:23` or `@ p.217`

**File naming:**
- Sources: `creator-name--title-slug.md`
- Daily: `YYYY-MM-DD.md`
- Others: Descriptive title

---

## 3 Workflows

### 3.1 Overview

| **Stage** | **Purpose**                          | **Key Actions**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | **Supporting Views**                                                                                                              |
| --------- | ------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| Capture   | Collect raw inputs                   | - Add to daily notes (no status)<br>- Add to inbox (no status)<br>- Send to inbox from web clipper (no status)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | - Today's daily note                                                                                                              |
| Process   | Classify and enrich                  | - Triage inbox: Move to appropriate folder with template (no status yet)<br>- Triage daily notes: Refactor into individual notes (no status yet)<br>- Enrich source notes with metadata (`zettel-status`: → `drafted`)<br>- Enrich tasks with project/area links (`para-status`: → `todo`)<br>- Enrich ideas with sources and evidence links (no status until reviewed)                                                                                                                                                                                                                                                                                                                                           | - Inbox processing<br>- Inbox by type<br>- Unprocessed sources                                                                    |
| Execute   | Make progress on goals and knowledge | **PARA (tasks/projects):**<br>- Start working on tasks (`para-status`: `todo` → `in-progress`)<br>- Complete tasks (`para-status`: `in-progress` → `completed`)<br>- Update project status and link to areas (`para-status`: maintain `active` or → `completed`)<br>- Create new tasks from projects (`para-status`: → `todo`)<br><br>**Zettelkasten (sources/ideas):**<br>- Review sources and take notes (`zettel-status`: `drafted` → `reviewed`)<br>- Extract ideas from sources (create with no status)<br>- Link evidence with citations (no status change)<br>- Connect related ideas with sideways verbs (no status change)<br>- Complete idea quality bar (`zettel-status`: → `reviewed`)                | - Active tasks<br>- Projects by deadline<br>- Overdue tasks<br>- Unreviewed sources<br>- Orphan ideas<br>- Ideas with few sources |
| Review    | Maintain system health               | **Daily** (5 min): Process daily note (no status), quick inbox items (various statuses), review today's tasks (`para-status`: → `completed` if done)<br>**Weekly** (30 min): Empty inbox (various statuses), review projects (`para-status`: update as needed), prioritize tasks (no status change), extract 1-2 ideas (`zettel-status`: → `reviewed`)<br>**Monthly** (1 hr): Add idea connections (no status), check orphans (no status), review fleeting notes (convert or delete), assess areas (no status)<br>**Quarterly** (2 hrs): Review all areas (no status), archive projects (`para-status`: `completed` → move to archive with `para-archived-date`), prune content (delete), identify knowledge gaps | - Daily/weekly/monthly/quarterly review checklists                                                                                |
| Maintain  | Keep system organized                | - Maintain file/template compliance per folder (no status)<br>- Update READMEs as structure evolves (no status)<br>- Monitor system health metrics (no status)<br>- Find broken symlinks                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | - System health dashboard<br>- Growth metrics<br>- Link density                                                                   |
|           |                                      |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |                                                                                                                                   |

### 3.2 Capture

**Purpose**: Collect raw information as it arrives.

**Locations**:
- **Inbox** (`00-inbox/`) — Fleeting notes, web clipper content, unprocessed information
- **Daily notes** (`01-daily/`) — Journal entries, meeting notes, work log with links to other notes

**Supporting views**:
- Today's daily note

**Status**: No status tracking at this stage.

### 3.3 Process

**Purpose**: Classify inbox items and enrich them with metadata, then move to their final location.

**Decision tree for inbox processing:**
1. **What type of content is this?**
   - Raw thought/idea → Move to `02-zettel/fleeting/`
   - Meeting/journal entry → Move to `01-daily/` or delete if redundant
   - External source (URL, article, video) → Use `web-content-extractor` agent → `02-zettel/sources/`
   - Task → Create in `03-para/tasks/` linked to project/area
   - Reference material → Move to `03-para/resources/`
   - Not useful → Delete

2. **Does it need enrichment?**
   - URLs → Extract with `web-content-extractor` agent
   - Incomplete metadata → Fill in YAML frontmatter
   - Ready → Apply template and move to final location

3. **Does it spark an idea?**
   - Yes → Create idea note in `02-zettel/ideas/`
   - No → Revisit during weekly review

**Goal**: Process inbox regularly (daily or weekly) to keep it empty.

**Supporting views**:
- **Inbox processing**: All notes in `00-inbox/` by `global-created-date` (oldest first)
- **Inbox by type**: Filter inbox by `global-type` or `source-url` presence to batch similar items
- **Unprocessed sources**: Source notes where `zettel-status != "reviewed"`

**Status transitions**:
- Sources created from URLs: — → `drafted` (set `zettel-status` to `drafted`)

### 3.4 Execute: PARA

**Purpose**: Traditional project and task management for getting things done.

**Core concepts**:
- **Tasks** are associated with Projects or Areas
- **Projects** have defined goals, deadlines, and success criteria
- **Areas** are ongoing responsibilities without end dates
- Tasks have a defined lifecycle and status (todo, in-progress, completed)

**Project lifecycle:**
1. Create project note in `03-para/projects/`
2. Define success criteria and deadline
3. Create associated tasks in `03-para/tasks/`
4. Link project to relevant area
5. Track progress during weekly reviews
6. Archive to `03-para/archive/` when complete

**Supporting views**:

*Task management:*
- **Active tasks**: Tasks where `para-status = "todo" OR "in-progress"` grouped by `para-project`
- **Tasks by area**: Tasks grouped by `para-area` for area review
- **Overdue tasks**: Tasks where `para-due-date < today AND para-status != "completed"`
- **Unlinked tasks**: Tasks where `para-project` and `para-area` are both empty
- **This week's tasks**: Tasks where `para-due-date` is within current week

*Project management:*
- **Active projects**: Projects where `para-status = "active"` grouped by `para-area`
- **Projects by deadline**: Active projects sorted by `para-deadline` (upcoming first)
- **Stale projects**: Projects where `global-modified-date < 30 days ago`
- **Projects by area**: All projects grouped by `para-area`

**Status transitions**:
- Tasks: `todo` → `in-progress` → `completed`
- Projects: `active` → `completed` → `archived` (move to `03-para/archive/`)

### 3.5 Execute: Zettelkasten

**Purpose**: Knowledge synthesis through the Zettelkasten method—build a web of interconnected ideas grounded in sources.

**Source notes workflow:**
1. Capture source in inbox (URL, book reference, etc.)
2. Use `web-content-extractor` agent or manual template
3. Extract content and metadata
4. Generate AI notes (TLDR, key ideas, summary, quotes)
5. Add personal observations in user notes section
6. Update `zettel-status` to `reviewed`

**Idea extraction workflow:**
1. Review source notes (especially those marked `reviewed`)
2. Identify testable claims or insights that emerge
3. Ask: "Can I cite ≥2 sources for this claim?"
4. Create idea note using `03-zettel-idea.md` template
5. Write one-sentence scoped claim
6. Link to ≥2 source notes via `zettel-sources` property
7. Add evidence (supports and challenges) with precise citations
8. Link to ≥2 related idea notes using sideways verbs (Refines, Generalizes, Implies, Depends on, Challenges, Supports, Related)
9. Complete quality bar checklist
10. Update `zettel-status` to `reviewed`

**Supporting views**:
- **Unreviewed sources**: Sources where `zettel-status = "drafted" OR "captured"`
- **Sources by type**: All sources grouped by `source-type` (video, article, book)
- **Recent sources**: Sources by `global-created-date` (newest first)
- **Orphan ideas**: Idea notes with no outgoing links or `<2` linked notes
- **Ideas by status**: Ideas grouped by `zettel-status` to track processing pipeline
- **Ideas with few sources**: Ideas where `zettel-sources` count is low
- **Stale fleeting notes**: Fleeting notes where `global-created-date > 30 days ago`

**Status transitions**:
- Sources: `drafted` → `reviewed` (after review and note-taking)
- Ideas: — → `reviewed` (after completing quality bar checklist)

### 3.6 Review

**Purpose**: Regular reviews maintain system health and ensure nothing falls through the cracks.

**Daily Review** (5 minutes, end of day):
- Process daily note: Add links, clean up formatting
- Quick-process inbox items < 2 minutes
- Review tasks for today, mark complete/carry forward

**Weekly Review** (30 minutes):
- Empty inbox (process all notes)
- Review active projects: Update status, create tasks
- Review tasks: Prioritize for next week
- Read 1-2 source notes, extract ideas if ready
- Update PARA area notes if significant changes

**Monthly Review** (1 hour):
- Review all idea notes: Add new connections
- Check for orphan notes (notes with no links)
- Review fleeting notes: Convert to permanent or delete
- Assess PARA areas: Health check against vision
- Update system documentation if workflows changed

**Quarterly Review** (2 hours):
- Review all PARA areas against vision from `03-para/README - PARA.md`
- Archive completed projects
- Prune irrelevant sources/ideas
- Identify knowledge gaps: What topics need more research?
- Reflect on system effectiveness and iterate

**Supporting views**:
- **Daily review checklist**: Today's tasks, inbox count, today's daily note
- **Weekly review checklist**: Inbox count, active projects, unreviewed sources, task summary
- **Monthly review checklist**: Orphan ideas count, fleeting notes count, area health metrics
- **Quarterly review checklist**: All areas with vision/progress, archived projects count, knowledge gap analysis

### 3.7 Health Metrics

**Purpose**: Monitor system effectiveness and growth over time.

**System health dashboard**:
- Inbox count
- Unprocessed sources count (where `zettel-status != "reviewed"`)
- Orphan ideas count
- Overdue tasks count (where `para-due-date < today`)

**Growth metrics**:
- New sources this month (by `global-created-date`)
- New ideas this month
- Completed projects this quarter (by `para-status = "completed"`)

**Link density**:
- Average outgoing links per idea note
- Average sources per idea (`zettel-sources` count)


---

## 4 Configuration, AI, automations
### 4.1 Repo organization
Besides the Obsidian vault structure described above, we also have:
- `.opencode` - Opencode configuration
- `.claude` - Claude code configuration
- `.obsidian-desktop` - Symlink to home obsidian configuration

### 4.2 Obsidian setup
- Core plugins
	- Vim mode
- Plugins
	- Vimrc
	- **obsidian-git**: Auto-commits every 10 minutes with format `vault backup: YYYY-MM-DD HH:mm:ss`
	- **terminal**: Terminal access within Obsidian
	- **obsidian-advanced-uri**: Advanced URI scheme for linking
	- **tasknotes**: Task management integration
	- **darlal-switcher-plus**: Enhanced file switcher
	- **obsidian-excalidraw-plugin**: Drawing and diagrams
	- **obsidian-local-rest-api**: Local REST API for automation
- Version control with Obsidian-git plugin
	- **Auto-commit**: Every 10 minutes
	- **Pull before push**: Enabled
	- **Commit message format**: `vault backup: {{date}}`


### 4.3 Agents: web-content-extractor Agent

Automatically creates complete source notes from URLs (YouTube videos or web articles).

**Usage:**
```bash
# Interactive (within Claude Code)
claude
@web-content-extractor https://youtube.com/watch?v=VIDEO_ID

# Headless
claude -p "use web-content-extractor agent to extract https://youtube.com/..." --dangerously-skip-permissions --verbose
```

**The agent will:**
1. Extract content and metadata (transcripts, article text, etc.)
2. Generate AI summaries (TLDR, key ideas, detailed summary, quotes)
3. Create a complete source note in `02-zettel/sources/`

**Agent location**: `.claude/agents/web-content-extractor.md`

---

*This vault is under active development. Workflows and structure will evolve as the system matures.*
