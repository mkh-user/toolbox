# Toolbox 🧰

> My advanced skills and professional-grade tools to use everywhere.

A modular, standalone developer and AI agent toolkit engineered for portability across Linux environments, Google Colab, and remote machines with zero mandatory dependencies.

---

## ⚡ Quick Start

Clone and run in-place without installing anything:

```bash
git clone https://github.com/mkh-user/toolbox.git
cd toolbox

# Show all available categories and commands
./toolbox --help

# Run non-destructive environment & credentials check
./toolbox setup status

# Full Colab environment initialization (Drive + gh + agy)
./toolbox setup colab
```

---

## 🏗 Architecture & Design

```
toolbox/
├── toolbox                      # Unified root CLI dispatcher (auto-discovery)
├── AGENTS.md                    # Operating manual & boundaries for AI assistants
├── CHANGELOG.md                 # SemVer release history (Keep a Changelog)
├── README.md                    # Primary documentation & usage manual
├── tools/                       # Executable CLI tools (category namespaced)
│   ├── lib/
│   │   └── common.sh           # Shared terminal colors, logging, and helpers
│   ├── setup/                  # Environment and credential bootstrapping
│   │   ├── status              # Status check for Drive, GH_TOKEN, gh, agy
│   │   ├── colab               # One-click Drive mount, gh login, agy restore
│   │   ├── gh                  # Secure GitHub CLI auth via Colab Secrets
│   │   └── agy                 # Backup & restore Antigravity OAuth token
│   ├── colab/                  # Runtime persistence, backup, and restore
│   │   ├── save                # Backup configs & files to Google Drive tarball
│   │   └── restore             # Restore state from Google Drive tarball
│   ├── git/                    # Git automation and hygiene helpers
│   │   ├── diff-sum            # Working tree summary with change stats
│   │   ├── commit              # Conventional commit helper
│   │   └── clean               # Safe cache and temp file cleaner
│   └── audit/                  # Code quality and security checks
│       └── check               # Static bash syntax, permissions, and secret scan
└── agent/                       # AI Agent integration assets
    ├── skills/                 # Agent skills (advanced-programmer, toolbox, git, audit)
    └── rules/                  # Behavioral rulesets (interaction, safety, code-quality, git)
```

### Key Principles

- **Zero-Dependency Core**: All core scripts run directly with standard Bash and preinstalled system utilities.
- **Dynamic Auto-Discovery**: Dropping an executable script into `tools/<category>/` automatically exposes it in `./toolbox --help` and `./toolbox <category> --help` using its header `# Description:`.
- **Strict Namespacing**: Every command is scoped to its domain (`./toolbox <category> <command>`).
- **Agent Native**: Includes native Antigravity and AI agent skills so LLM coding assistants know how to discover and safely execute toolbox commands.

---

## 📖 Command Reference

### `setup` — Environment & Credentials

| Command | Description |
|---|---|
| `./toolbox setup status` | Non-destructive audit of Google Drive mount, Colab Secrets, GitHub CLI, and Antigravity tokens. |
| `./toolbox setup colab` | One-click setup: mounts Google Drive, authenticates `gh` via `GH_TOKEN` secret, and restores `agy` token. |
| `./toolbox setup gh` | Authenticates GitHub CLI using strictly the `GH_TOKEN` stored in Google Colab Secrets (`userdata`). |
| `./toolbox setup agy save` | Backs up local Antigravity token (`~/.gemini/antigravity-cli/antigravity-oauth-token`) to Google Drive. |
| `./toolbox setup agy restore` | Restores Antigravity token from Google Drive to local config with `chmod 600`. |
| `./toolbox setup agy status` | Checks existence and validity of local and backup tokens. |

### `colab` — Runtime Persistence

