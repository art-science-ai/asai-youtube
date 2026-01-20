---
description: Analyze changes and create logical commits with conventional format
---

# Commit

## Overview

This sub-skill analyzes repository changes and creates logical commits using conventional commit format. It groups changes by feature/fix/topic rather than just by directory.


## Context

User wants to commit changes. This may be a single change or multiple unrelated changes that should be separate commits.


## Process

### 1. Check status

```bash
git status
git diff --stat
git log -5 --oneline
```

### 2. Group changes logically

Group by logical changes, not just by directory. A single directory may have multiple logical commits.

Grouping guidelines:
- Aim for 1-3 commits per subtree (directory with subtree remote)
- Aim for 1-3 commits for all non-subtree changes combined
- Group related changes together (same feature/fix/topic)
- Split unrelated changes within the same directory

Example groupings:
- Root docs + AGENTS.md + .claude/ -> `docs: add project infrastructure`
- `40-code/project-a/` template changes -> `feat(project-a): add user templates`
- `40-code/project-b/` bug fix -> `fix(project-b): resolve auth issue`
- Personal NixOS config -> `chore(dragonix): update window manager settings`

CRITICAL: Present plan BEFORE executing:
1. Analyze changes (read files, check diffs)
2. Show YOUR recommended commit grouping with:
   - Commit message (using conventional format)
   - List of files in that commit
3. Ask: "Does this grouping look good? (y/n)"
4. ONLY AFTER approval, execute git add and git commit

Do NOT run any git add or git commit commands before getting user approval.

### 3. Commit with conventional format

For each logical group:

```bash
git add <files-or-directory>
git commit -m "type(scope): description"
```

Types: feat, fix, docs, style, refactor, test, chore
Scope: Directory or project name
Examples:
- `feat(my-project): add user authentication`
- `fix(nix-config): resolve memory leak`
- `docs: update installation guidelines`

### 4. Verify

```bash
git status
```

Success criteria:
- No staged changes
- No unstaged modifications
- No untracked files that should be committed
- Output shows: "nothing to commit, working tree clean"

If uncommitted changes remain, return to step 2 and group remaining changes.

### 5. Offer push

After committing, ask user:
> "Run `/monorepo-git push` to push these changes?" (y/n)

If yes, run the push sub-skill.


## Guidelines

- Always get user approval before committing
- If pre-commit hook fails, fix issues and create NEW commit (never amend)
- If staged unrelated changes, use `git reset` to unstage, then stage correct files
- Consolidate related changes into fewer commits (aim for 1-3 per subtree/group)
