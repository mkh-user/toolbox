# Toolbox

> Advanced skills and professional-grade tools to use everywhere.

A modular, standalone developer and AI agent toolkit engineered for portability across Linux environments, Google Colab, and remote machines with zero mandatory dependencies.

---

## Quick Start

Clone and run in-place without installing anything:

```bash
git clone https://github.com/mkh-user/toolbox.git
cd toolbox

# Show all available categories and commands
./toolbox --help

# Run non-destructive environment and credentials check
./toolbox setup status

# Full Colab environment initialization
./toolbox setup colab
```

---

## Architecture and Design

```
toolbox/
├── toolbox                      # Unified root CLI dispatcher
├── AGENTS.md                    # Operating manual for AI assistants
├── CHANGELOG.md                 # SemVer release history
├── CONTRIBUTING.md              # Contributor guidelines and PR standards
├── SECURITY.md                  # Security and disclosure policy
├── README.md                    # Primary user manual
├── tools/                       # Category-namespaced executable CLI tools
│   ├── lib/
│   │   └── common.sh           # Shared terminal formatting and logging
│   ├── setup/                  # Environment and credential bootstrapping
│   │   ├── status              # Status check for Drive, secrets, gh, agy
│   │   ├── colab               # Drive mount, gh login, agy restore
│   │   ├── gh                  # Secure GitHub CLI auth via Colab Secrets
│   │   └── agy                 # Backup and restore Antigravity tokens
│   ├── colab/                  # Runtime persistence, backup, and restore
│   │   ├── save                # Backup configs to Google Drive tarball
│   │   └── restore             # Restore state from Google Drive tarball
│   ├── git/                    # Git automation and hygiene helpers
│   │   ├── diff-sum            # Working tree summary with change stats
│   │   ├── commit              # Conventional commit helper
│   │   └── clean               # Safe cache and temp cleaner
│   ├── skills/                 # Agent skill discovery and inspection
│   │   ├── list                # List registered skills with YAML descriptions
│   │   └── show                # Display full documentation for a skill
│   └── audit/                  # Code quality and security checks
│       └── check               # Bash syntax, permissions, and secret scan
└── agent/                       # AI Agent integration assets
    ├── skills/                 # Agent operational skills
    └── rules/                  # Behavioral and coding rulesets
```

### Key Principles

- **Zero Global Dependencies**: All core scripts run directly with standard Bash and preinstalled system utilities.
- **Dynamic Auto-Discovery**: Dropping an executable script into `tools/<category>/` automatically exposes it in `./toolbox --help` and `./toolbox <category> --help` using its `# Description:` header.
- **Strict Namespacing**: Every command is scoped to its domain via `./toolbox <category> <command>`.
- **Agent Native**: Includes native skills and rulesets so LLM coding assistants discover and execute toolbox commands safely across any project.

---

## Command Reference

### Setup and Credential Bootstrapping

| Command | Description |
|---|---|
| `./toolbox setup status` | Non-destructive audit of Google Drive mount, Colab Secrets, GitHub CLI, and Antigravity tokens. |
| `./toolbox setup colab` | One-click setup: mounts Google Drive, authenticates `gh` via `GH_TOKEN` secret, and restores `agy` token. |
| `./toolbox setup gh` | Authenticates GitHub CLI using strictly the `GH_TOKEN` stored in Google Colab Secrets (`userdata`). |
| `./toolbox setup agy save` | Backs up local Antigravity token to Google Drive. |
| `./toolbox setup agy restore` | Restores Antigravity token from Google Drive to local config with `chmod 600`. |
| `./toolbox setup agy status` | Checks existence and validity of local and backup tokens. |

### Runtime Persistence and State Management

| Command | Description |
|---|---|
| `./toolbox colab save` | Packages dotfiles and custom manifest paths into `/content/drive/MyDrive/colab_backup.tar.gz`. |
| `./toolbox colab restore` | Restores files from Google Drive tarball to `$HOME` with automated SSH key permissions hardening. |
| `./toolbox colab save -i <path>` | Include custom file or directory in backup archive. |
| `./toolbox colab save -a <path>` | Save to custom backup path. |

