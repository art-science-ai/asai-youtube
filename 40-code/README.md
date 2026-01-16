# Code Architecture

This directory contains all code repositories organized by their lifecycle stage and visibility.

## Directory Structure

### 41-public

Public open-source projects shared via Git Subtree.

- **Purpose**: Production-ready projects that are open-sourced
- **Collaboration**: External contributors via GitHub
- **Sync**: Git Subtree to standalone GitHub repositories
- **Examples**: CLI tools, libraries, dev utilities

**Workflow:**
```bash
# Push changes to public GitHub
git subtree push --prefix=40-code/41-public/project-name remote-project-name main
```

### 42-private

Private mature tools and NixOS configuration.

- **Purpose**: Production-ready projects kept private
- **Collaboration**: None or limited (personal/private teams)
- **Sync**: Optional Git Subtree or monorepo-only
- **Examples**: NixOS configs, personal tools, sensitive infrastructure

**Contains:**
- NixOS system configuration (`nix-config/`)
- Private tools and scripts
- Infrastructure code

### 43-lab

Scratchpad, experiments, and project incubation.

- **Purpose**: Early-stage development, prototypes, experiments
- **Collaboration**: None (local only)
- **Sync**: Syncthing across machines (not Git)
- **Examples**: New app ideas, proof of concepts, learning projects

**Lifecycle:**
1. Start new projects in `lab/`
2. Develop alongside notes in the same directory
3. When mature, graduate to `public/` or `private/`

**Graduation:**
```bash
# Move to production
mv ~/monorepo/40-code/43-lab/My-Idea ~/monorepo/40-code/41-public/my-idea

# Then set up Git Subtree (see main README)
```

### 44-clients

Client work and freelance projects.

- **Purpose**: Billable work, client projects
- **Collaboration**: Client-specific Git workflows
- **Sync**: Depends on client requirements
- **Examples**: Freelance web apps, client deliverables

**Note:** Structure depends on client Git preferences (subtree, submodule, or separate repos)

### 49-archive

Inactive or deprecated projects.

- **Purpose**: Historical reference, completed projects
- **Collaboration**: None
- **Sync**: Read-only, preserved in monorepo history
- **Examples**: Completed client projects, deprecated tools

## Project Lifecycle

```
lab (incubation)
    ↓ (matures)
    ├─→ public (open-source)
    └─→ private (kept private)
         ↓ (deprecated)
         └─→ archive (preserved)
```

## Git Strategy

### Monorepo First
The monorepo is the primary Git repository. All code changes are tracked here first.

### Subtree for Collaboration
For public (and optionally private) projects:
- Subtree splits code to standalone GitHub repos
- Enables normal Git workflow for external collaborators
- Monorepo remains the source of truth

### Syncthing for Lab
The `lab/` directory is not version-controlled via Git:
- Uses Syncthing for cross-machine sync
- No git commits during early development
- Enables rapid iteration without version control overhead

## Creating New Projects

### 1. Start in Lab

```bash
mkdir -p ~/monorepo/40-code/43-lab/my-new-idea
cd ~/monorepo/40-code/43-lab/my-new-idea
# Start coding...
```

### 2. Graduate to Production

When the project is mature:

**For public projects:**
```bash
# Create GitHub repo
gh repo create my-new-idea --public

# Move to public
mv ~/monorepo/40-code/43-lab/my-new-idea ~/monorepo/40-code/41-public/my-new-idea

# Set up subtree
cd ~/monorepo
git remote add remote-mynewidea https://github.com/username/my-new-idea.git
git subtree add --prefix=40-code/41-public/my-new-idea remote-mynewidea main --squash
```

**For private projects:**
```bash
# Create private GitHub repo (optional)
gh repo create my-new-idea --private

# Move to private
mv ~/monorepo/40-code/43-lab/my-new-idea ~/monorepo/40-code/42-private/my-new-idea

# Set up subtree (optional)
cd ~/monorepo
git remote add remote-mynewidea https://github.com/username/my-new-idea.git
git subtree add --prefix=40-code/42-private/my-new-idea remote-mynewidea main --squash
```

## Related Documentation

- [Main README](../README.md) - Overall monorepo architecture
- [Incubation Workflow](../README.md#incubation-start-a-new-project) - Starting new projects
- [Graduation Workflow](../README.md#graduation-move-to-production) - Moving projects to production
