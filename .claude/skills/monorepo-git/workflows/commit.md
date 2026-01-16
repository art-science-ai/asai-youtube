# Commit Workflow

Analyze changes and create logical commits.

## Execute

### 1. Check Status

```bash
git status
git diff --stat
git log -5 --oneline
```

### 2. Group Changes Logically

Group by logical changes, not just by directory. A single directory may have multiple logical commits.

**Guidelines**:
- Aim for 1-3 commits per subtree (directory with subtree remote)
- Aim for 1-3 commits for all non-subtree changes combined
- Group related changes together (same feature/fix/topic)
- Split unrelated changes within the same directory

**Specific grouping rules**:
- **Project infrastructure** (.claude/, AGENTS.md, root docs) → 1 commit
- **Subtree content** (40-code/42-private/project-a/) → separate commits by logical change
- **Personal config** (dragonix, personal settings) → separate commit OR consider excluding
- **DO NOT mix** project infrastructure with personal config

**Example groupings**:
- Root docs + AGENTS.md + .claude/ → `docs: add project infrastructure`
- `40-code/project-a/` template changes → `feat(project-a): add user templates`
- `40-code/project-b/` bug fix → `fix(project-b): resolve auth issue`
- Personal NixOS config → `chore(dragonix): update window manager settings` (or skip)

**CRITICAL: Present plan BEFORE executing**:
1. Analyze changes (read files, check diffs)
2. Show YOUR recommended commit grouping with:
   - Commit message (using conventional format)
   - List of files in that commit
3. Ask: "Does this grouping look good? (y/n)"
4. ONLY AFTER approval, execute git add and git commit

Do NOT run any git add or git commit commands before getting user approval.

### 3. Commit with Conventional Format

For each logical group, follow format in AGENTS.md:

```bash
git add <files-or-directory>
git commit -m "type(scope): description"
```

**Types**: feat, fix, docs, style, refactor, test, chore
**Scope**: Directory or project name
**Examples**:
- `feat(my-project): add user authentication`
- `fix(nix-config): resolve memory leak`
- `docs: update installation guidelines`

### 4. Verify

```bash
git status
```

**Success criteria**:
- No staged changes
- No unstaged modifications
- No untracked files that should be committed
- Output shows: "nothing to commit, working tree clean"

If uncommitted changes remain, return to step 2 and group remaining changes.

### 5. Offer Push

After committing, ask user:
> "Run `/monorepo-git push` to push these changes?" (y/n)

If yes, run the push workflow.

## Edge Cases

**Pre-commit hook fails**: Fix issues, create NEW commit (never amend)

**Staged unrelated changes**: Use `git reset` to unstage, then stage correct files

**Too many small changes**: Consolidate related changes into fewer commits (aim for 1-3 per subtree/group)
