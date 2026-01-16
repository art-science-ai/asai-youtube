# Graduate Workflow

Move a mature lab project to production (41-public or 42-private) and set up subtree.

## Execute

### 1. Identify Project

Determine:
- Lab project directory: `40-code/43-lab/project-name/`
- Target visibility: **public** (41-public) or **private** (42-private)
- GitHub repo name

### 2. Create GitHub Repository

**For public projects**:
```bash
gh repo create project-name --public
```

**For private projects**:
```bash
gh repo create project-name --private
```

Note the repository URL: `https://github.com/username/project-name.git`

### 3. Move to Production

```bash
# Move to target directory
mv 40-code/43-lab/project-name 40-code/41-public/project-name
# OR for private:
mv 40-code/43-lab/project-name 40-code/42-private/project-name
```

### 4. Add Subtree Remote

```bash
cd /home/nikhilmaddirala/repos/monorepo
git remote add remote-projectname https://github.com/username/project-name.git
```

### 5. Initialize Subtree

```bash
git subtree add --prefix=40-code/41-public/project-name remote-projectname main --squash
# OR for private:
git subtree add --prefix=40-code/42-private/project-name remote-projectname main --squash
```

### 6. Initial Commit

```bash
git add 40-code/41-public/project-name/
git commit -m "feat(project-name): add project to monorepo"
```

### 7. Verify

```bash
# Check directory moved
ls -la 40-code/41-public/project-name/

# Check remote added
git remote -v | grep remote-projectname

# Check git status
git status

# Verify no files left in lab
ls 40-code/43-lab/ | grep project-name
# Should return empty
```

**Success criteria**:
- Project exists in target directory (41-public or 42-private)
- Remote configured for subtree
- Subtree initialized with commit
- No files remain in 40-code/43-lab/project-name/

## Edge Cases

**Repo already exists on GitHub**: Skip step 2, go directly to step 3

**Subtree add fails with "prefix already exists"**: Directory wasn't empty, check for leftover files

**Need to cancel graduation**:
```bash
# Move back to lab
mv 40-code/41-public/project-name 40-code/43-lab/project-name
git remote remove remote-projectname
```
