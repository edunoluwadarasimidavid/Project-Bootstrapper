#!/bin/env bash
#
# GitHub Auto-Repository Plugin
# Trigger: post-run
# Requires: gh CLI tool installed

function log_plugin() {
    echo "[GITHUB-PLUGIN] $*" >> "$HOME/.project-forge/logs/project-forge.log"
}

# Only run on post-run event
if [[ "$PF_EVENT" != "post-run" ]]; then
    exit 0
fi

PROJECT_ROOT="$PF_CONTEXT"
REPO_NAME=$(basename "$PROJECT_ROOT")
GITHUB_USER=$(gh auth status 2>&1 | grep -oE 'Logged in to github.com as \w+' | cut -d' ' -f6)

# Check if gh CLI is authenticated
if ! gh auth status >/dev/null 2>&1; then
    log_plugin "GitHub CLI not authenticated. Skipping."
    exit 0
fi

# Check if this is a git repository
if [[ ! -d "$PROJECT_ROOT/.git" ]]; then
    log_plugin "Not a git repository. Skipping."
    exit 0
fi

# Ask user (non-interactive by default, but can be overridden)
if [[ "$AUTO_CREATE_REPO" != "true" ]]; then
    log_plugin "AUTO_CREATE_REPO not set. Skipping."
    exit 0
fi

log_plugin "Creating GitHub repository: $REPO_NAME"

# Create private repo and push
cd "$PROJECT_ROOT"
gh repo create "$REPO_NAME" --private --source=. --remote=origin --push

if [[ $? -eq 0 ]]; then
    log_plugin "Repository created and pushed successfully!"
    echo "GitHub repo created: https://github.com/$GITHUB_USER/$REPO_NAME"
else
    log_plugin "Failed to create repository."
fi
