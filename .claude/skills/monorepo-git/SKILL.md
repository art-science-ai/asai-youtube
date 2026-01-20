---
name: monorepo-git
description: This skill should be used when the user asks to "commit my changes", "push to monorepo", "what's the git status", "commit and push", "push subtrees", or any git operations in this monorepo. Handles intelligent commits, subtree-aware pushes, comprehensive status overviews, and full CRUD operations for managing subtrees (add, list, pull, move, update, remove).
---

# Monorepo Git Management

## Overview

This skill manages git operations for the unified monorepo with subtree awareness. It handles the complexity of keeping the monorepo synchronized with multiple external GitHub repositories via git subtree.

The monorepo is always the source of truth. Changes flow outward: commit to monorepo first, then push to subtree remotes.


## Context

User wants to perform git operations in the monorepo. This may be daily operations (commit, push, status) or subtree management (add, remove, sync). The skill routes to the appropriate sub-skill based on user intent.


## Sub-skills

CRITICAL: Load the appropriate sub-skill from `sub-skills/` based on user intent.

- **status.md**: Show git status, changed files, subtree sync state
  - Triggers: "what's the status", "what's changed", "git status"

- **commit.md**: Analyze changes and create logical commits
  - Triggers: "commit", "commit my changes", "save changes"
  - After success, prompt user about pushing

- **push.md**: Push to monorepo and detected subtrees
  - Triggers: "push", "push to monorepo", "push subtrees"
  - If uncommitted changes exist, run commit.md first

- **subtree-operations.md**: CRUD operations for subtree management
  - Triggers: "add subtree", "list subtrees", "pull subtree", "move subtree", "remove subtree"
  - Routes internally to Create/Read/Update/Delete sections

- **graduate.md**: Move lab project to production with subtree setup
  - Triggers: "graduate project", "move to public", "move to production"


## Process

1. Determine user intent from their request
2. Load the appropriate sub-skill
3. Execute sub-skill process


## Resources

- **sub-skills/**: Individual operation workflows


## Guidelines

- NEVER perform destructive git operations like `git reset --hard` or `git push --force`
- NEVER assume user changes should be discarded
- Always push monorepo before subtrees
- Use conventional commit format from AGENTS.md
- For "commit and push" requests, run commit.md then push.md sequentially


## Appendix

### Subtree remotes

Some directories have corresponding subtree remotes. Detect with `git remote -v`. Pattern: `remote-*` indicates subtree remotes.

Example mapping:
- `remote-project-a` → `40-code/41-public/project-a/`
- `remote-my-config` → `40-code/42-private/my-config/`

### Push order

Always push in this order:
1. `git push origin main` (monorepo)
2. `git subtree push --prefix=<dir> <remote> main` (each subtree with changes)

### Conventional commits

Format: `type(scope): description`

Types: feat, fix, docs, style, refactor, test, chore

Scope: Directory or project name (e.g., `feat(project-a):`, `chore(dragonix):`)
