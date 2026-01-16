# Status Workflow

Quick git overview with subtree status.

## Execute

### 1. Basic Status

```bash
git status
git log --oneline -5
git remote -v
git branch -vv
```

### 2. Changed Directories

```bash
# Show changes grouped by directory
git status --short | cut -d/ -f1-3 | sort -u
```

### 3. Subtree Sync Check

For each detected subtree remote:
```bash
# Check unpushed commits
git log --oneline remote-name/main..HEAD -- 40-code/directory-name/

# Check incoming commits
git log --oneline HEAD..remote-name/main -- 40-code/directory-name/
```

### 4. Present Summary

Keep it brief:
- Branch and sync status (one line)
- Changed files grouped by directory
- Subtree remotes detected (list only names)

**Action prompt:**
- If there are staged or unstaged changes: "Run `/monorepo-git commit` to commit these changes"
- If working directory is clean but ahead of origin: "Run `/monorepo-git push` to push commits"
- Otherwise: "Working directory clean ✓"

### 5. Verify Completeness

**Success criteria**:
- All git commands executed successfully
- All detected remotes checked for sync status
- Action prompt provided to user

If information is incomplete (e.g., can't determine if a remote is a subtree), ask user for clarification.
