#!/bin/env bash
#
# CI/CD Generator Plugin
# Trigger: post-run
# Creates GitHub Actions workflow

function log_plugin() {
    echo "[CICD-PLUGIN] $*" >> "$HOME/.project-forge/logs/project-forge.log"
}

if [[ "$PF_EVENT" != "post-run" ]]; then
    exit 0
fi

PROJECT_ROOT="$PF_CONTEXT"
PROJECT_TYPE="$PF_PROJECT_TYPE"

log_plugin "Generating CI/CD configuration for $PROJECT_TYPE"

# Create .github/workflows directory
mkdir -p "$PROJECT_ROOT/.github/workflows"

# Generate generic CI workflow
cat <<'EOF' > "$PROJECT_ROOT/.github/workflows/ci.yml"
name: CI

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Run tests
      run: |
        echo "Add your test commands here"
EOF

# Add project-specific steps
case "$PROJECT_TYPE" in
    python)
        sed -i '/Add your test commands/a\
    - name: Set up Python\
      uses: actions/setup-python@v4\
      with:\
        python-version: "3.11"\
    - name: Install dependencies\
      run: pip install -r requirements.txt\
    - name: Run tests\
      run: python -m pytest tests/' "$PROJECT_ROOT/.github/workflows/ci.yml"
        ;;
    
    nodejs|react)
        sed -i '/Add your test commands/a\
    - name: Set up Node.js\
      uses: actions/setup-node@v3\
      with:\
        node-version: "18"\
        cache: "npm"\
    - name: Install dependencies\
      run: npm ci\
    - name: Run tests\
      run: npm test' "$PROJECT_ROOT/.github/workflows/ci.yml"
        ;;
    
    bash)
        sed -i '/Add your test commands/a\
    - name: Install shellcheck\
      run: sudo apt-get install -y shellcheck\
    - name: Run tests\
      run: ./tests/test.sh' "$PROJECT_ROOT/.github/workflows/ci.yml"
        ;;
esac

log_plugin "CI/CD workflow created"
echo "GitHub Actions workflow created at .github/workflows/ci.yml"
