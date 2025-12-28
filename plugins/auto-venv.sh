#!/bin/env bash
#
# Auto Virtual Environment Plugin
# Trigger: post-run
# Creates venv/ and installs dependencies

function log_plugin() {
    echo "[VENV-PLUGIN] $*" >> "$HOME/.project-forge/logs/project-forge.log"
}

if [[ "$PF_EVENT" != "post-run" ]]; then
    exit 0
fi

PROJECT_ROOT="$PF_CONTEXT"

# Check if Python project
if [[ ! -f "$PROJECT_ROOT/requirements.txt" ]] && [[ ! -f "$PROJECT_ROOT/setup.py" ]]; then
    log_plugin "Not a Python project. Skipping."
    exit 0
fi

# Check if Python is available
if ! command -v python3 >/dev/null 2>&1; then
    log_plugin "Python 3 not found. Skipping."
    exit 0
fi

log_plugin "Creating virtual environment for $PROJECT_ROOT"

# Create venv
python3 -m venv "$PROJECT_ROOT/venv"

# Activate and install dependencies
if [[ -f "$PROJECT_ROOT/requirements.txt" ]]; then
    "$PROJECT_ROOT/venv/bin/pip" install -r "$PROJECT_ROOT/requirements.txt"
fi

log_plugin "Virtual environment created and dependencies installed"
echo "Virtual environment created. Run: source venv/bin/activate"
