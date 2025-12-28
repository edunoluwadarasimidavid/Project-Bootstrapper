Project Forge CLI - Project Bootstrapper

Version: 2.1.0

Author: Edun Oluwadarasimi David

Website: [https://edunoluwadarasimidavid.name.ng](https://edunoluwadarasimidavid.name.ng)

Repository: [https://github.com/edunoluwadarasimidavid/Project-Bootstrapper](https://github.com/edunoluwadarasimidavid/Project-Bootstrapper)

License: MIT (Free and Open Source)

---

🌟 What is Project Forge CLI?

Project Forge CLI is a professional-grade project bootstrapper that generates production-ready project structures in seconds. It eliminates repetitive setup work by creating complete, opinionated project templates with best practices built-in.

Key Features

✅ 6 Project Types: Python, Node.js, Web (HTML/CSS/JS), Bash, React, and Custom

✅ Auto-Update System: Seamlessly updates from GitHub without reinstalling

✅ Plugin Architecture: Extensible with custom plugins for any workflow

✅ Security: SHA256 verification and optional GPG signature verification

✅ Cross-Platform: Works on Termux (Android), Linux, macOS, and BSD

✅ Professional Templates: Includes README, LICENSE, .gitignore, and CI/CD configs

✅ Free & Open Source: MIT licensed, community-driven development  

---

📦 Installation

Method 1: Direct Download (Recommended)

```bash
# Download the bootstrapper
sudo curl -o /usr/local/bin/project-forge \
  https://raw.githubusercontent.com/edunoluwadarasimidavid/Project-Bootstrapper/main/project-forge

# Make executable
sudo chmod +x /usr/local/bin/project-forge

# Verify installation
project-forge --version
```

Method 2: Termux (Android) Installation

```bash
# Create local bin directory
mkdir -p ~/.local/bin

# Download
curl -o ~/.local/bin/project-forge \
  https://raw.githubusercontent.com/edunoluwadarasimidavid/Project-Bootstrapper/main/project-forge

# Make executable
chmod +x ~/.local/bin/project-forge

# Add to PATH
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# Verify
project-forge --version
```

Method 3: Offline Installation

Download the offline bundle from [GitHub Releases](https://github.com/edunoluwadarasimidavid/Project-Bootstrapper/releases):

```bash
# Download bundle
wget https://github.com/edunoluwadarasimidavid/Project-Bootstrapper/releases/download/v2.1.0/project-forge-offline-2.1.0.tar.gz

# Extract
tar -xzf project-forge-offline-2.1.0.tar.gz
cd project-forge-offline-bundle

# Install
./install.sh
```

---

🚀 Quick Start

Interactive Mode

Run without arguments to start the interactive wizard:

```bash
project-forge
```

You'll be prompted for:
1. Project name (e.g., `myapp`, `my-app`, `my_app_123`)
2. Author name (defaults to system user)
3. Project type (choose from 6 options)
4. Initialize Git (yes/no)

Example session:

```bash
$ project-forge

╔══════════════════════════════════════════════════════════════╗
║      ⚡ PROJECT FORGE CLI ⚡                                ║
║      Version: 2.1.0                                          ║
╚══════════════════════════════════════════════════════════════╝

Project name: myapp
Author name: Edun Oluwadarasimi David

Select project type:
  1) Python     - Python package/application
  2) Node.js    - ES6+ Node.js application
  3) Web        - Modern HTML5/CSS3/ES6+ site
  4) Bash       - Enterprise shell script
  5) React      - React SPA (npx create-react-app)
  6) Custom     - Flexible custom structure

Enter choice (1-6): 1
Initialize Git repository? [y/N]: y

[INFO] Creating python project: myapp
...
[✓] Project created successfully!

Project Summary:
  Name:     myapp
  Type:     Python
  Location: ./myapp
  Author:   Edun Oluwadarasimi David
  Git:      Initialized

Next Steps:
  cd myapp
  python3 src/main.py
```

---

📋 Command Line Options

```bash
project-forge [OPTIONS]

Options:
  -h, --help              Show help message
  -v, --version           Show version information
  -d, --debug             Enable debug logging (Level 1)
  --debug=2               Enable verbose debug (Level 2)
  --debug=3               Enable trace debug (Level 3)
  -n, --dry-run           Preview changes without creating files
  
  --update                Force update check and prompt
  --update-check          Check for updates only
  --force-offline         Use cached logic only (offline mode)
  --use-version VER       Use specific version (e.g., 2.0.0)
  
  --clear-cache           Clear all cached logic files
  --list-versions         List all cached versions
  --doctor                Run system diagnostics
  
  doctor                  Run diagnostics
  test                    Run self-test suite
```

---

🎯 Project Types Explained

1. Python Project
- Structure: `src/package/`, `tests/`, `docs/`, `scripts/`
- Features: setuptools, CLI entry points, pytest, black, flake8
- Entry point: `python3 src/main.py` or `python3 -m myapp`

2. Node.js Project
- Structure: ES6+ modules, `src/`, `tests/`, `public/`
- Features: Modern JavaScript, nodemon, ESLint, package.json scripts
- Entry point: `npm start` or `node src/index.js`

3. Web Project
- Structure: HTML5, CSS3, ES6+, PWA-ready
- Features: Responsive design, CSS variables, service worker
- Entry point: Open `src/index.html` in browser or `python3 -m http.server -d src/`

4. Bash Project
- Structure: `src/`, `lib/`, `tests/`, `bin/`, `config/`
- Features: Enterprise-grade scripting, libraries, config management
- Entry point: `./src/main.sh start`

5. React Project
- Uses official: `npx create-react-app@latest`
- Structure: Components, hooks, utils, services
- Features: Modern React, ES6+, hot reload
- Entry point: `npm start`

6. Custom Project
- Structure: Flexible `src/`, `tests/`, `docs/`, `assets/`
- Features: Generic template, adaptable for any language
- Entry point: `./src/main`

---

🔌 Plugin System

Plugins are shell scripts that extend functionality. They execute at specific lifecycle events.

Official Plugins (Included)

1. GitHub Auto-Repository (`github-auto.sh`)
- Automatically creates GitHub repo and pushes code
- Requires: `gh` CLI tool (`brew install gh` or `sudo apt install gh`)
- Enable: `export AUTO_CREATE_REPO=true`

2. VS Code Workspace (`vscode-workspace.sh`)
- Creates `.vscode/settings.json` and `.vscode/extensions.json`
- Recommends extensions based on project type

3. Desktop Notifications (`notify.sh`)
- Sends OS notification when project is ready
- Supports Linux, macOS, and Termux

4. Python Virtual Environment (`auto-venv.sh`)
- Automatically creates and activates Python venv
- Installs dependencies from `requirements.txt`

Installing Plugins

```bash
# Create plugins directory
mkdir -p ~/.project-forge/plugins

# Download a plugin
curl -o ~/.project-forge/plugins/plugin-name.sh \
  https://edunoluwadarasimidavid.name.ng/plugins/plugin-name.sh

# Make executable
chmod +x ~/.project-forge/plugins/plugin-name.sh

# That's it! Plugins auto-load on next run
```

Creating Your Own Plugin

Minimal plugin structure:

```bash
#!/bin/env bash
#
# My Custom Plugin
# Trigger: post-run

# Only run for specific event
if [[ "$PF_EVENT" != "post-run" ]]; then
    exit 0
fi

PROJECT_ROOT="$PF_CONTEXT"

# Your custom logic here
echo "Plugin executed for project: $PROJECT_NAME"

# Example: Create a custom file
echo "Generated by plugin" > "$PROJECT_ROOT/PLUGIN-README.md"
```

Save as: `~/.project-forge/plugins/my-plugin.sh`

Make executable: `chmod +x ~/.project-forge/plugins/my-plugin.sh`

---

⚙️ Configuration

Configuration File Location

Create `~/.project-forge/config.toml`:

```bash
# Create config file from template
nano ~/.project-forge/config.toml
```

Example Configuration

```toml
# Project Forge CLI Configuration v2.1.0

# --- User Defaults ---
default_author = "Your Name"
default_project_type = "python"
auto_init_git = true

# --- Update Settings ---
update_channel = "stable"  # Options: stable, beta, nightly
check_updates = true
auto_update = false        # Set true to auto-apply updates

# --- Security ---
verify_signatures = true   # Verify GPG signatures on updates
certificate_pinning = false # Enable for enterprise (adds cert validation)

# --- Telemetry (Opt-in) ---
metrics_enabled = false    # Set true to help improve the tool

# --- Debugging ---
debug_level = 0            # 0=off, 1=info, 2=debug, 3=trace

# --- Plugins ---
plugin_dir = "~/.project-forge/plugins"

# --- Enterprise (Optional) ---
# enterprise_mode = false
# admin_email = "admin@company.com"
```

Environment Variable Overrides

Set these to override config file:

```bash
# Override config with environment variables
export PROJECT_FORGE_AUTHOR="Company Name"
export PROJECT_FORGE_CHANNEL="beta"
export PROJECT_FORGE_METRICS="true"
export PROJECT_FORGE_DEBUG="2"

# Run with custom config
project-forge
```

---

🔐 Security Features

Signature Verification

Enable GPG verification:

```bash
# 1. Download public key
curl -o ~/.project-forge/signatures/public.key \
  https://raw.githubusercontent.com/edunoluwadarasimidavid/Project-Bootstrapper/main/signatures/public.key

# 2. Enable in config
echo 'verify_signatures = true' >> ~/.project-forge/config.toml
```

Every update will now be GPG-verified.

Certificate Pinning (Enterprise)

For companies behind SSL inspection:

```bash
# 1. Download GitHub's CA certificate
# (Your IT team provides this)
cp company-ca.crt ~/.project-forge/signatures/github-ca.pem

# 2. Enable in config
echo 'certificate_pinning = true' >> ~/.project-forge/config.toml
```

Offline Mode

Use when internet is unavailable or unstable:

```bash
# Force use of cached logic
project-forge --force-offline

# List cached versions
project-forge --list-versions

# Use specific cached version
project-forge --use-version 2.0.0
```

---

🛠️ Troubleshooting

Common Issues

1. "Permission denied" when installing:

```bash
# Fix: Use sudo for system-wide install
sudo curl -o /usr/local/bin/project-forge ...
sudo chmod +x /usr/local/bin/project-forge
```

2. "Another instance running":

```bash
# Remove stale lock file
sudo rm /tmp/project-forge.lock
```

3. Plugin not executing:

```bash
# Check permissions
chmod +x ~/.project-forge/plugins/*.sh

# Check logs
grep "PLUGIN" ~/.project-forge/logs/project-forge.log
```

4. Update fails:

```bash
# Force offline mode
project-forge --force-offline

# Clear cache and retry
project-forge --clear-cache
project-forge --update
```

Run Diagnostics

```bash
# Check system compatibility
project-forge doctor

# Expected output:
# ✓ Bash detected
# ✓ curl available
# ✓ Config dir writable
# ✓ Network connectivity OK
```

---

📊 Example Projects

Python Web API

```bash
project-forge

# Project name: myapi
# Type: 1 (Python)
# Git: y

cd myapi
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python src/main.py
```

React Dashboard

```bash
project-forge

# Project name: dashboard
# Type: 5 (React)
# Git: y

cd dashboard
npm start
# Open http://localhost:3000
```

Bash CLI Tool

```bash
project-forge

# Project name: mycli
# Type: 4 (Bash)
# Git: y

cd mycli
./src/main.sh start
./tests/test.sh
```

---

🎓 Advanced Usage

Release Channels

Switch between stable, beta, and nightly builds:

```bash
# Use beta channel
PROJECT_FORGE_CHANNEL=beta project-forge

# Use nightly (bleeding edge)
PROJECT_FORGE_CHANNEL=nightly project-forge

# Pin to stable in config
echo 'update_channel = "stable"' >> ~/.project-forge/config.toml
```

Telemetry (Opt-in)

Help improve the tool by enabling anonymous metrics:

```bash
# Enable in config
echo 'metrics_enabled = true' >> ~/.project-forge/config.toml

# Or set environment variable
export PROJECT_FORGE_METRICS=true

# View your metrics
cat ~/.project-forge/cache/metrics.json
```

Data collected: OS type, shell type, version, event timestamps (no personal data).

Enterprise Installation

For company-wide deployment:

```bash
# Download to shared location
sudo mkdir -p /etc/project-forge
sudo curl -o /etc/project-forge/project-forge \
  https://raw.githubusercontent.com/edunoluwadarasimidavid/Project-Bootstrapper/main/project-forge

# Create system-wide config
sudo nano /etc/project-forge/config.toml

# Symlink to system PATH
sudo ln -s /etc/project-forge/project-forge /usr/local/bin/

# All users can now run: project-forge
```

---

🌐 Community & Support

Found a bug?

[Open an issue on GitHub](https://github.com/edunoluwadarasimidavid/Project-Bootstrapper/issues)

Need help?

Email: contact@edunoluwadarasimidavid.name.ng

Discord: [Join our community](#)

Want to contribute?

See [CONTRIBUTING.md](https://github.com/edunoluwadarasimidavid/Project-Bootstrapper/blob/main/docs/CONTRIBUTING.md)

Share your plugins!

Submit plugins to: [https://github.com/edunoluwadarasimidavid/Project-Bootstrapper/discussions](https://github.com/edunoluwadarasimidavid/Project-Bootstrapper/discussions)

---

📄 License

This project is MIT Licensed - free for personal and commercial use.

```
MIT License

Copyright (c) 2025 Edun Oluwadarasimi David

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
```


🎉 Happy Project Building!