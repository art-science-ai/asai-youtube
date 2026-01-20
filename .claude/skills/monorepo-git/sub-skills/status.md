---
description: Show git status, changed files, and subtree sync state for the monorepo
---

# Status

## Overview

This sub-skill provides a comprehensive git status overview including subtree sync state. It helps users understand what has changed and what actions are needed.


## Context

User wants to see the current state of the repository before committing or pushing.


## Process

### 1. Basic status

```bash
git status
git log --oneline -5
git remote -v
git branch -vv
```

### 2. Changed directories

```bash
# Show changes grouped by directory
git status --short | cut -d/ -f1-3 | sort -u
```

### 3. Subtree sync check

For each detected subtree remote:
```bash
# Check unpushed commits
git log --oneline remote-name/main..HEAD -- 40-code/directory-name/

# Check incoming commits
git log --oneline HEAD..remote-name/main -- 40-code/directory-name/
```

### 4. Present summary

Keep it brief:
- Branch and sync status (one line)
- Changed files grouped by directory
- Subtree remotes detected (list only names)

Action prompt:
- If there are staged or unstaged changes: "Run `/monorepo-git commit` to commit these changes"
- If working directory is clean but ahead of origin: "Run `/monorepo-git push` to push commits"
- Otherwise: "Working directory clean"


## Guidelines

- Keep output brief and actionable
- Always provide a clear next-step prompt
- If information is incomplete (e.g., can't determine if a remote is a subtree), ask user for clarification