### Git Hygiene and Commit Helpers

| Command | Description |
|---|---|
| `./toolbox git diff-sum` | Colorized summary of staged, unstaged, and untracked files with line diff stats. |
| `./toolbox git commit` | Interactive helper to draft Conventional Commits. |
| `./toolbox git clean` | Safely detects and purges cache directories and temp files with dry-run confirmation. |

### Skill Inspection and Discovery

| Command | Description |
|---|---|
| `./toolbox skills list` | Lists all registered agent skills with descriptions parsed from YAML frontmatter. Supports `-q <query>` and `-j/--json`. |
| `./toolbox skills show <skill>` | Displays full operational documentation and guidelines for a specified skill. Supports `--raw`. |

### Code Quality and Security Auditing

| Command | Description |
|---|---|
| `./toolbox audit check` | Validates bash syntax, verifies script permissions, and scans for secret leaks. |

---

## AI Agent Integration

This repository includes native skills and rulesets to steer AI coding assistants across any project:

### Operating Manuals and Governance
- **[AGENTS.md](file:///content/toolbox/AGENTS.md)**: Operating manual, verification runbook, and non-negotiables for autonomous assistants.
- **[CONTRIBUTING.md](file:///content/toolbox/CONTRIBUTING.md)**: Human contributor standards and pull request expectations.
- **[SECURITY.md](file:///content/toolbox/SECURITY.md)**: Vulnerability disclosure and credential safety protocols.
- **[CHANGELOG.md](file:///content/toolbox/CHANGELOG.md)**: Version history adhering to the Keep a Changelog standard.

### Rulesets
- **[interaction.md](file:///content/toolbox/agent/rules/interaction.md)**: Three-phase collaboration protocol and the Zero-Guessing rule.
- **[safety.md](file:///content/toolbox/agent/rules/safety.md)**: Safe autonomous behavior, credential protection, and confirmation protocols.
- **[code-quality.md](file:///content/toolbox/agent/rules/code-quality.md)**: Polyglot engineering standards, Systems and Rust rules, and uniform doc density.
- **[git.md](file:///content/toolbox/agent/rules/git.md)**: Conventional Commits standard and atomic diff hygiene.

### Agent Skills
- **[advanced-programmer](file:///content/toolbox/agent/skills/advanced-programmer/SKILL.md)**: Senior full-stack and systems engineering standards.
- **[readme-architect](file:///content/toolbox/agent/skills/readme-architect/SKILL.md)**: Authoring anti-hype, high-signal README files.
- **[agents-architect](file:///content/toolbox/agent/skills/agents-architect/SKILL.md)**: Creating and safely evolving AGENTS.md manuals.
- **[repo-governance](file:///content/toolbox/agent/skills/repo-governance/SKILL.md)**: Open-source repository health and the unbroken link graph.
- **[security-hardener](file:///content/toolbox/agent/skills/security-hardener/SKILL.md)**: Secret zero-leakage, dependency CVE audits, and memory safety.
- **[root-cause-debugger](file:///content/toolbox/agent/skills/root-cause-debugger/SKILL.md)**: Minimal reproducible examples, tracing, and invariant repair.
- **[devops-architect](file:///content/toolbox/agent/skills/devops-architect/SKILL.md)**: CI workflows, least-privilege permissions, and toolchain pinning.
- **[workflow-scaffolder](file:///content/toolbox/agent/skills/workflow-scaffolder/SKILL.md)**: Scaffolding reusable, self-documenting CLI tools.
- **[toolbox](file:///content/toolbox/agent/skills/toolbox/SKILL.md)**: Navigation and execution guide for the native toolbox CLI.
- **[git-assistant](file:///content/toolbox/agent/skills/git-assistant/SKILL.md)**: Diff analysis and conventional commit authoring.
- **[code-auditor](file:///content/toolbox/agent/skills/code-auditor/SKILL.md)**: Static analysis, syntax verification, and secret scanning.

---

## Adding New Tools

To add a new tool to any category or create a new category:

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
3. Run `./toolbox <category> <tool_name>` to test invocation.

---

## License

MIT
