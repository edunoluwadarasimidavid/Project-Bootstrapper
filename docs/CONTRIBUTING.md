CONTRIBUTING.md

Project Forge CLI is a community-driven, open-source project, and we welcome contributions from everyone! Whether you're a beginner or an experienced developer, there are many ways to get involved.

---

🎉 Welcome Contributors!

We appreciate all contributions, including:

- 🐛 Bug Reports: Found an issue? Let us know!
- ✨ Feature Requests: Have an idea? Share it!
- 📝 Documentation: Improve docs, tutorials, or README
- 🔌 Plugins: Create and share useful plugins
- 🧪 Testing: Write tests or test new features
- 💬 Community: Answer questions, help others
- 🎨 Design: Suggest UX/UI improvements

---

📋 How to Contribute

1. Reporting Bugs 🐛

If you find a bug, please create an issue:

1. Search existing issues first to avoid duplicates
2. Use bug report template:
   
```markdown
   **Bug Description**
   A clear description of the bug

   **Steps to Reproduce**
   1. Run `project-forge ...`
   2. Select options...
   3. See error

   **Expected Behavior**
   What should happen

   **Actual Behavior**
   What actually happens

   **System Info**
   - OS: [Linux/Termux/macOS]
   - Shell: [bash/zsh/sh]
   - Version: `project-forge --version`
   ```

3. Include logs: Attach `~/.project-forge/logs/project-forge.log`

---

2. Suggesting Features ✨

Request new features:

1. Open a "Feature Request" issue
2. Describe your idea clearly
3. Explain use case: Why would this help?
4. Suggest implementation (optional)

Feature Request Template:

```markdown
**Feature Description**
What you want to add

**Use Case**
Why this is useful

**Possible Implementation**
How it could work

**Alternatives Considered**
Other solutions you thought of
```

---

3. Contributing Code 💻

Development Setup

1. Fork the Repository
   
```bash
   git clone https://github.com/edunoluwadarasimidavid/Project-Bootstrapper.git
   cd Project-Bootstrapper
   ```

2. Create Development Environment
   
```bash
   # Install locally for testing
   cp project-forge /usr/local/bin/project-forge-dev
   chmod +x /usr/local/bin/project-forge-dev
   
   # Create test config
   mkdir -p ~/.project-forge-dev
   cp config/config.toml.example ~/.project-forge-dev/config.toml
   ```

3. Make Your Changes
   - Edit the logic file in `updates/`
   - Test thoroughly: `project-forge-dev --dry-run`

4. Follow Code Style
   - Shell: POSIX-compliant (`#!/bin/sh`)
   - Indentation: 4 spaces (no tabs)
   - Functions: Use `function_name()` syntax
   - Variables: `UPPERCASE_WITH_UNDERSCORES`
   - Error Handling: Always check if commands succeed

   
```bash
   # Good
   if command -v tool >/dev/null 2>&1; then
       tool --version
   else
       log_error "tool not found"
       return 1
   fi
   
   # Bad
   tool --version  # No error checking
   ```

5. Add Comments: Explain complex logic, not obvious code

6. Test Your Changes
   
```bash
   # Dry-run test
   project-forge-dev --dry-run
   
   # Create test project
   project-forge-dev
   
   # Check logs
   tail -f ~/.project-forge-dev/logs/project-forge.log
   ```

7. Run Self-Tests
   
```bash
   # If you added tests
   ./tests/test-suite.sh
   ```

---

4. Creating Plugins 🔌

Plugin Development Guide

Quick Start:

```bash
# Create plugin directory
mkdir -p plugins/my-plugin
touch plugins/my-plugin.sh plugins/my-plugin/README.md

# Make executable
chmod +x plugins/my-plugin.sh
```

Plugin Template:

```bash
#!/bin/env bash
#
# Plugin Name: My Custom Plugin
# Trigger: post-run
# Description: What this plugin does

function log_plugin() {
    echo "[MY-PLUGIN] $*" >> "$HOME/.project-forge/logs/project-forge.log"
}

# Only run for specific event
if [[ "$PF_EVENT" != "post-run" ]]; then
    exit 0
fi

PROJECT_ROOT="$PF_CONTEXT"

# Your logic here
log_plugin "Plugin executed for $PROJECT_NAME"
echo "Plugin action complete"
```

Submit Plugin:
1. Add plugin to `plugins/` directory
2. Include `README.md` with:
   - Description
   - Installation
   - Usage
   - Requirements
3. Add test if applicable
4. Submit pull request

Plugin Best Practices
- ✅ Use `#!/bin/env bash` for portability
- ✅ Log all actions to `$PF_LOG_FILE`
- ✅ Check dependencies before running
- ✅ Exit gracefully if optional tool missing
- ✅ Don't modify core files
- ✅ Follow naming convention: `plugin-name.sh`

---

5. Improving Documentation 📝

- Fix typos: Small typo fixes are welcome!
- Add examples: Show real-world usage
- Translate: Help translate docs to other languages
- Write tutorials: Step-by-step guides

Documentation files to edit:
- `README.md` - Main project readme
- `docs/` - Detailed documentation
- `plugins/*/README.md` - Plugin-specific docs

---

6. Testing 🧪

Writing Tests

Create test scripts in `tests/` directory:

```bash
# tests/test-new-feature.sh
#!/bin/env bash

# Test new feature
result=$(project-forge --dry-run --new-feature)
if [[ "$result" == *"Success"* ]]; then
    echo "PASS: New feature works"
    exit 0
else
    echo "FAIL: New feature broken"
    exit 1
fi
```

Run tests:

