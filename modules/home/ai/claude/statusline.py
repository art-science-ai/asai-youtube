#!/usr/bin/env python3
import json
import sys
import os

# Read JSON input from Claude Code that contains session information
# Actual structure from Claude Code (nested format):
# {
#   "model": {
#     "id": "claude-sonnet-4-5-20250929",
#     "display_name": "Claude Sonnet 4.5"
#   },
#   "cwd": "/current/working/directory",
#   ...
# }
data = json.load(sys.stdin)

# Extract the model display name and current working directory
# Using the correct nested structure as per official documentation
model = data['model']['display_name']  # Claude model name to show in status
cwd = data['cwd']  # Full path to current working directory
current_dir = os.path.basename(cwd)  # Just the folder name, not full path

# Check if we're in a git repository and get the current branch
git_branch = ""
git_head_path = os.path.join(cwd, '.git', 'HEAD')  # Check in the actual cwd, not script location
if os.path.exists(git_head_path):  # Only proceed if .git/HEAD file exists
    try:
        # Read the git HEAD file to find current branch reference
        with open(git_head_path, 'r') as f:
            ref = f.read().strip()
            # HEAD contains "ref: refs/heads/branch-name" when on a branch
            if ref.startswith('ref: refs/heads/'):
                # Extract just the branch name and format with git emoji
                git_branch = f" | 🌿 {ref.replace('ref: refs/heads/', '')}"
    except:
        # Silently fail if git HEAD file can't be read (corrupt repo, permissions, etc.)
        pass

# Format the final status line with model, directory, and optional git branch
# Output format: [Model Name] 📁 directory_name | 🌿 branch_name
print(f"[{model}] 📁 {current_dir}{git_branch}")
