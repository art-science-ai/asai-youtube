#!/bin/bash

# Read JSON input from stdin
json=$(cat)

# Parse JSON data
model=$(echo "$json" | grep -o '"displayName":"[^"]*' | cut -d'"' -f4)
cwd=$(echo "$json" | grep -o '"cwd":"[^"]*' | cut -d'"' -f4)
version=$(echo "$json" | grep -o '"version":"[^"]*' | cut -d'"' -f4)

# Get current environment details
username="${USER}"
hostname=$(hostname -s)
shell_name=$(basename "$SHELL")

# Check if we're in a nix shell
nix_indicator=""
if [[ -n "$IN_NIX_SHELL" ]] || [[ -n "$NIX_SHELL" ]]; then
    nix_indicator=" [nix]"
fi

# Extract just the directory name for brevity
dir_name=$(basename "$cwd")
[[ "$dir_name" == "" ]] && dir_name="~"

# Build the status line similar to Starship format
# Format: username@hostname [nix] shell dir | model
status_line="${username}@${hostname}${nix_indicator} ${shell_name} ${dir_name} │ ${model}"

echo "$status_line"
