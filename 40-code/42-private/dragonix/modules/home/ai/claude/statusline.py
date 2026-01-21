#!/usr/bin/env python3

# Docs: https://code.claude.com/docs/en/statusline 



import json
import sys
import os
import subprocess

# Read JSON input from Claude Code that contains session information
# Structure from Claude Code:
# {
#   "model": {
#     "id": "claude-sonnet-4-5-20250929",
#     "display_name": "Claude Sonnet 4.5"
#   },
#   "workspace": {
#     "current_dir": "/current/working/directory",
#     "project_dir": "/project/root/directory"
#   },
#   "cwd": "/current/working/directory",
#   ...
# }
try:
    data = json.load(sys.stdin)
except json.JSONDecodeError:
    # Fallback if JSON parsing fails
    print("Claude Code")
    sys.exit(0)

# Extract the model display name and abbreviate (remove "Claude " prefix)
model_full = data.get('model', {}).get('display_name', 'Claude')
model = model_full.replace('Claude ', '') if model_full.startswith('Claude ') else model_full

# Get current directory (prefer cwd over workspace paths)
cwd = (data.get('cwd') or
       data.get('workspace', {}).get('current_dir') or
       os.getcwd())

# Get just the folder name
current_dir = os.path.basename(cwd) or '~'

# Get context window usage percentage
used_percentage = data.get('context_window', {}).get('used_percentage')

# Check if we're in a git repository and get the current branch
branch = None
try:
    result = subprocess.run(
        ['git', '-C', cwd, 'rev-parse', '--abbrev-ref', 'HEAD'],
        capture_output=True,
        text=True,
        timeout=1,
        env={**os.environ, 'GIT_OPTIONAL_LOCKS': '0'}
    )
    if result.returncode == 0:
        b = result.stdout.strip()
        if b and b != 'HEAD':
            branch = b
except (subprocess.TimeoutExpired, FileNotFoundError, OSError):
    pass

# Format and print the final status line
parts = [f"[{model}]", f"📁 {current_dir}"]
if branch:
    parts.append(f"🌿 {branch}")
if used_percentage is not None:
    parts.append(f"{used_percentage:.0f}%")
print(" | ".join(parts))
