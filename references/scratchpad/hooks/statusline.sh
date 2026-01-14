#!/bin/bash
# Read JSON input once
input=$(cat)

# Helper functions for common extractions
get_model_name() { echo "$input" | jq -r '.model.display_name'; }
get_current_dir() { echo "$input" | jq -r '.workspace.current_dir'; }
get_git_branch() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        BRANCH=$(git branch --show-current 2>/dev/null)
        [ -n "$BRANCH" ] && echo " | 🌿 $BRANCH"
    fi
}

# Use the helpers
MODEL=$(get_model_name)
DIR=$(get_current_dir)
GIT=$(get_git_branch)

echo "[$MODEL] 📁 ${DIR##*/}$GIT"