#!/bin/env bash
#
# VS Code Workspace Plugin
# Trigger: post-run
# Creates .vscode/settings.json and .vscode/extensions.json

function log_plugin() {
    echo "[VSCODE-PLUGIN] $*" >> "$HOME/.project-forge/logs/project-forge.log"
}

if [[ "$PF_EVENT" != "post-run" ]]; then
    exit 0
fi

PROJECT_ROOT="$PF_CONTEXT"
PROJECT_TYPE="$2"  # Second argument is project type

# Detect project type from directory structure
if [[ -f "$PROJECT_ROOT/package.json" ]]; then
    PROJECT_TYPE="nodejs"
elif [[ -f "$PROJECT_ROOT/src/main.py" ]]; then
    PROJECT_TYPE="python"
elif [[ -f "$PROJECT_ROOT/src/index.html" ]]; then
    PROJECT_TYPE="web"
fi

log_plugin "Creating VS Code workspace for $PROJECT_TYPE project"

# Create .vscode directory
mkdir -p "$PROJECT_ROOT/.vscode"

# Generate settings.json
cat <<EOF > "$PROJECT_ROOT/.vscode/settings.json"
{
    "editor.formatOnSave": true,
    "files.exclude": {
        "**/.git": true,
        "**/.DS_Store": true
    },
    "terminal.integrated.cwd": "\${workspaceFolder}"
}
EOF

# Generate extensions.json based on project type
cat <<EOF > "$PROJECT_ROOT/.vscode/extensions.json"
{
    "recommendations": [
EOF

case "$PROJECT_TYPE" in
    python)
        cat <<EXT >> "$PROJECT_ROOT/.vscode/extensions.json"
        "ms-python.python",
        "ms-python.black-formatter"
EXT
        ;;
    nodejs|react)
        cat <<EXT >> "$PROJECT_ROOT/.vscode/extensions.json"
        "esbenp.prettier-vscode",
        "ms-vscode.vscode-json"
EXT
        ;;
    web)
        cat <<EXT >> "$PROJECT_ROOT/.vscode/extensions.json"
        "ritwickdey.LiveServer",
        "bradlc.vscode-tailwindcss"
EXT
        ;;
    bash)
        cat <<EXT >> "$PROJECT_ROOT/.vscode/extensions.json"
        "foxundermoon.shell-format",
        "timonwong.shellcheck"
EXT
        ;;
esac

cat <<EOF >> "$PROJECT_ROOT/.vscode/extensions.json"
    ]
}
EOF

log_plugin "VS Code workspace created successfully"
echo "VS Code workspace created with recommended extensions"
