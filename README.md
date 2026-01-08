# Unified Monorepo: Technical & Knowledge Architecture

A unified workspace integrating Git Subtree for public code, Syncthing for cross-machine mirroring, and PARA/Zettelkasten for knowledge management.

## Overview

### Philosophy

Unified Context, Distributed Storage - Provide AI Agents with comprehensive context of digital life (Notes + Infrastructure + Active Code) while maintaining strict collaborator isolation. By treating the monorepo as the Vault:

- Code and knowledge are co-located, not isolated
- Direct links from Zettels to specific code files
- AI agents have comprehensive context (notes + infrastructure + active code)
- Single workspace eliminates context switching
- PARA structure organizes knowledge by actionable goals
- Git Subtree enables public collaboration while keeping monorepo clean
 
### Requirements

- Single workspace: `~/monorepo/` contains everything (code + knowledge)
- Projects incubate in `lab/`, graduate to `apps/` (public) or `private/` (private)
- Git Subtree for public collaboration (apps/)
- Syncthing for cross-machine sync
- PARA + Zettelkasten for knowledge organization
- AI agents run from `~/monorepo` with full context

### Key Components

- **Monorepo root**: `~/monorepo/` - Single workspace (opened as Obsidian Vault)
- **Code**: `apps/` (public), `private/` (private), `lab/` (scratchpad)
- **Knowledge**: PARA folders (`00_Inbox` through `40_Archives`), `Zettelkasten/`, `notes/`
- **Sync**: Syncthing for cross-machine mirroring, Git for version control


## Architecture

### Directory Structure

```
~/monorepo/
├── .git/                          # Unified history for all notes and code
├── .obsidian/                     # Vault settings
│
│   # --- Code ---
├── apps/                          # PUBLIC: Repos shared via Git Subtree
├── private/                       # PRIVATE: Mature tools & NixOS config
├── lab/                           # LOCAL: Scratchpad & experiments (incubation)
│
│   # --- Knowledge (PARA) ---
├── 00_Inbox/                      # New inputs & raw thoughts
├── 10_Projects/                   # Active goals (links to code + deadlines)
├── 20_Areas/                      # Long-term responsibilities (Finance, Health)
├── 30_Resources/                  # TOPIC HUBS (Web Scraping, NixOS, AI)
├── 40_Archives/                   # Inactive notes/projects
│
│   # --- Knowledge (Zettelkasten) ---
├── Zettelkasten/                  # Atomic notes & conceptual insights
└── notes/                         # Attachments & Daily Notes
```

### Git Subtree Architecture

The monorepo is the primary repo. For public collaboration, specific folders are split out to standalone repositories.

