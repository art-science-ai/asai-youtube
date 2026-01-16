## Context
- Problem
	- I use Obsidian as my primary note taking and personal knowledge management system. I keep my Obsidian vault as a git repo synced to Github
	- I also have many projects synced to Github and each project has it's own documentation in the project repos.
	- I would like to have Obsidian as a central PKM where I can work with documentation across various projects. Ideally I want the documentation to live in both places - in the project repo and in the obsidian repo - while staying in sync so that I can seamlessly make edits while working in any repo.
- Solution: **Using symlinks with projects as source of truth**
	- Documentation lives in project repos (proper collaboration, git history where it belongs)
	- Symlinks in Obsidian vault point to project repo docs
	- Trade-off: Must manually commit from terminal when editing docs via Obsidian (obsidian-git may skip symlinks)
	- Works across machines with consistent directory structure

## Setup and Usage

### Initial Setup for a Project

For each documentation file you want to access from Obsidian:

1. **Create/identify the documentation file in the project repo**
   ```bash
   # Example project structure:
   # /path/to/project-repo/README.md
   # /path/to/project-repo/docs/architecture.md
   # /path/to/project-repo/docs/decisions.md
   ```

2. **Create directory structure in Obsidian vault**
   ```bash
   mkdir -p /Users/nikhilmaddirala/repos/obsidian-2025-07/2-permanent/projects/myproject
   ```

3. **Create symlinks in Obsidian vault pointing to project repo files**
   ```bash
   cd /Users/nikhilmaddirala/repos/obsidian-2025-07/2-permanent/projects/myproject
   ln -s /path/to/project-repo/README.md ./README.md
   ln -s /path/to/project-repo/docs/architecture.md ./architecture.md
   ln -s /path/to/project-repo/docs/decisions.md ./decisions.md
   ```

4. **Verify symlinks work**
   ```bash
   ls -la /Users/nikhilmaddirala/repos/obsidian-2025-07/2-permanent/projects/myproject
   # Should show: README.md -> /path/to/project-repo/README.md
   ```


---

## Appendix: Decision Process

### Requirements

- Primarily personal use (some projects may have collaborators)
- Work seamlessly in both project repos and Obsidian
- Multiple machines (optimize for primary machine)
- Proper git versioning in project repos
- Avoid custom scripts for setup and ongoing operations

### Decision Rationale

**Chosen: Symlinks with projects as source (Option 2)**

Why this works best:
- ✅ Documentation lives where it belongs (project repos) - proper collaboration
- ✅ Git history tracked in project repos
- ✅ Zero friction when editing in project repos (most common workflow)
- ✅ Works across machines with consistent directory structure
- ✅ No custom scripts needed
- ⚠️ Manual commits needed when editing via Obsidian (acceptable trade-off)

**Rejected: Hard links (Option 4)**
- Initially seemed ideal (zero friction in both locations)
- Fatal flaw: Modern editors (VS Code, Neovim, etc.) use "safe write" that breaks hard links
- Creates silent sync failures - worse than obvious limitations
- Would require editor-specific configs to disable safe writes

**Rejected: Git submodules (Option 3)**
- Too complex for the benefit
- Notoriously difficult to manage correctly

**Rejected: Obsidian as source symlinks (Option 1)**
- Breaks collaboration (collaborators see broken symlinks)

**Rejected: Manual copy (Option 6)**
- Too error prone, files will drift

**Rejected: Sync scripts (Option 5)**
- Violates "avoid scripts" requirement
- Most robust but too much maintenance overhead

### Options Comparison

