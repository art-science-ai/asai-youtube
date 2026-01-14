# Contributing to Nix Dragons Configuration

Welcome to the Nix Dragons Configuration project! This guide is organized around four main contribution workflows:

- **[Creating Issues](#creating-issues)** - Report bugs, request features, or propose improvements
- **[Working on Issues](#working-on-issues)** - Implement changes and submit pull requests
- **[Reviewing PRs](#reviewing-prs)** - Review and approve code changes
- **[Quickfix Workflow](#quickfix-workflow)** - Direct pushes to main for urgent fixes (not recommended)

## Creating Issues

Use the appropriate issue template when reporting bugs or requesting features. The templates guide you through providing the necessary information.

### Issue Guidelines

- Keep issues focused on a single problem or feature
- Break large changes into multiple related issues
- Use clear, descriptive titles
- Link related issues when appropriate

### Set up Development Environment

- **Create a branch** using the naming convention below
- **Set up a worktree** for isolated development

### Branch Naming Convention

- `issue-<number>-<slug>` - For GitHub issues
- `hotfix-<slug>` - For urgent fixes
- `docs-<slug>` - For documentation updates

Examples:

- `issue-12-workflow-standardization`
- `hotfix-seasmoke-container-restart`
- `docs-update-installation-guide`


#### Setting Up Worktrees

```bash
# Create worktree for issue
git worktree add worktrees/issue-12-workflow-standardization

```

## Working on Issues

### Getting Started
- Make sure you are in the git worktree
- Use the gh cli to fetch the issue corresponding to this worktree
- Read and understand the github issue and all comments in detail. If the comments contain any reference links make sure to fetch the contents of those links and understand them.
- **Fetch upstream and rebase** onto the latest main branch
- **Create a draft PR early** to enable collaboration and feedback

```bash
# Switch to worktree
cd worktrees/issue-12-workflow-standardization

# Fetch latest changes and rebase
git fetch origin
git rebase origin/main

# Work on changes...
```
#### Keeping Up to Date

Regularly fetch upstream and rebase your branch:

```bash
git fetch origin
git rebase origin/main
```

This may require intelligent rebasing if there are conflicts. Resolve conflicts carefully and ensure your changes still work after rebasing.

### Commit Message Format

Follow this conventional commit guide for all commits:

```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

#### Types

- `bug`: Bug fix
- `feature`: New feature
- `refactor`: Code refactoring
- `misc`: Documentation, cleanup, other changes

#### Scopes

- `host/<name>`: Host-specific changes (e.g., `host/meleys`, `host/seasmoke`)
- `module/<name>`: Module changes (e.g., `module/traefik`, `module/sops`)
- `home/<area>`: Home Manager changes (e.g., `home/programs`, `home/dotfiles`)
- `docs`: Documentation changes
- `ci`: CI/CD related changes

#### Examples

```
feature(host/seasmoke): add n8n automation service
bug(module/traefik): resolve SSL certificate renewal issue
misc(docs): update installation instructions
refactor(home/programs): consolidate CLI tool configurations
```

### Testing Requirements

Before committing changes:

**Validate Flake**: `nix flake check`

### Continuous Integration

The repository uses a two-stage CI workflow that runs on all pull requests:

#### Stage 1: Fast Validation
Runs on ubuntu-latest to catch simple errors quickly:
- Flake structure validation: `nix flake check --all-systems`
- Code formatting check: `nixfmt --check .`

This stage fails fast if there are basic configuration or formatting issues, saving time before running expensive builds.

#### Stage 2: Build Verification
Runs on both ubuntu-24.04 and macos-14 in parallel after validation passes:
- Builds all system configurations for each platform
  - Linux: seasmoke, vermax (NixOS)
  - macOS: meleys, moondancer (Darwin)
- Builds all home configurations for each platform
  - Linux: 4 home configurations (nikhilmaddirala, tyrion, aegon on seasmoke, nikhilmaddirala on vermax)
  - macOS: 2 home configurations (nikhilmaddirala on meleys and moondancer)

Expected CI time: 10-15 minutes total with warm cache, 30-45 minutes on first run.

All checks must pass before a PR can be merged.

### Code Style Guidelines

#### Nix Code

- Use 2-space indentation
- Prefer explicit attribute names
- Group imports logically
- Comment complex configurations
- Use meaningful variable names

#### File Organization

- Keep modules focused and single-purpose
- Use consistent directory structure
- Place shared configuration in `common/`
- Host-specific overrides in `hosts/<name>/`

## Reviewing PRs

### Before Reviewing

- Ensure the PR is linked to a related issue
- Check that CI is passing and there are no merge conflicts
- Verify the PR description clearly explains the changes

### Review Criteria

- **Code Quality**: Is the code readable, maintainable, and well-structured?
- **Conventions**: Does it follow our naming, commit, and style guidelines?
- **Functionality**: Does it solve the problem described in the issue?
- **Testing**: Are changes properly validated with `nixfmt` and `nix flake check`?
- **Documentation**: Are necessary docs updated? Check especially root docs like README and CONTRIBUTING
- **Security**: Are there any security implications to consider?

### Review Process

1. **Test Locally**: For significant changes, test in your own environment
2. **Provide Constructive Feedback in the comments**: Be specific and helpful in comments
3. **Approve When Ready**: Use GitHub's review system to approve or request changes

### Merging and Cleanup

1. **Merge**: Use squash-merge to maintain clean history
2. **Auto-delete branch**: GitHub should auto-delete the feature branch
3. **Delete worktree**: Remove the local worktree after branch deletion
   ```bash
   git worktree remove worktrees/issue-<num>-<slug>
   ```
4. **Close issue**: Link and close the related issue

## Quickfix Workflow

⚠️ **Not Recommended** - This workflow bypasses our normal review process and should only be used for urgent fixes that can't wait for the full PR process.

### When to Use Quickfix

- Critical production issues that need immediate resolution
- Typo fixes in documentation
- Simple configuration corrections that are blocking others
- Emergency security patches

### Quickfix Process

1. **Ensure you're on latest main**:

   ```bash
   git checkout main
   git pull origin main
   ```

2. **Make minimal changes** - Keep fixes as small and focused as possible

3. **Test thoroughly**:

   ```bash
   nixfmt .
   nix flake check
   ```

4. **Commit with clear message**:

   ```bash
   git add .
   git commit -m "quickfix: brief description of urgent fix"
   ```

5. **Push directly to main**:
   ```bash
   git push origin main
   ```

### Quickfix Guidelines

- Use `quickfix:` prefix in commit messages
- Document the urgency reason in the commit body
- Follow up with a proper issue and discussion if needed
- Notify the team in appropriate channels about the direct push
- Consider creating a retroactive issue to track any follow-up work

---

## Quick Reference

### Common Commands

```bash
# Format code
nixfmt .

# Validate configuration
nix flake check

# Create worktree
git worktree add worktrees/issue-<num>-<slug>

# Fetch and rebase
git fetch origin && git rebase origin/main

# Remove worktree when done
git worktree remove worktrees/issue-<num>-<slug>

# Quickfix workflow
git checkout main && git pull origin main
# make changes, test, then:
git add . && git commit -m "quickfix: description"
git push origin main
```

### Key Links

- [Issue Templates](https://github.com/your-org/nix-config/issues/new/choose)
- [Project Board](https://github.com/your-org/nix-config/projects)
- [CI Status](https://github.com/your-org/nix-config/actions)
