---
description: CRUD operations for managing Git subtrees (add, list, check status, pull, move, update remote, remove)
---

# Subtree operations

## Overview

This sub-skill provides comprehensive CRUD operations for managing Git subtrees in the monorepo. Subtrees enable selective directory synchronization with external GitHub repositories while keeping the monorepo as the source of truth.


## Context

User wants to manage subtrees: add new ones, list existing ones, check sync status, pull changes from upstream, move directories, update remote URLs, or remove subtrees.


## Process

Route to the appropriate operation section based on user intent:
- "add subtree" -> Create Operations > Add Subtree
- "list subtrees" -> Read Operations > List All Subtrees
- "subtree status" -> Read Operations > Check Subtree Status
- "pull subtree" -> Update Operations > Pull Subtree Changes
- "move subtree" -> Update Operations > Move Subtree Directory
- "update subtree remote" -> Update Operations > Update Subtree Remote URL
- "remove subtree" -> Delete Operations > Remove Subtree

---

## Create operations

### Add subtree

Add an existing GitHub repository as a subtree to the monorepo.

#### Process

1. Identify target

Determine:
- GitHub repository URL (e.g., `https://github.com/username/repo.git`)
- Target directory in monorepo (e.g., `40-code/41-public/repo/` or `40-code/42-private/repo/`)
- Remote name following `remote-*` convention (e.g., `remote-repo`)

2. Add remote

```bash
git remote add remote-name https://github.com/username/repo.git
```

3. Add subtree

```bash
git subtree add --prefix=40-code/directory-name remote-name main --squash
```

If directory already exists: Remove or move it first
```bash
mv existing-directory /tmp/backup
git subtree add --prefix=40-code/directory-name remote-name main --squash
```

4. Verify

```bash
# Check remote added
git remote -v | grep remote-name

# Check directory created
ls -la 40-code/directory-name/

# Check subtree in git log
git log --oneline -1
```

Success criteria:
- Remote appears in `git remote -v`
- Directory exists with code from GitHub repo
- Git log shows subtree add commit

#### Guidelines

- Wrong branch: If repo uses `master` or different branch, replace `main`
- Subtree add fails: Check if directory already exists, remove it and retry
- Authentication required: Verify SSH key or GitHub token has access to repository

---

## Read operations

### List all subtrees

Display all subtree remotes with their directory mappings and sync status.

#### Process

1. Detect subtree remotes

```bash
# Show all remotes (filter for subtree pattern)
git remote -v | grep "remote-"
```

2. Map remotes to directories

```bash
# Get directory paths for each subtree remote
git log --all --grep="git-subtree-dir:" --pretty=format:"%s" | grep -E "git-subtree-dir:|Split "
```

3. Present summary

Format as table:
```
Remote Name         | Directory                      | URL                        | Status
-------------------|--------------------------------|----------------------------|--------
remote-piyush-nikhil| 40-code/42-private/piyush-nikhil| github.com/art-science-ai/...| Need Pull
remote-obsidian-2025| 40-code/42-private/obsidian-2025| github.com/nikhilmaddirala/...| Synced
```

For each subtree, check sync status:
```bash
# Check if subtree has unpushed commits
git log --oneline remote-name/main..HEAD -- 40-code/directory-name/ | wc -l
```

Success criteria:
- All subtree remotes listed with their directories
- Sync status shown for each subtree
- Clear mapping between remote names and directory paths

#### Guidelines

- No subtree remotes found: Inform user no subtrees configured
- Ambiguous mappings: Check commit history for subtree add commits with `git-subtree-dir:` pattern
- Remote not accessible: Skip or show error for that subtree

---

### Check subtree status

Show sync status of a specific subtree compared to its upstream repository.

#### Process

1. Identify subtree

Get directory and remote name from user or auto-detect from `git remote -v`

2. Check unpushed commits

```bash
# Commits in monorepo but not in subtree remote
git log --oneline remote-name/main..HEAD -- 40-code/directory-name/
```

3. Check incoming commits

```bash
# Commits in subtree remote but not in monorepo
git fetch remote-name
git log --oneline HEAD..remote-name/main -- 40-code/directory-name/
```

4. Present status

- If both commands return empty: "Subtree is synced with upstream"
- If unpushed commits exist: "Local changes ahead, push needed"
- If incoming commits exist: "Upstream changes available, pull recommended"
- If both exist: "Diverged history - rebase/pull required"

Success criteria:
- User understands current sync state
- Clear indication of what action is needed (push/pull/both)

#### Guidelines

- Remote not found: Verify remote name with `git remote -v`
- Wrong branch: Replace `main` with actual branch name from remote
- Never synced: No common base commit, may require initial subtree add or rebase

---

## Update operations

### Pull subtree changes

Fetch and merge latest changes from subtree remote into monorepo.

#### Process

1. Fetch remote changes

```bash
git fetch remote-name main
```

2. Check for incoming changes

```bash
git log --oneline HEAD..remote-name/main -- 40-code/directory-name/
```

If no changes, inform user subtree is already up to date.

3. Pull changes

```bash
git subtree pull --prefix=40-code/directory-name remote-name main --squash
```

4. Resolve conflicts (if any)

If conflicts occur:
```bash
# Check conflict files
git status

# Resolve conflicts manually
# Edit conflicted files and remove markers

# Mark as resolved
git add <resolved-files>

# Complete merge
git commit -m "chore(subtree-name): merge upstream changes"
```

5. Verify

```bash
# Check merge commit created
git log --oneline -1

# Verify directory updated
ls -la 40-code/directory-name/

# Confirm sync status
git log --oneline remote-name/main..HEAD -- 40-code/directory-name/
```

