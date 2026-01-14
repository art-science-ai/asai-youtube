#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = [
#     "python-dotenv",
# ]
# ///

import json
import sys
import subprocess
from pathlib import Path
from datetime import datetime


def get_git_status():
    """Get current git status, branch info, and worktrees."""
    print("🔍 Checking git status...")
    
    git_info = []
    
    try:
        # Current branch
        branch_result = subprocess.run(
            ['git', 'rev-parse', '--abbrev-ref', 'HEAD'],
            capture_output=True, text=True, timeout=5
        )
        if branch_result.returncode == 0:
            current_branch = branch_result.stdout.strip()
            git_info.append(f"Current branch: {current_branch}")
        
        # Uncommitted changes
        status_result = subprocess.run(
            ['git', 'status', '--porcelain'],
            capture_output=True, text=True, timeout=5
        )
        if status_result.returncode == 0:
            changes = status_result.stdout.strip().split('\n') if status_result.stdout.strip() else []
            if changes:
                git_info.append(f"Uncommitted changes: {len(changes)} files")
        
        # All branches
        branches_result = subprocess.run(
            ['git', 'branch', '-a'],
            capture_output=True, text=True, timeout=5
        )
        if branches_result.returncode == 0:
            branches = [b.strip().replace('* ', '') for b in branches_result.stdout.strip().split('\n') if b.strip()]
            git_info.append(f"All branches: {', '.join(branches[:5])}{'...' if len(branches) > 5 else ''}")
        
        # Worktrees
        worktree_result = subprocess.run(
            ['git', 'worktree', 'list'],
            capture_output=True, text=True, timeout=5
        )
        if worktree_result.returncode == 0:
            worktrees = worktree_result.stdout.strip().split('\n')
            if len(worktrees) > 1:  # More than just main worktree
                git_info.append(f"Worktrees: {len(worktrees)} total")
        
    except Exception:
        git_info.append("Git info unavailable")
    
    # Print summary
    print(f"✅ Git status: {len(git_info)} items collected")
    
    return '\n'.join(git_info)


def get_recent_issues():
    """Get recent GitHub issues if gh CLI is available."""
    print("📋 Fetching GitHub issues...")
    
    try:
        # Check if gh is available
        gh_check = subprocess.run(['which', 'gh'], capture_output=True)
        if gh_check.returncode != 0:
            print("❌ GitHub issues: CLI not available")
            return "GitHub CLI not available"
        
        # Get recent open issues
        result = subprocess.run(
            ['gh', 'issue', 'list', '--limit', '5', '--state', 'open'],
            capture_output=True, text=True, timeout=10
        )
        if result.returncode == 0 and result.stdout.strip():
            issue_count = len(result.stdout.strip().split('\n'))
            print(f"✅ GitHub issues: {issue_count} issues found")
            return result.stdout.strip()
        else:
            print("ℹ️ GitHub issues: No issues found")
            return "No recent issues found"
    except Exception:
        print("❌ GitHub issues: Error fetching")
        return "Error fetching issues"


def load_context(source):
    """Load relevant development context."""
    print("📊 Loading context...")
    
    context_parts = [
        f"Session started at: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}",
        f"Session source: {source}"
    ]
    
    # Add git information
    git_info = get_git_status()
    if git_info:
        context_parts.append(f"\n--- Git Information ---")
        context_parts.append(git_info)
    
    # Load context files
    context_files = [
        str(Path.home() / ".config/opencode/AGENTS.md"),
        "README.md",
        "AGENTS.md",
    ]
    
    for file_path in context_files:
        if Path(file_path).exists():
            try:
                with open(file_path, 'r') as f:
                    content = f.read().strip()
                    if content:
                        print(f"📄 Adding {Path(file_path)} to context")
                        context_parts.append(f"\n--- Content from {file_path} ---")
                        context_parts.append(content[:1000])
            except Exception:
                pass
    
    # Add GitHub issues
    issues = get_recent_issues()
    if issues:
        context_parts.append("\n--- Recent GitHub Issues ---")
        context_parts.append(issues)
    
    # Print summary
    files_loaded = len([f for f in context_files if Path(f).exists()])
    print(f"✅ Context loading: {files_loaded} files loaded, git info included, issues checked")
    
    return "\n".join(context_parts)


def main():
    try:
        # Read JSON input
        input_data = json.loads(sys.stdin.read())
        source = input_data.get('source', 'unknown')
        
        # Announce session start
        messages = {
            "startup": "Claude Code session started",
            "resume": "Resuming previous session",
            "clear": "Starting fresh session"
        }
        message = messages.get(source, "Session started")
        print(f"🎯 {message}")
        
        # Load context
        context = load_context(source)
        if context:
            output = {
                "hookSpecificOutput": {
                    "hookEventName": "SessionStart",
                    "additionalContext": context
                }
            }
            # print(json.dumps(output))
        
        sys.exit(0)
        
    except Exception:
        sys.exit(0)


if __name__ == '__main__':
    main()