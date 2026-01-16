---
name: monorepo-git
description: This skill should be used when the user asks to "commit my changes", "push to monorepo", "what's the git status", "commit and push", "push subtrees", or any git operations in this monorepo. Handles intelligent commits, subtree-aware pushes, and comprehensive status overviews.
version: 0.1.0
---

# Monorepo Git Management

Git workflows for the unified monorepo with subtree awareness.

## Unique Aspects of This Repo

**Subtree remotes**: Some directories have corresponding subtree remotes. Detect with `git remote -v`. If a directory has a subtree remote, push changes to it after pushing monorepo.

**Push order**: Always push to monorepo first (`git push origin main`), then push subtrees.

**Conventional commits**: Follow format in AGENTS.md.

## Workflow Routing

Based on user intent and repo state, select the appropriate workflow(s):

### User: "what's the status", "what's changed", "git status"
→ Run **status.md** only

### User: "commit", "commit my changes", "save changes"
→ Run **commit.md**
→ After successful commits, prompt: "Run `/monorepo-git push` to push these changes? (y/n)"

### User: "push", "push to monorepo", "push changes"
→ Check git status first
→ If unstaged/unstaged changes exist, run **commit.md** first
→ Then run **push.md**

### User: "commit and push", "save and push"
→ Run **commit.md**
→ After successful commits, immediately run **push.md**

### User: "push subtrees", "push to [subtree-name]"
→ Run **push.md** directly (skip commit unless there are uncommitted changes)

### User: "add subtree", "add [repo] as subtree"
→ Run **add-subtree.md**

## Workflows

**Daily Operations**:
- **commit.md**: Group by logical changes, aim for 1-3 commits per subtree/group, prompt for push
- **push.md**: Ensure committed first, push monorepo, detect and push subtrees
- **status.md**: Quick overview with subtree sync status

**One-Time Setup**:
- **add-subtree.md**: Add existing GitHub repo as subtree to monorepo
- **graduate.md**: Graduate lab project to production (public/private) with subtree setup