**Adding a public project to apps/**

```bash
# Add the remote once
git remote add remote-app1 https://github.com/user/app1.git

# Add as subtree (squash history to keep monorepo clean)
git subtree add --prefix=apps/app1 remote-app1 main --squash
```

**Pushing changes to public GitHub**

```bash
git subtree push --prefix=apps/app1 remote-app1 main
```

**Migrating a private project to private/**

```bash
git remote add migrate-temp ~/old/path/to/repo
git fetch migrate-temp
git merge --allow-unrelated-histories migrate-temp/main
mkdir -p private/project-name
# Move files into subfolder, then:
git remote rm migrate-temp
```

### Knowledge Architecture: PARA & Zettelkasten

Hub-and-spoke model prevents organizational friction.

| Component | Role | Example |
|-----------|------|---------|
| Project Note | Actionable Goal | `10_Projects/Launch Scraper.md` |
| Resource Note | Topic Hub (The Map) | `30_Resources/Web Scraping.md` |
| Zettel | Atomic Insight | `Zettelkasten/Anti-bot detection logic.md` |

**How they connect:**

- Project Notes link to Code (`[[apps/scraper/README]]`) and relevant Zettels
- Resource Notes act as MOCs (Map of Content), listing all Zettels related to that topic
- Zettels are flat and atomic; discovered via Resource Hubs



## Workflows

### Incubation: Start a New Project

1. Create folder in `lab/My-New-Idea`
2. Write code alongside notes in the same folder
3. Syncs automatically via Syncthing to all machines
4. Benefits: Code + notes in one place during early development

### Graduation: Move to Production

When a project matures or needs collaboration:

**Move to apps/ (public) or private/ (private)**

```bash
mv ~/monorepo/lab/My-New-Idea ~/monorepo/apps/my-new-idea
# OR
mv ~/monorepo/lab/My-New-Idea ~/monorepo/private/my-new-idea
```

**Initialize Git Subtree (for apps/)**

```bash
cd ~/monorepo
git remote add remote-mynewidea https://github.com/username/my-new-idea.git
git subtree add --prefix=apps/my-new-idea remote-mynewidea main --squash
```

**Create reference note in PARA**

Create a note in `10_Projects/` linking to the new project:

```markdown
# My New Idea

**Location:** `apps/my-new-idea`
**Status:** Active Git Repository
**Started:** 2025-01-08

## Overview
Brief description of the project.

## Key Files
- `src/main.ts` - Entry point
- `README.md` - Documentation

## Related Notes
- [[Project Architecture]]
- [[Initial Ideas]]
```

### AI Context Session

Run agents from `~/monorepo`:

```bash
cd ~/monorepo
claude "Look at my project note in 10_Projects and refactor the auth logic in apps/my-new-idea based on those requirements."
```

The agent has full access to code (apps/, private/, lab/) and knowledge (PARA, Zettelkasten).

## Setup & Migration

### Current State

Individual git repos are currently used for each project. No cross-machine sync infrastructure is in place yet.

### Immediate Next Steps: Migrate to Syncthing

**Create monorepo directory**

```bash
mkdir -p ~/monorepo
cd ~/monorepo
git init
gh repo create monorepo --private --source=. --remote=origin
git add .
git commit -m "Initial commit"
git push -u origin main
```

**Configure Syncthing**

1. Install Syncthing
2. Add `~/monorepo` as a shared folder
3. Configure `.stignore`:

```
node_modules/
target/
dist/
.sync-conflict-*
.git/*.lock
.obsidian/workspace.json
```

4. Sync across machines

**Golden Rule**

Avoid running Git commands on two machines at the exact same time. Save/Close Machine A before opening Machine B.

**Role of Git**

Git is for version control and commit history tracking, not for syncing. Push code changes to their respective remotes (GitHub, GitLab) for backup and collaboration.

**Open as Obsidian Vault**

Open `~/monorepo` in Obsidian to work with code + knowledge in one interface.

### Migration Strategy

**Phase 1: Sync Test**

1. Move `nix-config` to `~/monorepo/private/nix-config`
2. Verify Syncthing syncs correctly
3. Confirm system can rebuild from the new path

**Phase 2: Subtree Test**

1. Choose one public project to migrate
2. Move to `~/monorepo/apps/your-app`
3. Set up Git Subtree (see Architecture section)
4. Test subtree push to public GitHub

**Phase 3: Knowledge Migration**

1. Move existing Obsidian vault contents into PARA folders
2. Organize notes: `00_Inbox`, `10_Projects`, `20_Areas`, `30_Resources`, `40_Archives`
3. Create Zettelkasten structure
4. Move attachments to `notes/`

**Phase 4: Gradual Migration**

1. Move existing personal projects to `~/monorepo/private/`
2. Move scratchpad experiments to `~/monorepo/lab/`
3. Gradually establish graduation workflow

### Future Sync Strategies

As workflow needs evolve, consider these hybrid approaches:

**CouchDB for entire monorepo**

- Use CouchDB LiveSync plugin for real-time sync across all machines
- Configure exclusions for heavy folders (`.git/`, build artifacts)
- Enables simultaneous multi-machine editing
- Trade-off: Plugin designed for documents, may be slower with large codebases

**CouchDB for knowledge, Git for code (Most likely)**

- CouchDB for PARA folders, Zettelkasten, notes, lab/ (real-time sync)
- Git push/pull for apps/ and private/ (normal git workflow)
- Clean separation: knowledge syncs continuously, code syncs via commits
- Best for: Real-time knowledge editing, native git workflow for code

**CouchDB for knowledge, Syncthing for code**

- CouchDB for knowledge folders only (PARA, Zettelkasten, notes)
- Syncthing for code folders (apps/, private/, lab/)
- No sync overlap between systems
- Trade-off: Two sync mechanisms to manage

Evaluate migration when:
- Need for simultaneous multi-machine editing emerges
- Current serialized workflow becomes a bottleneck
- Team collaboration patterns change
