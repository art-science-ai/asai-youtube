# AGENTS.md - Agent Guidelines for Monorepo

This document provides comprehensive guidelines for AI agents working in this unified monorepo that combines knowledge management (PARA/Zettelkasten) with code projects across multiple technologies and lifecycle stages.

## Repository Structure

### Monorepo Architecture
- **Root**: `/home/nikhilmaddirala/repos/monorepo/` - Unified workspace (also an Obsidian vault)
- **Knowledge**: `00-inbox/`, `10-journals/`, `20-zettel/`, `30-para/` - PARA method with Zettelkasten
- **Code**: `40-code/` organized by lifecycle stage:
  - `41-public/` - Production open-source projects (Git Subtree managed)
  - `42-private/` - Mature private tools & NixOS config
  - `43-lab/` - Scratchpad & experiments (Syncthing synced, no Git)
  - `44-clients/` - Client work & freelance projects
  - `49-archive/` - Inactive/deprecated projects

### Key Philosophy
- **Unified Context**: Code and knowledge co-located for comprehensive AI agent context
- **Git Subtree**: Public repos shared via subtree (monorepo is source of truth)
- **Syncthing**: Cross-machine sync for lab directory (not Git tracked)

### Important: System Configuration
The `40-code/42-private/dragonix/` directory contains the entire system configuration for all systems using NixOS, including home-manager configurations and system-specific settings.

## Build/Test Commands

Refer to the README.md in the relevant project directory to understand build/test commands for that specific project.

## Code Style Guidelines

Refer to the README.md in the relevant project directory for code style guidelines and conventions.

## Testing Guidelines

Refer to the README.md in the relevant project directory for testing guidelines and conventions.

## Commit Message Conventions

Follow conventional commit format:
```
type(scope): description

[optional body]

[optional footer]
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `style`: Code style changes
- `refactor`: Code refactoring
- `test`: Testing
- `chore`: Maintenance

**Scopes:** Use project/directory names (e.g., `feat(dir-index):`, `fix(website):`)

## Project Lifecycle

### Lab → Production Migration
1. **Development**: Work in `43-lab/` with rapid iteration
2. **Maturation**: When stable, move to appropriate production directory
3. **Public projects**: Move to `41-public/` and set up Git Subtree
4. **Private projects**: Move to `42-private/`
5. **Archiving**: Move completed projects to `49-archive/`

### Git Subtree Workflow
```bash
# Push to public repo
git subtree push --prefix=40-code/41-public/project-name remote-project-name main

# Pull from public repo
git subtree pull --prefix=40-code/41-public/project-name remote-project-name main --squash
```

## Reference

This AGENTS.md file should be updated as new technologies, patterns, or projects are added to the monorepo. Always check existing project structures for current conventions before starting new work.</content>
<parameter name="filePath">/home/nikhilmaddirala/repos/monorepo/AGENTS.md