| Command | Description |
|---|---|
| `./toolbox colab save` | Packages `~/.gitconfig`, `~/.bashrc`, `~/.ssh`, `~/.config/gh`, and custom files to `/content/drive/MyDrive/colab_backup.tar.gz`. |
| `./toolbox colab restore` | Restores files from Google Drive tarball to `$HOME` (silent overwrite, preserves permissions). |
| `./toolbox colab save -i <path>` | Include custom file or directory in backup archive. |
| `./toolbox colab save -a <path>` | Save to custom backup path. |

### `git` — Repository Hygiene & Commit Helpers

| Command | Description |
|---|---|
| `./toolbox git diff-sum` | Colorized summary of staged, unstaged, and untracked files with line diff stats. |
| `./toolbox git commit` | Interactive helper to draft Conventional Commits (`feat`, `fix`, `docs`, etc.). |
| `./toolbox git clean` | Safely detects and purges cache directories (`__pycache__`, `.pytest_cache`) and temp files. |

### `audit` — Code Quality & Security Auditing

| Command | Description |
|---|---|
| `./toolbox audit check` | Validates bash syntax (`bash -n`), verifies script permissions, and scans for secret leaks. |

---

## 🤖 AI Agent Integration

This repository includes native skills and rulesets to supercharge AI coding assistants:

### Operating Manual (`AGENTS.md`)
- **[`AGENTS.md`](file:///content/toolbox/AGENTS.md)**: Authoritative architecture blueprint, verification runbook, and non-negotiable boundaries for autonomous agents.

### Rulesets (`agent/rules/`)
- **[`interaction.md`](file:///content/toolbox/agent/rules/interaction.md)**: 3-Phase collaboration protocol (Explore=Mentor, Plan=Grill, Code=Execute) and the Zero-Guessing rule ("Grill, don't guess").
- **[`safety.md`](file:///content/toolbox/agent/rules/safety.md)**: Safe autonomous behavior, credential protection, and confirmation protocols.
- **[`code-quality.md`](file:///content/toolbox/agent/rules/code-quality.md)**: Polyglot engineering standards, Systems/Rust rules, and uniform documentation density.
- **[`git.md`](file:///content/toolbox/agent/rules/git.md)**: Conventional Commits standard and atomic diff hygiene.

### Agent Skills (`agent/skills/`)
- **[`advanced-programmer/SKILL.md`](file:///content/toolbox/agent/skills/advanced-programmer/SKILL.md)**: Senior full-stack & systems engineering standards across Architecture, Systems/Rust, Code Review, Testing, Debugging, Documentation, README/AGENTS.md authoring, Changelogs, UX/DX, and DevOps.
- **[`toolbox/SKILL.md`](file:///content/toolbox/agent/skills/toolbox/SKILL.md)**: Full navigation guide for agents to run and manage toolbox commands.
- **[`git-assistant/SKILL.md`](file:///content/toolbox/agent/skills/git-assistant/SKILL.md)**: Diff analysis, conventional commit authoring, and branch hygiene.
- **[`code-auditor/SKILL.md`](file:///content/toolbox/agent/skills/code-auditor/SKILL.md)**: Static analysis, syntax verification, and secret scanning.

---

## 📜 Release History

See **[`CHANGELOG.md`](file:///content/toolbox/CHANGELOG.md)** for detailed release notes adhering to the Keep a Changelog standard.

---

## ➕ Adding New Tools

To add a new tool to any category (or create a new category):

1. Create a script in `tools/<category>/<tool_name>`:
   ```bash
   #!/usr/bin/env bash
   # Description: A short 1-line description of what this tool does
   set -eo pipefail

   TOOLBOX_ROOT="$(cd -P "$(dirname "${BASH_SOURCE[0]}")/../.." >/dev/null 2>&1 && pwd)"
   source "${TOOLBOX_ROOT}/tools/lib/common.sh"

   log_header "My New Tool"
   # Your logic here
   ```
2. Make it executable:
   ```bash
   chmod +x tools/<category>/<tool_name>
   ```
3. Run `./toolbox <category> <tool_name>` — the dispatcher detects it immediately!

---

## 📄 License

MIT
