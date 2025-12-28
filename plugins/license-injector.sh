#!/usr/bin/env bash
#
# License Injector Plugin
# Trigger: post-run
# Adds license headers to all .py, .js, .sh, .html files

function log_plugin() {
    echo "[LICENSE-INJECTOR] $*" >> "$HOME/.project-forge/logs/project-forge.log"
}

if [[ "$PF_EVENT" != "post-run" ]]; then
    exit 0
fi

PROJECT_ROOT="$PF_CONTEXT"
PROJECT_TYPE="$PF_PROJECT_TYPE"

# Define license header per file type
get_license_header() {
    local file_ext="$1"
    local year=$(date +%Y)
    
    case "$file_ext" in
        py)
            cat <<'EOF'
# Copyright (c) 2024 Edun Oluwadarasimi David
# Licensed under Commercial License
# Unauthorized copying is prohibited
EOF
            ;;
        js|jsx)
            cat <<EOF
/**
 * Copyright (c) $year Edun Oluwadarasimi David
 * Licensed under Commercial License
 * Unauthorized copying is prohibited
 */
EOF
            ;;
        sh|bash)
            cat <<EOF
#!/bin/env bash
# Copyright (c) $year Edun Oluwadarasimi David
# Licensed under Commercial License
# Unauthorized copying is prohibited
EOF
            ;;
        html)
            cat <<EOF
<!-- 
  Copyright (c) $year Edun Oluwadarasimi David
  Licensed under Commercial License
  Unauthorized copying is prohibited
-->
EOF
            ;;
    esac
}

log_plugin "Injecting license headers into $PROJECT_ROOT"

# Find and inject licenses
find "$PROJECT_ROOT" -type f \( -name "*.py" -o -name "*.js" -o -name "*.jsx" -o -name "*.sh" -o -name "*.bash" -o -name "*.html" \) | while read -r file; do
    ext="${file##*.}"
    header=$(get_license_header "$ext")
    
    # Only inject if not already present
    if ! head -n5 "$file" | grep -q "Copyright.*Edun Oluwadarasimi David"; then
        # Create temp file with header + original
        tmpfile=$(mktemp)
        {
            printf '%s\n' "$header"
            echo ""  # Blank line after header
            cat "$file"
        } > "$tmpfile"
        
        # Replace original
        mv "$tmpfile" "$file"
        log_plugin "Injected license: $file"
    fi
done

log_plugin "License injection complete"
