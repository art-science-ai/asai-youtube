# Push Workflow

Push to monorepo and detected subtrees.

## Execute

### 1. Pre-Push Check

```bash
git status
```

**If uncommitted changes exist**: Stop and ask user to commit first (run commit workflow).

### 2. Push Monorepo

```bash
git push origin main
```

**If rejected** (remote has new commits):
```bash
git pull --rebase origin main
# Resolve conflicts if any
git push origin main
```

### 3. Detect Subtree Remotes

```bash
git remote -v
```

Identify which remotes correspond to directories with changes:
- Look for naming pattern: `remote-*` typically indicates subtree remotes
- Map remotes to directories (e.g., `remote-project-a` → `40-code/project-a/`)

Find changed directories:
```bash
git log --oneline origin/main..HEAD --name-only | grep "40-code/" | cut -d/ -f1-2 | sort -u
```

### 4. Push Subtrees

For each changed directory that has a subtree remote:

```bash
git subtree push --prefix=40-code/directory-name remote-name main
```

**Before pushing**, check for conflicts:
```bash
git fetch remote-name main
git log --oneline remote-name/main..HEAD -- 40-code/directory-name/
```

**If remote has new commits**: Ask user if they want to pull first:
```bash
git subtree pull --prefix=40-code/directory-name remote-name main --squash
```

**If push fails with "creates a split"**: No changes for this subtree, skip it.

### 5. Verify

```bash
git status
git log --oneline -3 origin/main
```

**Success criteria**:
- `git status` shows: "Your branch is up-to-date with 'origin/main'"
- No local commits pending push to monorepo
- All subtrees with changes pushed successfully

If verification fails, identify which push failed and retry.

## Edge Cases

**Subtree remote not found**: Ask user to add it or confirm the remote name

**Divergent subtree history**: Pull first, resolve conflicts, then push

**No subtree remotes**: This is normal - only monorepo push needed