```bash
chmod +x tests/test-*.sh
./tests/test-suite.sh  # Runs all tests
```

---

🔀 Pull Request Process

1. Create Feature Branch

```bash
git checkout -b feature/your-feature-name
# or
git checkout -b fix/bug-fix-name
```

2. Commit Changes

Commit Message Format:

```
<type>: <short description>

<optional longer description>

Fixes #123
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `plugin`: New plugin
- `test`: Test addition
- `refactor`: Code improvement
- `chore`: Maintenance

Good Examples:

```
feat: add React 18 support
fix: resolve permission error on Termux
plugin: create docker-generator plugin
docs: add plugin development guide
```

3. Push to Fork

```bash
git push origin feature/your-feature-name
```

4. Create Pull Request

1. Go to your fork on GitHub
2. Click "New Pull Request"
3. Select `edunoluwadarasimidavid/Project-Bootstrapper:main` as base
4. Write detailed PR description:
   - What changes you made
   - Why they're needed
   - How to test them
   - Screenshots (if UI changes)

5. PR Checklist

Before submitting, ensure:
- Code follows style guidelines
- Self-review completed
- Changes tested locally
- Documentation updated
- No breaking changes (or documented if unavoidable)
- Commit messages are clear

6. Address Review Feedback

Be responsive to reviewer comments. It's a collaborative process!

---

🏆 Recognition

Contributor Tiers

We recognize contributors based on their involvement:

- 🥉 Bronze Contributor: 1-3 contributions
- 🥈 Silver Contributor: 4-10 contributions or 1 plugin
- 🥇 Gold Contributor: 10+ contributions or major features
- 💎 Platinum Contributor: Sustained contributions over time

Benefits:
- Recognition in `CONTRIBUTORS.md`
- Mention in release notes
- Access to contributor-only discussions
- Opportunity to become maintainer

---

📜 Code of Conduct

Our Pledge

We pledge to make participation in our project a harassment-free experience for everyone, regardless of age, body size, disability, ethnicity, gender identity and expression, level of experience, nationality, personal appearance, race, religion, or sexual identity and orientation.

Our Standards

Good Behavior:
- ✅ Be respectful and inclusive
- ✅ Welcome newcomers
- ✅ Focus on constructive feedback
- ✅ Respect differing viewpoints
- ✅ Show empathy

Unacceptable Behavior:
- ❌ Harassment, insults, or derogatory comments
- ❌ Trolling, inflammatory remarks
- ❌ Publishing others' private information
- ❌ Spam or off-topic content

Enforcement

If you experience or witness unacceptable behavior:
1. Report to: contact@edunoluwadarasimidavid.name.ng
2. Include: Description, evidence (screenshots/logs), context
3. Response time: Within 48 hours
4. Actions: Warning, temporary ban, or permanent ban

---

🤗 Getting Help

For Beginners

First time contributing to open source? Welcome! Here's how to start:

1. Find "good first issue" in GitHub issues
2. Join our Discord: [https://discord.gg/project-forge](https://discord.gg/project-forge)
3. Ask questions: No question is too basic!
4. Read issues: Learn from discussions

Mentorship available: Ask in Discord for a mentor

For Experienced Contributors

- Review PRs: Help review and test contributions
- Triage issues: Help categorize and prioritize
- Mentor newcomers: Guide new contributors
- Suggest architecture: Propose improvements

Resources

- Documentation: [https://edunoluwadarasimidavid.name.ng/docs](https://edunoluwadarasimidavid.name.ng/docs)
- Plugin Gallery: [https://edunoluwadarasimidavid.name.ng/plugins](https://edunoluwadarasimidavid.name.ng/plugins)
- Architecture: [ARCHITECTURE.md](https://github.com/edunoluwadarasimidavid/Project-Bootstrapper/blob/main/docs/ARCHITECTURE.md)
- FAQ: [FAQ.md](https://github.com/edunoluwadarasimidavid/Project-Bootstrapper/blob/main/docs/FAQ.md)

---

📊 Project Governance

Decision Making

- Minor changes: Maintainer discretion
- Major features: Community discussion in issues
- Breaking changes: Require 2 maintainer approvals + community notice 30 days in advance
- Plugin inclusion: 1 maintainer approval after passing tests

Current Maintainers

- Lead Maintainer: Edun Oluwadarasimi David ([@edunoluwadarasimidavid](https://github.com/edunoluwadarasimidavid))
- Core Maintainers: Listed in [MAINTAINERS.md](https://github.com/edunoluwadarasimidavid/Project-Bootstrapper/blob/main/MAINTAINERS.md)

Becoming a Maintainer

Consistent, high-quality contributors can be promoted to maintainer:
- Minimum 6 months active participation
- Deep understanding of codebase
- Community mentorship
- Nomination by existing maintainer
- Vote by current maintainers (2/3 majority)

---

🎉 Release Process

Release cadence:
- Patch releases (bug fixes): Weekly
- Minor releases (features): Monthly
- Major releases (breaking changes): Every 6 months

Release checklist:
- All tests pass
- Documentation updated
- Changelog updated
- Plugins verified
- Security audit passed
- Community announcement

---

Help us achieve these goals! Every contribution counts.

---

📞 Contact

- General Questions: [Discussions](https://github.com/edunoluwadarasimidavid/Project-Bootstrapper/discussions)
- Bug Reports: [Issues](https://github.com/edunoluwadarasimidavid/Project-Bootstrapper/issues)
- Email: contact@edunoluwadarasimidavid.name.ng
- 
- Website: [https://edunoluwadarasimidavid.name.ng](https://edunoluwadarasimidavid.name.ng)

---
