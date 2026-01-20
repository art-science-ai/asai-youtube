---
description: Move a mature lab project to production (public/private) with subtree setup
---

# Graduate

## Overview

This sub-skill graduates a mature project from the lab (`43-lab/`) to production (`41-public/` or `42-private/`) and sets up subtree synchronization with a GitHub repository.


## Context

User has a project in `40-code/43-lab/` that is ready for production. They want to move it to the appropriate production directory and set up GitHub sync via subtree.


## Process

### 1. Identify project

Determine:
- Lab project directory: `40-code/43-lab/project-name/`
- Target visibility: public (41-public) or private (42-private)
- GitHub repo name

### 2. Create GitHub repository

For public projects:
```bash
gh repo create project-name --public
```

For private projects:
```bash
gh repo create project-name --private
```

Note the repository URL: `https://github.com/username/project-name.git`

### 3. Move to production

```bash
# Move to target directory
mv 40-code/43-lab/project-name 40-code/41-public/project-name
# OR for private:
mv 40-code/43-lab/project-name 40-code/42-private/project-name
```

### 4. Commit to monorepo

CRITICAL: You must commit the files to the monorepo before setting up the subtree.

```bash
git add 40-code/41-public/project-name/
git commit -m "feat(project-name): graduate project from lab to production"
```

### 5. Add subtree remote

```bash
cd /home/nikhilmaddirala/repos/monorepo
git remote add remote-projectname https://github.com/username/project-name.git
```

### 6. Initialize remote (push)

Since the remote is empty, we use `push` to initialize it with our local content.

```bash
git subtree push --prefix=40-code/41-public/project-name remote-projectname main
# OR for private:
git subtree push --prefix=40-code/42-private/project-name remote-projectname main
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

Success criteria:
- Project exists in target directory (41-public or 42-private)
- Files committed to monorepo
- Remote configured for subtree
- Code pushed to remote GitHub repository
- No files remain in 40-code/43-lab/project-name/


## Guidelines

- Repo already exists on GitHub:
  - If empty: Proceed as normal
  - If it has commits: Skip `gh repo create`. After adding the remote, do NOT push. Instead, move your files aside, run `git subtree add ...`, then move your files back and commit

- Push rejected (non-fast-forward):
  - The remote repo already has history
  - Solution: `git fetch remote-name`, then `git subtree pull ...`, resolve conflicts, then push

- Need to cancel graduation:
  ```bash
  # Undo the monorepo commit (keep changes in working tree)
  git reset HEAD~1

  # Move back to lab
  mv 40-code/41-public/project-name 40-code/43-lab/project-name
  git remote remove remote-projectname
  ```