Success criteria:
- Merge commit created (or no changes message)
- Directory contains latest changes
- No unresolved conflicts
- Git status shows working tree clean

#### Guidelines

- No changes to pull: Inform user subtree is already up to date
- Merge conflicts: Guide user through conflict resolution step by step
- Divergent history: Recommend rebase strategy or manual resolution
- Fast-forward not possible: Use `--squash` to create merge commit

---

### Move subtree directory

Relocate a subtree to a different directory path within the monorepo.

#### Process

1. Identify current path

```bash
# Find subtree directory from recent commits
git log --all --grep="git-subtree-dir:" --pretty=format:"%s" | grep directory-name
```

2. Verify remote

```bash
# Check remote exists and is accessible
git remote -v | grep remote-name
git fetch remote-name
```

3. Check for uncommitted changes

```bash
git status 40-code/old-directory/
```

If uncommitted changes exist, commit or stash them first.

4. Move directory

```bash
# Use git mv to preserve history
git mv 40-code/old-directory 40-code/new-directory
```

5. Commit move

```bash
git commit -m "chore(subtree-name): move directory from old-path to new-path"
```

6. Verify subtree still works

```bash
# Test subtree push still works (dry-run)
git subtree push --prefix=40-code/new-directory remote-name main --dry-run

# Test subtree pull (dry-run)
git subtree pull --prefix=40-code/new-directory remote-name main --squash --dry-run
```

If dry-run succeeds, the move was successful.

Success criteria:
- Directory moved to new location
- Git history preserved
- Remote still accessible
- Subtree push/pull operations work correctly

#### Guidelines

- Directory not found: Verify current path with `ls -la 40-code/`
- Remote disconnected: Re-add remote before moving
- Uncommitted changes: Must commit or stash before moving
- .gitsubtree file exists: Update prefix mapping if file exists

---

### Update subtree remote URL

Change the GitHub repository URL for an existing subtree.

#### Process

1. Verify current remote

```bash
git remote -v | grep remote-name
```

2. Update remote URL

```bash
git remote set-url remote-name https://github.com/new-username/new-repo.git
```

3. Verify new URL

```bash
git remote -v | grep remote-name
git fetch remote-name
```

4. Test connection

```bash
# Verify remote is accessible
git ls-remote remote-name main
```

5. Verify subtree still works

```bash
# Test push with --dry-run
git subtree push --prefix=40-code/directory-name remote-name main --dry-run

# Test pull with --dry-run
git subtree pull --prefix=40-code/directory-name remote-name main --squash --dry-run
```

Success criteria:
- Remote URL updated successfully
- `git fetch` works without errors
- `git ls-remote` shows repository is accessible
- Subtree operations still function correctly

#### Guidelines

- Authentication required: Verify SSH key or GitHub token has access to new repository
- Repository not found: Verify URL is correct and repository exists
- Branch name changed: Update references from `main` to new branch name
- Need to preserve history: Ensure old commits still reference correctly after URL change

---

## Delete operations

### Remove subtree

Completely remove a subtree from the monorepo including remote and directory.

#### Process

1. Identify subtree components

```bash
# Get remote name and directory
git remote -v | grep remote-name
ls -la 40-code/directory-name/
```

2. SAFETY STEP: Backup directory

```bash
# Create backup before deletion
BACKUP_DIR="/tmp/subtree-backup-$(date +%Y%m%d-%H%M%S)"
cp -r 40-code/directory-name "$BACKUP_DIR"
echo "Backup created at: $BACKUP_DIR"
```

3. SAFETY CONFIRMATION

Ask user:
> "This will permanently remove the subtree '[subtree-name]' from the monorepo. A backup has been created at $BACKUP_DIR. Continue? (yes/no)"

Only proceed if user confirms with "yes" or "y".

4. Remove directory

```bash
# Remove from git tracking
git rm -r 40-code/directory-name/

# Or use rm if not tracked
rm -rf 40-code/directory-name/
```

5. Remove remote

```bash
git remote remove remote-name
```

6. Commit removal

```bash
git commit -m "chore(subtree-name): remove subtree from monorepo"
```

7. Verify removal

```bash
# Check remote removed
git remote -v | grep remote-name
# Should return empty

# Check directory removed
ls 40-code/ | grep directory-name
# Should return empty

# Check git status
git status
```

Success criteria:
- Remote removed from `git remote -v`
- Directory removed from filesystem
- Git status shows clean (no uncommitted changes)
- Backup created at `/tmp/subtree-backup-DATE`

#### Guidelines

- Uncommitted changes: Commit or stash before removal
- Directory not empty: Force removal with `rm -rf`
- Remote not found: Skip remote removal step if already deleted
- Need to restore: Recover from backup in `/tmp/subtree-backup-DATE`

---

## Appendix

### Common mistakes

Using git push instead of git subtree push:
```bash
# WRONG:
git push remote-name main

# CORRECT:
git subtree push --prefix=40-code/directory-name remote-name main
```

Forgetting --squash flag:
```bash
# WRONG:
git subtree pull --prefix=40-code/directory-name remote-name main

# CORRECT:
git subtree pull --prefix=40-code/directory-name remote-name main --squash
```

Why: `--squash` creates a single merge commit instead of importing entire upstream history, keeping git log clean.

### Troubleshooting

- Subtree push fails with "creates a split": No changes to push for this subtree, skip it
- Subtree pull has merge conflicts: See "Pull Subtree Changes" section for conflict resolution
- Remote not found: Verify remote name with `git remote -v`, re-add with `git remote add`
- Directory already exists: Remove existing directory before adding subtree
- Authentication failures: Verify SSH key or use HTTPS URL with personal access token
