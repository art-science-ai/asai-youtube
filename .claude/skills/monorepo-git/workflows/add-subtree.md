# Add Subtree Workflow

Add an existing GitHub repository as a subtree to the monorepo.

## Execute

### 1. Identify Target

Determine:
- GitHub repository URL (e.g., `https://github.com/username/repo.git`)
- Target directory in monorepo (e.g., `40-code/41-public/repo/` or `40-code/42-private/repo/`)
- Remote name (e.g., `remote-repo`)

### 2. Add Remote

```bash
git remote add remote-name https://github.com/username/repo.git
```

### 3. Add Subtree

```bash
git subtree add --prefix=40-code/directory-name remote-name main --squash
```

**If directory already exists**: Remove or move it first
```bash
mv existing-directory /tmp/backup
git subtree add --prefix=40-code/directory-name remote-name main --squash
```

### 4. Verify

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

## Edge Cases

**Wrong branch**: If repo uses `master` or different branch, replace `main` in step 3

**Subtree add fails**: Check if directory already exists, remove it and retry

**Need to remove subtree later**:
```bash
git remote remove remote-name
rm -rf 40-code/directory-name/
```
