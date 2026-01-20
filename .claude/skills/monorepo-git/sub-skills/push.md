---
description: Push to monorepo and detected subtrees in correct order
---

# Push

## Overview

This sub-skill pushes commits to the monorepo and then to any detected subtree remotes. It ensures correct push order: monorepo first, then subtrees.


## Context

User wants to push committed changes. The sub-skill detects which subtrees have changes and pushes to their remotes.


## Process

### 1. Pre-push check

```bash
git status
```

If uncommitted changes exist: Stop and ask user to commit first (run commit sub-skill).

### 2. Push monorepo

```bash
git push origin main
```

If rejected (remote has new commits):
```bash
git pull --rebase origin main
# Resolve conflicts if any
git push origin main
```

### 3. Detect subtree remotes

```bash
git remote -v
```

Identify which remotes correspond to directories with changes:
- Look for naming pattern: `remote-*` typically indicates subtree remotes
- Map remotes to directories (e.g., `remote-project-a` -> `40-code/project-a/`)

Find changed directories:
```bash
git log --oneline origin/main..HEAD --name-only | grep "40-code/" | cut -d/ -f1-2 | sort -u
```

### 4. Push subtrees

For each changed directory that has a subtree remote:

IMPORTANT: Use ONLY `git subtree push`. Do NOT use `git subtree split` + `git push`.

```bash
git subtree push --prefix=40-code/directory-name remote-name main
```

Concrete example (if directory is `40-code/42-private/piyush-nikhil/` and remote is `remote-piyush-nikhil`):
```bash
git subtree push --prefix=40-code/42-private/piyush-nikhil remote-piyush-nikhil main
```

Before pushing, check for conflicts:
```bash
git fetch remote-name main
git log --oneline remote-name/main..HEAD -- 40-code/directory-name/
```

If remote has new commits: Ask user if they want to pull first:
```bash
git subtree pull --prefix=40-code/directory-name remote-name main --squash
```

If push fails with "creates a split": No changes for this subtree, skip it.

### 5. Verify

```bash
git status
git log --oneline -3 origin/main
```

Success criteria:
- `git status` shows: "Your branch is up-to-date with 'origin/main'"
- No local commits pending push to monorepo
- All subtrees with changes pushed successfully

If verification fails, identify which push failed and retry.


## Guidelines

- Always push monorepo before subtrees
- Use `git subtree push` directly, never `git push` with split command substitution
- If subtree remote not found, ask user to add it or confirm the remote name
- If divergent subtree history, pull first, resolve conflicts, then push
- No subtree remotes is normal - only monorepo push needed
