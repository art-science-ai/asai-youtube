# Subtree Operations Workflow

Comprehensive CRUD operations for managing Git subtrees in the monorepo. Subtrees enable selective directory synchronization with external GitHub repositories while keeping the monorepo as the source of truth.

## Operations Overview

- **Create**: Add new subtrees from GitHub repositories
- **Read**: List subtrees and check sync status
- **Update**: Pull changes, move directories, update remote URLs
- **Delete**: Remove subtrees and clean up remotes

## Quick Reference

| Operation | Description |
|-----------|-------------|
| Add subtree | Create new subtree from remote repo |
| List subtrees | Show all subtree remotes and mappings |
| Check status | Show sync state vs upstream |
| Pull changes | Fetch and merge upstream changes |
| Move subtree | Change directory location |
| Update remote | Change remote repository URL |
| Remove subtree | Delete subtree completely |

---

## Create Operations

### Add Subtree

Add an existing GitHub repository as a subtree to the monorepo.

#### Execute

1. Identify Target

Determine:
- GitHub repository URL (e.g., `https://github.com/username/repo.git`)
- Target directory in monorepo (e.g., `40-code/41-public/repo/` or `40-code/42-private/repo/`)
- Remote name following `remote-*` convention (e.g., `remote-repo`)

2. Add Remote

```bash
git remote add remote-name https://github.com/username/repo.git
```

3. Add Subtree

```bash
git subtree add --prefix=40-code/directory-name remote-name main --squash
```

**If directory already exists**: Remove or move it first
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

**Success criteria**:
- Remote appears in `git remote -v`
- Directory exists with code from GitHub repo
- Git log shows subtree add commit

#### Edge Cases

**Wrong branch**: If repo uses `master` or different branch, replace `main` in step 3

**Subtree add fails**: Check if directory already exists, remove it and retry

**Authentication required**: Verify SSH key or GitHub token has access to repository

---

## Read Operations

### List All Subtrees

Display all subtree remotes with their directory mappings and sync status.

#### Execute

1. Detect Subtree Remotes

```bash
# Show all remotes (filter for subtree pattern)
git remote -v | grep "remote-"
```

2. Map Remotes to Directories

```bash
# Get directory paths for each subtree remote
git log --all --grep="git-subtree-dir:" --pretty=format:"%s" | grep -E "git-subtree-dir:|Split "
```

3. Present Summary

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

**Success criteria**:
- All subtree remotes listed with their directories
- Sync status shown for each subtree
- Clear mapping between remote names and directory paths

#### Edge Cases

**No subtree remotes found**: Inform user no subtrees configured

**Ambiguous mappings**: Check commit history for subtree add commits with `git-subtree-dir:` pattern

**Remote not accessible**: Skip or show error for that subtree

---

### Check Subtree Status

Show sync status of a specific subtree compared to its upstream repository.

#### Execute

1. Identify Subtree

Get directory and remote name from user or auto-detect from `git remote -v`

2. Check Unpushed Commits

```bash
# Commits in monorepo but not in subtree remote
git log --oneline remote-name/main..HEAD -- 40-code/directory-name/
```

3. Check Incoming Commits

```bash
# Commits in subtree remote but not in monorepo
git fetch remote-name
git log --oneline HEAD..remote-name/main -- 40-code/directory-name/
```

4. Present Status

- If both commands return empty: "Subtree is synced with upstream ✓"
- If unpushed commits exist: "Local changes ahead, push needed"
- If incoming commits exist: "Upstream changes available, pull recommended"
- If both exist: "Diverged history - rebase/pull required"

**Success criteria**:
- User understands current sync state
- Clear indication of what action is needed (push/pull/both)

#### Edge Cases

**Remote not found**: Verify remote name with `git remote -v`

**Wrong branch**: Replace `main` with actual branch name from remote

**Never synced**: No common base commit, may require initial subtree add or rebase

---

## Update Operations

### Pull Subtree Changes

Fetch and merge latest changes from subtree remote into monorepo.

#### Execute

1. Fetch Remote Changes

```bash
git fetch remote-name main
```

2. Check for Incoming Changes

```bash
git log --oneline HEAD..remote-name/main -- 40-code/directory-name/
```

If no changes, inform user subtree is already up to date.

3. Pull Changes

```bash
git subtree pull --prefix=40-code/directory-name remote-name main --squash
```

4. Resolve Conflicts (if any)

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

**Success criteria**:
- Merge commit created (or no changes message)
- Directory contains latest changes
- No unresolved conflicts
- Git status shows working tree clean

#### Edge Cases

**No changes to pull**: Inform user subtree is already up to date

**Merge conflicts**: Guide user through conflict resolution step by step

**Divergent history**: Recommend rebase strategy or manual resolution

**Fast-forward not possible**: Use `--squash` to create merge commit

---

### Move Subtree Directory

Relocate a subtree to a different directory path within the monorepo.

#### Execute

1. Identify Current Path

```bash
# Find subtree directory from recent commits
git log --all --grep="git-subtree-dir:" --pretty=format:"%s" | grep directory-name
```

2. Verify Remote

```bash
# Check remote exists and is accessible
git remote -v | grep remote-name
git fetch remote-name
```

3. Check for Uncommitted Changes

```bash
git status 40-code/old-directory/
```

If uncommitted changes exist, commit or stash them first.

4. Move Directory

```bash
# Use git mv to preserve history
git mv 40-code/old-directory 40-code/new-directory
```

5. Commit Move

```bash
git commit -m "chore(subtree-name): move directory from old-path to new-path"
```

