---
tags: [software, tool]
status: active
type: library
---

# Git Subtree

> **TL;DR:** Git extension that merges subtrees together and splits repositories into subtrees, allowing you to include a project as a subdirectory of another project.

## Overview
- **Source:** Built into Git core (available in Git 1.7.11+)
- **Category:** Library (Git extension)
- **Key Features:**
    - Include external repository as subdirectory
    - Push/pull changes to/from external repo
    - No separate .git directory or submodule management
    - History squashing to keep monorepo clean
    - Simpler than git submodules for many use cases

## Personal context
- **Why / how I am using:**
    - Managing public projects in apps/ folder within unified monorepo
    - The monorepo is my primary workspace; public apps are split out for collaboration
    - Work primarily in monorepo, push changes to public GitHub repos as needed
    - History squashing (--squash) keeps monorepo history clean and manageable
    - Git Subtree is simpler than git submodules - no nested .git directories to manage
    - Allows public collaboration while keeping monorepo as the main workspace
- **Projects / hosts:**
    - **Primary use:** Monorepo architecture (~/repos/monorepo)
    - **Public apps:** apps/ folder contains projects pushed to GitHub via subtree
    - **Example:** apps/my-public-app synced with https://github.com/username/my-public-app.git

## Setup and configuration
- **Installation:**
    ```bash
    # Git Subtree is built into Git core
    # Verify installation:
    git subtree --help
    ```
- **Configuration:**
    - No config files required
    - No environment variables
    - Remote management: `git remote add` to track external repos
    - Branch naming: Remotes typically named after the app (e.g., remote-app1)

## Workflows & operations
- **Add existing public project to monorepo:**
    ```bash
    # Add the remote once
    git remote add remote-app1 https://github.com/user/app1.git

    # Add as subtree (squash history to keep monorepo clean)
    git subtree add --prefix=apps/app1 remote-app1 main --squash
    ```
- **Push changes from monorepo to public GitHub:**
    ```bash
    # Push changes made in apps/app1 to the remote repo
    git subtree push --prefix=apps/app1 remote-app1 main
    ```
- **Pull updates from remote repo into monorepo:**
    ```bash
    # Pull latest changes from remote repo
    git subtree pull --prefix=apps/app1 remote-app1 main --squash
    ```
- **Graduate project from lab/ to apps/ with subtree:**
    ```bash
    # Move project from lab to apps
    mv ~/monorepo/lab/My-New-Idea ~/monorepo/apps/my-new-idea

    # Create public GitHub repo first (via gh CLI)
    gh repo create my-new-idea --public

    # Set up subtree
    cd ~/monorepo
    git remote add remote-mynewidea https://github.com/username/my-new-idea.git
    git subtree add --prefix=apps/my-new-idea remote-mynewidea main --squash
    ```
- **Migrate existing repo into private/ (keeping history):**
    ```bash
    # For private repos, just move and merge history
    git remote add migrate-temp ~/old/path/to/repo
    git fetch migrate-temp
    git merge --allow-unrelated-histories migrate-temp/main
    mkdir -p private/project-name
    # Move files into subfolder (manually or via git mv), then:
    git remote rm migrate-temp
    ```
- **Common workflow pattern:**
    ```bash
    # Work in monorepo
    cd ~/monorepo

    # Make changes to apps/my-app

    # Commit in monorepo
    git add apps/my-app
    git commit -m "Update my-app"

    # Push to public GitHub
    git subtree push --prefix=apps/my-app remote-my-app main
    ```
- **Checking sync status:**
    ```bash
    # Check uncommitted changes in subtree
    git status 40-code/41-public/carnatic-abc

    # Fetch latest from remote
    git fetch carnatic-abc

    # Check how many commits are ahead (local has commits not pushed)
    git rev-list --count carnatic-abc/main..HEAD

    # Check how many commits are behind (remote has commits not pulled)
    git rev-list --count HEAD..carnatic-abc/main
    ```
- **Local-only files in subtrees:**
    - Files ignored in public repo but tracked in monorepo (e.g., `.env.local`, `config.local.json`)
    - These files exist only in your monorepo commits, never in upstream
    - Subtree pulls won't affect them since they don't exist in public repo
    - Perfect for local configs and secrets that stay private in your monorepo

## Alternatives and related tools
- **Git Submodules:** Nested .git directories, more complex management, require explicit updates. Not using because Subtree is simpler for my use case - I want to work primarily in the monorepo.
- **Git Worktrees:** Multiple working trees from same repo, good for feature branches but not for splitting out public repos. Not suitable for my monorepo architecture.
- **Manual copy-paste:** Simple but loses version control and sync capabilities. Not using because I need git history and collaboration.
- **Monorepo tools (Nx, Turborepo):** Advanced monorepo tooling for JavaScript/TypeScript projects. Overkill for my needs - I just need basic git subtree for public collaboration.

## References
- [Official Git Documentation](https://git-scm.com/docs/git-subtree)
- [About Git Subtree Merges - GitHub Docs](https://docs.github.com/en/get-started/using-git/about-git-subtree-merges)
- [Git Subtree Tutorial](https://medium.com/@v/git-subtrees-a-tutorial-6ff568381844)
- [Git Submodule vs Subtree Cheat Sheet](https://training.github.com/downloads/submodule-vs-subtree-cheat-sheet/)
