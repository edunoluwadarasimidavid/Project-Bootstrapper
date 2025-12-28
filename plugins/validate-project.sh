#!/bin/env bash
#
# Pre-Run Validation Plugin
# Trigger: pre-run
# Validates project parameters

function log_plugin() {
    echo "[VALIDATE-PLUGIN] $*" >> "$HOME/.project-forge/logs/project-forge.log"
}

if [[ "$PF_EVENT" != "pre-run" ]]; then
    exit 0
fi

PROJECT_NAME="$1"
PROJECT_TYPE="$2"

# Check project name length
if [[ ${#PROJECT_NAME} -gt 50 ]]; then
    log_plugin "Error: Project name too long (max 50 chars)"
    echo "Error: Project name must be less than 50 characters"
    exit 1
fi

# Check for reserved names
RESERVED_NAMES=("test" "demo" "example" "project" "app")
for reserved in "${RESERVED_NAMES[@]}"; do
    if [[ "$PROJECT_NAME" == "$reserved" ]]; then
        log_plugin "Warning: Using reserved name '$PROJECT_NAME'"
        echo "Warning: '$PROJECT_NAME' is a common name. Consider something more specific."
        read -p "Continue anyway? [y/N]: " -r
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 1
        fi
    fi
done

log_plugin "Validation passed for $PROJECT_NAME ($PROJECT_TYPE)"