6. Verify Subtree Still Works

```bash
# Test subtree push still works (dry-run)
git subtree push --prefix=40-code/new-directory remote-name main --dry-run

# Test subtree pull (dry-run)
git subtree pull --prefix=40-code/new-directory remote-name main --squash --dry-run
```

If dry-run succeeds, the move was successful.

**Success criteria**:
- Directory moved to new location
- Git history preserved
- Remote still accessible
- Subtree push/pull operations work correctly

#### Edge Cases

**Directory not found**: Verify current path with `ls -la 40-code/`

**Remote disconnected**: Re-add remote before moving

**Uncommitted changes**: Must commit or stash before moving

**.gitsubtree file exists**: Update prefix mapping if file exists

---

### Update Subtree Remote URL

Change the GitHub repository URL for an existing subtree.

#### Execute

1. Verify Current Remote

```bash
git remote -v | grep remote-name
```

2. Update Remote URL

```bash
git remote set-url remote-name https://github.com/new-username/new-repo.git
```

3. Verify New URL

```bash
git remote -v | grep remote-name
git fetch remote-name
```

4. Test Connection

```bash
# Verify remote is accessible
git ls-remote remote-name main
```

5. Verify Subtree Still Works

```bash
# Test push with --dry-run
git subtree push --prefix=40-code/directory-name remote-name main --dry-run

# Test pull with --dry-run
git subtree pull --prefix=40-code/directory-name remote-name main --squash --dry-run
```

**Success criteria**:
- Remote URL updated successfully
- `git fetch` works without errors
- `git ls-remote` shows repository is accessible
- Subtree operations still function correctly

#### Edge Cases

**Authentication required**: Verify SSH key or GitHub token has access to new repository

**Repository not found**: Verify URL is correct and repository exists

**Branch name changed**: Update references from `main` to new branch name

**Need to preserve history**: Ensure old commits still reference correctly after URL change

---

## Delete Operations

### Remove Subtree

Completely remove a subtree from the monorepo including remote and directory.

#### Execute

1. Identify Subtree Components

```bash
# Get remote name and directory
git remote -v | grep remote-name
ls -la 40-code/directory-name/
```

2. **SAFETY STEP: Backup Directory**

```bash
# Create backup before deletion
BACKUP_DIR="/tmp/subtree-backup-$(date +%Y%m%d-%H%M%S)"
cp -r 40-code/directory-name "$BACKUP_DIR"
echo "Backup created at: $BACKUP_DIR"
```

3. **SAFETY CONFIRMATION**

Ask user:
> "This will permanently remove the subtree '[subtree-name]' from the monorepo. A backup has been created at $BACKUP_DIR. Continue? (yes/no)"

Only proceed if user confirms with "yes" or "y".

4. Remove Directory

```bash
# Remove from git tracking
git rm -r 40-code/directory-name/

# Or use rm if not tracked
rm -rf 40-code/directory-name/
```

5. Remove Remote

```bash
git remote remove remote-name
```

6. Commit Removal

```bash
git commit -m "chore(subtree-name): remove subtree from monorepo"
```

7. Verify Removal

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

**Success criteria**:
- Remote removed from `git remote -v`
- Directory removed from filesystem
- Git status shows clean (no uncommitted changes)
- Backup created at `/tmp/subtree-backup-DATE`

#### Edge Cases

**Uncommitted changes**: Commit or stash before removal

**Directory not empty**: Force removal with `rm -rf`

**Remote not found**: Skip remote removal step if already deleted

**Need to restore**: Recover from backup in `/tmp/subtree-backup-DATE`

---

## Common Mistakes

### Using git push Instead of git subtree push

**WRONG:**
```bash
git push remote-name main
```

**CORRECT:**
```bash
git subtree push --prefix=40-code/directory-name remote-name main
```

Why: `git subtree push` handles the split and push atomically, ensuring only subtree history is pushed.

### Forgetting --squash Flag

**WRONG:**
```bash
git subtree pull --prefix=40-code/directory-name remote-name main
```

**CORRECT:**
```bash
git subtree pull --prefix=40-code/directory-name remote-name main --squash
```

Why: `--squash` creates a single merge commit instead of importing entire upstream history, keeping git log clean.

### Not Verifying Before Destructive Operations

**ALWAYS** verify before:
- Moving directories: Check remote still works
- Updating remotes: Test connection with `git fetch`
- Removing subtrees: Create backup and confirm with user

### Mixing Subtree and Non-Subtree Changes

When pushing subtrees, ensure only subtree-related commits are included. Use commit grouping to separate subtree changes from other monorepo changes.

---

## Troubleshooting

### Subtree Push Fails with "creates a split"

This means there are no changes to push for this subtree. This is normal - skip pushing this subtree.

### Subtree Pull Has Merge Conflicts

See "Pull Subtree Changes" section for conflict resolution steps.

### Remote Not Found

Verify remote name with `git remote -v`. If missing, re-add with `git remote add`.

### Directory Already Exists

Remove existing directory before adding subtree, or use different prefix path.

### Authentication Failures

- Verify SSH key is added to GitHub account
- Check repository visibility (private repos require proper access)
- Use HTTPS URL with personal access token if SSH fails

### Subtree History Diverged

If local and remote histories have diverged:
```bash
# Fetch remote changes
git fetch remote-name

# Rebase local changes on top of remote
git subtree pull --prefix=40-code/directory-name remote-name main --squash
```

If conflicts occur, resolve them manually before proceeding.
