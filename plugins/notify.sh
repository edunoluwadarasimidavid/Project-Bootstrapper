#!/bin/env bash
#
# Desktop Notification Plugin
# Trigger: post-run

function log_plugin() {
    echo "[NOTIFY-PLUGIN] $*" >> "$HOME/.project-forge/logs/project-forge.log"
}

if [[ "$PF_EVENT" != "post-run" ]]; then
    exit 0
fi

PROJECT_ROOT="$PF_CONTEXT"
PROJECT_NAME=$(basename "$PROJECT_ROOT")

# Check notification system
if command -v notify-send >/dev/null 2>&1; then
    # Linux (libnotify)
    notify-send "Project Forge" "Project '$PROJECT_NAME' created successfully!" \
                -i folder-new -a "Project Forge CLI"
elif command -v osascript >/dev/null 2>&1; then
    # macOS
    osascript -e "display notification \"Project '$PROJECT_NAME' created\" \
                  with title \"Project Forge\" sound name \"Glass\""
elif [[ "$TERMUX_VERSION" != "" ]]; then
    # Termux (Android)
    termux-toast "Project '$PROJECT_NAME' created!"
fi

log_plugin "Notification sent for $PROJECT_NAME"
