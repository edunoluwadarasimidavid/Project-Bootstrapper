#!/usr/bin/env bash
#
# Pre-Commit Hooks Installer Plugin
# Trigger: post-run
# Sets up pre-commit hooks for code quality

function log_plugin() {
    echo "[PRECOMMIT-PLUGIN] $*" >> "$HOME/.project-forge/logs/project-forge.log"
}

if [[ "$PF_EVENT" != "post-run" ]]; then
    exit 0
fi

PROJECT_ROOT="$PF_CONTEXT"
PROJECT_TYPE="$PF_PROJECT_TYPE"

# Check if pre-commit is installed
if ! command -v pre-commit >/dev/null 2>&1; then
    log_plugin "pre-commit not installed. Skipping."
    echo "Install pre-commit: pip install pre-commit"
    exit 0
fi

log_plugin "Installing pre-commit hooks for $PROJECT_TYPE"

# Create .pre-commit-config.yaml
case "$PROJECT_TYPE" in
    python)
        cat <<'EOF' > "$PROJECT_ROOT/.pre-commit-config.yaml"
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.4.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
  - repo: https://github.com/psf/black
    rev: 23.3.0
    hooks:
      - id: black
  - repo: https://github.com/pycqa/flake8
    rev: 6.0.0
    hooks:
      - id: flake8
EOF
        ;;
    
    nodejs|react)
        cat <<'EOF' > "$PROJECT_ROOT/.pre-commit-config.yaml"
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.4.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
  - repo: https://github.com/pre-commit/mirrors-eslint
    rev: v8.42.0
    hooks:
      - id: eslint
EOF
        ;;
    
    bash)
        cat <<'EOF' > "$PROJECT_ROOT/.pre-commit-config.yaml"
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.4.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-executables-have-shebangs
  - repo: https://github.com/koalaman/shellcheck-precommit
    rev: v0.9.0
    hooks:
      - id: shellcheck
EOF
        ;;
esac

# Install hooks
cd "$PROJECT_ROOT"
pre-commit install

log_plugin "Pre-commit hooks installed"
echo "Pre-commit hooks installed. Run 'pre-commit run --all-files' to test"
