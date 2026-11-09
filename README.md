# Toolbox

> Standalone, zero-dependency developer toolkit and AI agent operating framework.

A modular, polyglot command center engineered for portability across Linux environments, Google Colab, and remote machines with zero mandatory dependencies.

---

## Quick Start

Clone and run in-place without installing packages:

```bash
git clone https://github.com/mkh-user/toolbox.git
cd toolbox

# Show all available categories and commands
./toolbox --help

# Run non-destructive environment and credentials check
./toolbox setup status

# Full Colab environment initialization
./toolbox setup colab

# Inspect all registered agent skills
./toolbox skills list
```

---

## Why It Is Built This Way

`toolbox` is designed around deliberate architectural choices that prioritize portability, developer ergonomics, and agent steerability:

### Bash and POSIX for Core Utilities
Developer tooling must run everywhere. By relying strictly on standard Bash and POSIX utilities for core execution, `toolbox` runs immediately on fresh Google Colab instances, remote SSH containers, and clean Linux distributions without requiring global pip installations, virtual environments, or compilation steps.

### Dynamic Directory Auto-Discovery
Adding a tool should require zero boilerplate. Any executable script placed in `tools/<category>/` with a `# Description:` header is dynamically registered by `./toolbox`. There are no centralized registry files to update and no CLI compilation steps.

### Strict Category Namespacing
Commands follow a predictable hierarchy: `./toolbox <category> <command> [args...]`. This prevents global command name collisions, organizes tools by domain, and allows both humans and AI agents to discover commands systematically.

### Thoughtful Defaults
- Drive not mounted? `./toolbox setup colab` detects and initializes Google Drive access.
- GitHub token needed? `./toolbox setup gh` retrieves credentials strictly from Colab Userdata secrets without terminal exposure.
- Code health? `./toolbox audit check` verifies bash syntax, permissions, secret hygiene, and relative link integrity.
- Script permissions dropped? `./toolbox audit check` audits executable bits and flags missing permissions.

### Why Toolbox Instead of Existing Alternatives
- Dotfile Managers such as Chezmoi or Dotbot: Excellent tools for managing symlinked configuration files across machines. What they do not provide is an autonomous AI agent operating manual, runtime credential bootstrapping, or cross-repo skill governance. Toolbox provides a unified operational framework.
- Global Pip and Node Packages: Prone to Python version conflicts, broken system packages, and slow network installation during transient cloud sessions. Toolbox starts instantaneously with zero external dependencies.
- Ad-Hoc Scripts and Gists: Hard to maintain, audit, or discover. Toolbox wraps standalone scripts in a dynamic CLI dispatcher with static bash syntax validation and secret scanning.

### Scope and Focus
- Lightweight and Portable: Dedicated to developer productivity, runtime persistence, and multi-repo AI agent guidance.
- Not a Heavyweight Framework: Toolbox does not enforce intrusive runtime dependencies or dictate how target projects build their software.
- Active Development: Features and agent skills evolve continuously to incorporate real-world systems engineering workflows.

### Who It Is For
- Systems and polyglot engineers working across Colab, cloud runtimes, and local environments.
- Developers collaborating with autonomous AI coding assistants who require high-signal communication, rigorous systems standards, and zero guesswork.

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
├── .github/                     # Issue templates and GitHub Actions CI
│   ├── ISSUE_TEMPLATE/         # Bug and feature request templates
│   ├── PULL_REQUEST_TEMPLATE.md# Contributor PR checklist
│   └── workflows/
│       └── ci.yml              # Automated continuous integration pipeline
├── tests/                       # Automated regression test suite
│   └── run_tests.sh            # Zero-dependency Bash test runner
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
│   ├── skills/                 # Agent skill discovery and inspection
│   │   ├── list                # List registered skills with YAML descriptions
│   │   └── show                # Display full documentation for a skill
│   └── audit/                  # Code quality and security checks
│       └── check               # Multi-repo syntax, permissions, links, and secret scan
└── agent/                       # AI Agent integration assets
    ├── skills/                 # Agent operational skills
    └── rules/                  # Behavioral and coding rulesets
```

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

### Skill Inspection and Discovery

| Command | Description |
|---|---|
| `./toolbox skills list` | Lists all registered agent skills with descriptions parsed from YAML frontmatter. Supports `-q <query>` and `-j/--json`. |
| `./toolbox skills show <skill>` | Displays full operational documentation and guidelines for a specified skill. Supports `--raw`. |

### Code Quality and Security Auditing

| Command | Description |
|---|---|
| `./toolbox audit check [path]` | Validates bash syntax, script permissions, git tracking, secret leaks, heading laws, and relative links across the specified repository (defaults to current working directory). |
| `./tests/run_tests.sh` | Zero-dependency automated regression test suite covering dispatcher discovery, skill rendering, and multi-repo static audits. |

---

## AI Agent Integration

This repository includes native skills and rulesets to steer AI coding assistants across any project:

### Operating Manuals and Governance
- **[AGENTS.md](AGENTS.md)**: Operating manual, verification runbook, and non-negotiables for autonomous assistants.
- **[CONTRIBUTING.md](CONTRIBUTING.md)**: Human contributor standards and pull request expectations.
- **[SECURITY.md](SECURITY.md)**: Vulnerability disclosure and credential safety protocols.
- **[CHANGELOG.md](CHANGELOG.md)**: Version history adhering to the Keep a Changelog standard.

### Rulesets
- **[interaction.md](agent/rules/interaction.md)**: Three-phase collaboration protocol and the Zero-Guessing rule.
- **[safety.md](agent/rules/safety.md)**: Safe autonomous behavior, credential protection, and confirmation protocols.
- **[code-quality.md](agent/rules/code-quality.md)**: Polyglot engineering standards, Systems and Rust rules, and uniform doc density.
- **[git.md](agent/rules/git.md)**: Conventional Commits standard and atomic diff hygiene.

### Agent Skills
- **[advanced-programmer](agent/skills/advanced-programmer/SKILL.md)**: Senior full-stack and systems engineering standards.
- **[readme-architect](agent/skills/readme-architect/SKILL.md)**: Authoring anti-hype, high-signal README files.
- **[agents-architect](agent/skills/agents-architect/SKILL.md)**: Creating and safely evolving AGENTS.md manuals.
- **[repo-governance](agent/skills/repo-governance/SKILL.md)**: Open-source repository health and the unbroken link graph.
- **[release-architect](agent/skills/release-architect/SKILL.md)**: High-impact GitHub release bodies, migration guides, and release gates.
- **[security-hardener](agent/skills/security-hardener/SKILL.md)**: Secret zero-leakage, dependency CVE audits, and memory safety.
- **[root-cause-debugger](agent/skills/root-cause-debugger/SKILL.md)**: Minimal reproducible examples, tracing, and invariant repair.
- **[devops-architect](agent/skills/devops-architect/SKILL.md)**: CI workflows, least-privilege permissions, and toolchain pinning.
- **[workflow-scaffolder](agent/skills/workflow-scaffolder/SKILL.md)**: Scaffolding reusable, self-documenting CLI tools.
- **[toolbox](agent/skills/toolbox/SKILL.md)**: Navigation and execution guide for the native toolbox CLI.
- **[git-assistant](agent/skills/git-assistant/SKILL.md)**: Diff analysis and conventional commit authoring.
- **[code-auditor](agent/skills/code-auditor/SKILL.md)**: Static analysis, syntax verification, and secret scanning.

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
