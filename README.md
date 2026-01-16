# Unified Monorepo: Technical & Knowledge Architecture

A unified workspace integrating Git Subtree for public code, Syncthing for cross-machine mirroring, and PARA/Zettelkasten for knowledge management.

## Overview

### Philosophy

Unified Context, Distributed Storage - Provide AI Agents with comprehensive context of digital life (Notes + Infrastructure + Active Code) while maintaining strict collaborator isolation. By treating the monorepo as the vault:

- Code and knowledge are co-located, not isolated
- Direct links from Zettels to specific code files
- AI agents have comprehensive context (notes + infrastructure + active code)
- Single workspace eliminates context switching
- PARA structure organizes knowledge by actionable goals
- Git Subtree enables public collaboration while keeping monorepo clean
 
### Requirements

- Single workspace: `~/monorepo/` contains everything (code + knowledge)
- Projects incubate in lab code directory, graduate to public or private code directories
- Git Subtree for public collaboration (public code directory)
- Syncthing for cross-machine sync
- PARA + Zettelkasten for knowledge organization
- AI agents run from `~/monorepo` with full context

### Key Components

- **Monorepo root**: `~/monorepo/` - Single workspace (opened as Obsidian Vault)
- **Code**: Public repos shared via Git Subtree, private mature tools & NixOS config, scratchpad & experiments (incubation)
- **Knowledge**: PARA folders (Projects, Areas, Resources, Archives), Zettelkasten, Journals
- **Sync**: Syncthing for cross-machine mirroring, Git for version control


## Architecture

### Directory Structure

```
~/monorepo/
├── .git/                          # Unified history for all notes and code
├── .obsidian/                     # Vault settings
├── 00-inbox/                      # New inputs & raw thoughts
├── 10-journals/                   # Periodic notes (daily, weekly, monthly)
├── 20-zettel/                     # Atomic notes & conceptual insights
├── 30-para/                       # Knowledge by actionable goals
│   ├── 31-projects/              # Active goals (links to code + deadlines)
│   ├── 32-areas/                 # Long-term responsibilities (Finance, Health)
│   ├── 33-resources/             # TOPIC HUBS (Web Scraping, NixOS, AI)
│   └── 34-archives/              # Inactive notes/projects
├── 40-code/                       # All code repositories
│   ├── 41-public/                # PUBLIC: Repos shared via Git Subtree
│   ├── 42-private/               # PRIVATE: Mature tools & NixOS config
│   └── 43-lab/                   # LOCAL: Scratchpad & experiments (incubation)
├── 50-misc/                       # Miscellaneous notes/files
└── 60-assets/                     # Attachments, images, PDFs, templates
```

### Git Subtree Architecture

The monorepo is the primary repo. For public collaboration, specific folders are split out to standalone repositories using Git Subtree.

**Key concepts:**
- Monorepo is the source of truth
- Subtree splits code to standalone GitHub repos for external collaboration
- Squashed history keeps monorepo clean
- Normal Git workflow for collaborators on standalone repos

**Detailed setup and workflows:** See [Code Architecture](40-code/README.md#git-strategy)

### Knowledge Architecture: PARA & Zettelkasten

Hub-and-spoke model prevents organizational friction.

| Component | Role | Example Path |
|-----------|------|--------------|
| Project Note | Actionable Goal | `<projects-dir>/Launch Scraper.md` |
| Resource Note | Topic Hub (The Map) | `<resources-dir>/Web Scraping.md` |
| Zettel | Atomic Insight | `<zettel-dir>/Anti-bot detection logic.md` |

**How they connect:**

- Project Notes link to Code and relevant Zettels
- Resource Notes act as MOCs (Map of Content), listing all Zettels related to that topic
- Zettels are flat and atomic; discovered via Resource Hubs



## Workflows

### Project Lifecycle

Projects flow through three stages:

1. **Incubation** (`lab/`) - Early development with rapid iteration
2. **Production** (`public/` or `private/`) - Mature projects with Git history
3. **Archive** (`archive/`) - Preserved but inactive projects

**Detailed workflows:** See [Code Architecture](40-code/README.md) for complete documentation on:
- Starting new projects in the lab
- Graduating projects to production
- Git Subtree setup and management
- Project lifecycle management

### AI Context Sessions

Run agents from `~/monorepo` to give them full access to code and knowledge:

```bash
cd ~/monorepo
claude "Look at my project note in 30-para/31-projects and refactor the auth logic in 40-code/41-public/my-app"
```

Agents have comprehensive context (notes + infrastructure + active code) without context switching.

### Cross-Machine Sync with Mutagen

**Using Mutagen instead of Syncthing** for cross-machine synchronization.

**Configuration:** See [mutagen.yml](mutagen.yml)

**Current status:** Manual sync only
- Start sync manually: `mutagen create` (first time) or `mutagen sync`
- Stop sync manually: `mutagen terminate`
- Monitor sync: `mutagen list`
- Not yet automated with systemd/service on startup

**Golden Rule**

Avoid running Git commands on two machines at the exact same time. Save/Close Machine A before opening Machine B.

## Setup & Migration

### Migration Progress

- [x] Foundation - Monorepo structure, Git repo, NixOS config migrated
- [x] Git Subtree Integration - Added 3 private subtrees (piyush-nikhil, obsidian vaults)
- [ ] Automate Mutagen sync with systemd/service
- [ ] Knowledge Migration - Organize notes into PARA structure and create resource hubs

### Future Improvements

**Automate Mutagen**

Create a systemd service to automatically start Mutagen sync.

**CouchDB for real-time sync** (Optional, if Mutagen proves insufficient)

- Use CouchDB LiveSync plugin for real-time sync across all machines
- Configure exclusions for heavy folders (`.git/`, build artifacts)
- Enables simultaneous multi-machine editing
- Trade-off: Plugin designed for documents, may be slower with large codebases

**Evaluate migration when:**
- Need for simultaneous multi-machine editing emerges
- Current serialized workflow becomes a bottleneck
- Team collaboration patterns change