| Option                                  | Description                                                                                               | Setup                                                                                                                                                                                                         | Working in Project Repo                                                                                                                            | Working in Obsidian                                                                                                         | Git Versioning                                                                                          | Cross-Machine                                                                               | Obsidian-Git                                                                                          | Collaboration                                                                               | Maintenance                                                                                | Key Trade-offs & Notes                                                                                                                                                                                         |
| --------------------------------------- | --------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **4. Hard links**                       | Like symlinks, but file appears as real file in both locations. Only works on same filesystem.            | Use `ln` (without `-s`) to create hard links. One-time setup per project. Setup: `cd /path/to/project && ln /path/to/vault/file.md ./file.md`                                                                 | ❌ **BREAKS with most editors!** VS Code, Neovim, and others use "safe write" which creates new files, breaking the hard link. Silent sync failure. | ❌ **BREAKS with most editors!** Obsidian might also use safe writes. Hard link breaks silently, files drift out of sync.    | ⚠️ Works in theory, but editors break the link, creating independent files.                             | ❌ Only works on single machine AND requires editors that preserve hard links.               | ⚠️ Works until an editor breaks the link. Then fails silently.                                        | ⚠️ Works but unusual. Collaborators won't have the hard link connection but see real files. | Low if it worked, but ❌ **HIGH** risk of silent failures as links break.                   | ❌ **AVOID** - Modern editors (VS Code, Neovim, etc.) break hard links with "safe write" behavior. Silent sync failures are worse than obvious ones. Would need editor-specific configs to disable safe writes. |
| **2. Symlinks: Projects as source**     | Docs live in project repos. Obsidian vault contains symlinks pointing to project repos.                   | Create symlinks in Obsidian vault pointing to docs in each project repo. One-time manual setup per project. Setup: `ln -s /path/to/project/README.md /path/to/vault/2-permanent/projects/myproject/README.md` | ✅ Edit directly, fully native experience. Changes commit to project repo.                                                                          | ⚠️ Edit files normally (they modify project repo). May need to commit from terminal since obsidian-git might skip symlinks. | ✅ Changes tracked in project repos where they belong.                                                   | ⚠️ Need consistent directory structure on all machines (e.g., `~/repos/`).                  | ⚠️ Obsidian-git may skip symlinked files in auto-commits. Manual `git commit` in project repo needed. | ✅ Collaborators see real files in project repos.                                            | Low - set once per project, but manual git commits for Obsidian edits.                     | Good cross-machine option if you maintain consistent folder structure. Workaround: Manual commits from terminal when editing in Obsidian.                                                                      |
| **5. Duplicate files with sync script** | Maintain separate copies. Use script to sync bidirectionally (rsync, custom script, or tool like Unison). | Write/configure sync script. Set up automation (cron, fswatch, etc.) or run manually.                                                                                                                         | ✅ Edit directly in project repo. Run sync to push to Obsidian.                                                                                     | ✅ Edit directly in Obsidian. Run sync to push to projects.                                                                  | ✅ Full history in both repos. Independent git tracking.                                                 | ✅ Each machine has real files. Sync script needed per machine.                              | ✅ Works perfectly - real files everywhere.                                                            | ✅ Collaborators see real files. Your syncing is invisible to them.                          | ⚠️ Medium-High - must run sync script, handle conflicts, maintain script.                  | Violates "avoid scripts" requirement. Most robust for collaboration but requires custom scripting.                                                                                                             |
| **1. Symlinks: Obsidian as source**     | Docs live in Obsidian vault. Project repos contain symlinks pointing to Obsidian vault.                   | Create symlinks in each project repo pointing to corresponding files in Obsidian vault. One-time manual setup per project.                                                                                    | ⚠️ Edit files normally (they modify Obsidian vault). Git shows symlink changes but not content.                                                    | ✅ Edit directly, fully native Obsidian experience.                                                                          | ⚠️ Changes tracked in Obsidian repo. Project repos only see symlink commits. History lives in Obsidian. | ❌ Symlinks break on other machines (absolute paths) or need consistent directory structure. | ✅ Works well - files are real files in Obsidian.                                                      | ❌ Collaborators see broken symlinks if they don't have your Obsidian vault.                 | Low - set once per project.                                                                | ❌ **AVOID** - Breaks collaboration completely. Collaborators can't access docs without your vault.                                                                                                             |
| **3. Git submodules**                   | Add each project repo as a submodule inside Obsidian vault (e.g., `2-permanent/projects/myproject/`).     | `git submodule add <repo-url>` for each project. More complex setup.                                                                                                                                          | ⚠️ Edit in project repo, commit, push. Then pull in Obsidian submodule to see changes. Extra steps.                                                | ⚠️ Navigate into submodule, edit, commit and push from submodule. Extra steps.                                              | ✅ Full version history in both repos. Proper git tracking.                                              | ✅ Works across machines - git handles the sync.                                             | ⚠️ Submodules add complexity. Need to commit in submodule AND parent repo.                            | ✅ Collaborators can work in project repos normally.                                         | ⚠️ High - submodules are notoriously tricky. Must remember to update submodule references. | ❌ **AVOID** - Too much complexity for the benefit. Submodules are notoriously difficult to manage correctly.                                                                                                   |
| **6. Manual copy**                      | Manually copy-paste files between repos when needed.                                                      | None.                                                                                                                                                                                                         | ⚠️ Edit, then manually copy to Obsidian when you remember.                                                                                         | ⚠️ Edit, then manually copy to project repo when you remember.                                                              | ✅ Full history in both repos (when you remember to copy).                                               | ✅ Real files everywhere.                                                                    | ✅ Works perfectly.                                                                                    | ✅ Collaborators see real files.                                                             | ❌ High - error prone, easy to forget, files drift out of sync.                             | ❌ **AVOID** - You'll forget and files will drift. Human error prone.                                                                                                                                           |

**Legend:** ✅ Works well / Low friction • ⚠️ Works with caveats / Medium friction • ❌ Doesn't work well / High friction
