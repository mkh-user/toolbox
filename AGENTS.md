# AGENTS.md — Repository Guidance for Autonomous AI Assistants

Welcome to `toolbox`. This file serves as the definitive operating manual and behavioral specification for AI coding assistants working within this repository and across target projects.

---

## System Architecture and Mental Model

`toolbox` is a standalone, polyglot developer and AI agent toolkit designed to run anywhere with zero mandatory external dependencies.

```mermaid
flowchart TD
    CLI["<b>Root CLI Dispatcher</b><br/>./toolbox"] --> Setup["<b>setup</b><br/>gh, agy, colab, status"]
    CLI --> Colab["<b>colab</b><br/>save, restore"]
    CLI --> SkillsTool["<b>skills</b><br/>list, show"]
    CLI --> Audit["<b>audit</b><br/>check"]
    CLI --> Lib["<b>lib</b><br/>common.sh"]
    
    Agents["<b>AI Agents and Assistants</b>"] -.-> Rules["<b>agent/rules</b><br/>interaction, safety, code-quality, git"]
    Agents -.-> Skills["<b>agent/skills</b><br/>advanced-programmer, git-assistant, code-auditor, toolbox"]
```

### Key Principles
- **Dynamic Auto-Discovery**: Every executable script placed in `tools/<category>/` with a `# Description:` header is dynamically registered by `./toolbox`.
- **Zero Global Dependency Requirement**: Core utilities run on standard Bash and POSIX utilities without requiring global pip package installations.
- **Strict Category Namespacing**: Commands are invoked via `./toolbox <category> <command> [args...]`.

---

## Quick Verification Runbook

Always verify repository health before and after completing any work:

```bash
# Run comprehensive multi-repo code, syntax, permission, link, and security audit
./toolbox audit check [path]

# Execute automated test suite
./tests/run_tests.sh

# Check working tree status with native git
git status -s

# Test top-level CLI dispatcher auto-discovery
./toolbox --help

# Test category commands
./toolbox setup status
./toolbox colab --help
./toolbox skills list
```

### Verification Suite and Target Path Support
- **Multi-Repo Static Audit**: `./toolbox audit check [path]` performs an exhaustive audit of bash syntax, script executable permissions, git tracking collisions, credential leaks, heading typography laws, and relative markdown link integrity across the specified directory (defaults to `$PWD` if omitted).
- **Automated Regression Suite**: `./tests/run_tests.sh` executes the zero-dependency test runner covering CLI dispatching, dynamic category auto-discovery, skill rendering, and multi-repo static audits.
- **Continuous Integration Pipeline**: `.github/workflows/ci.yml` executes `./toolbox audit check` and `./tests/run_tests.sh` on every push and pull request to `main` using least-privilege `permissions: contents: read` and dynamically verified `actions/checkout@v7`.

---

## Non-Negotiable Red Lines

- **The Zero-Guessing Rule**: If user instructions contain ambiguity, multiple architectural paths, or unstated preferences, never assume. Pause and use the question tool to interrogate and align on the decision.
- **Three-Phase Interaction Protocol**:
  - **Exploring**: Mentor with deep architectural context and trade-offs.
  - **Planning**: Grill like a devil's advocate before starting implementation.
  - **Implementing**: Execute direct, razor-sharp, with zero conversational fluff.
- **Zero Secret and Credential Leaks**:
  - Never print, hardcode, log, or commit tokens, OAuth credentials, private keys, or passwords.
  - Rely strictly on environment variables or secure storage such as Google Colab Userdata.
- **No Unchecked Unwraps or Swallowed Errors**:
  - Never catch errors without logging or handling them.
  - No `.unwrap()` or `.expect()` in production systems code.
- **Ask Before Destructive Operations**:
  - Overwriting non-temporary files, force-pushing, or deleting directories requires explicit user confirmation.
- **Documentation Integrity**:
  - When updating features, update `README.md`, `CHANGELOG.md`, and relevant skills concurrently.

---

## Directory Sitemap and Responsibilities

```
toolbox/
├── toolbox                      # Unified root CLI dispatcher
├── AGENTS.md                    # Operating specification for AI agents
├── CHANGELOG.md                 # Semantic version history
├── CONTRIBUTING.md              # Contributor guide and PR standards
├── SECURITY.md                  # Vulnerability reporting policy
├── README.md                    # User manual and reference tables
├── .github/                     # Issue templates and GitHub Actions CI
│   ├── ISSUE_TEMPLATE/         # Bug and feature request issue templates
│   ├── PULL_REQUEST_TEMPLATE.md# Pull request checklist
│   └── workflows/
│       └── ci.yml              # Automated continuous integration pipeline
├── tests/                       # Automated regression test suite
│   └── run_tests.sh            # Zero-dependency Bash test runner
├── tools/                       # Category-namespaced executable CLI tools
│   ├── lib/
│   │   └── common.sh           # Sourced helper library
│   ├── setup/                  # Environment bootstrapping
│   │   ├── status              # Credentials and mount auditor
│   │   ├── colab               # Drive mount, gh login, agy restore
│   │   ├── gh                  # GitHub CLI login via Colab Secrets
│   │   └── agy                 # Backup and restore Antigravity tokens
│   ├── colab/                  # Cloud runtime persistence
│   │   ├── save                # Backup dotfiles to Google Drive tarball
│   │   └── restore             # Restore files from Google Drive tarball
│   ├── skills/                 # Agent skill discovery and inspection
│   │   ├── list                # List registered skills with YAML descriptions
│   │   └── show                # Display full documentation for a skill
│   └── audit/                  # Repository auditing
│       └── check               # Multi-repo syntax, permissions, links, and secret scanner
└── agent/                       # Agent intelligence assets
    ├── rules/                  # Behavioral and coding rulesets
    │   ├── interaction.md      # Collaboration and zero-guessing rules
    │   ├── safety.md           # Safety, credential protection boundaries
    │   ├── code-quality.md     # Polyglot, systems, and doc standards
    │   └── git.md              # Conventional Commits and diff hygiene
    └── skills/                 # Antigravity agent skills
        ├── toolbox/            # Skill for toolbox command execution
        ├── git-assistant/      # Git hygiene and diff analysis
        ├── code-auditor/       # Static code quality and secret detection
        ├── advanced-programmer/# Senior full-stack and systems standards
        ├── readme-architect/   # High-signal README authoring
        ├── agents-architect/   # AGENTS.md authoring and safe evolution
        ├── repo-governance/    # Open-source health and unbroken link chain
        ├── release-architect/  # GitHub release bodies and migration guides
        ├── security-hardener/  # Secret defense and supply-chain audits
        ├── root-cause-debugger/# Forensic debugging and invariant repairs
        ├── devops-architect/   # CI design and toolchain pinning
        └── workflow-scaffolder/# Reusable CLI script scaffolding
```

---

## Agent Intelligence Resources

### Operating Rules
- **[interaction.md](agent/rules/interaction.md)**: Collaboration protocol, grilling mode, and zero-guessing standards.
- **[safety.md](agent/rules/safety.md)**: Principle of least privilege, zero credential leaks, and destructive action gating.
- **[code-quality.md](agent/rules/code-quality.md)**: Polyglot engineering standards, rust/systems invariants, and doc density.
- **[git.md](agent/rules/git.md)**: Atomic diff hygiene and conventional commit authoring.

### Registered Agent Skills
- **[toolbox](agent/skills/toolbox/SKILL.md)**: Toolbox CLI discovery, execution, and category navigation.
- **[git-assistant](agent/skills/git-assistant/SKILL.md)**: Git status inspection, branch hygiene, and commit authoring.
- **[code-auditor](agent/skills/code-auditor/SKILL.md)**: Static code quality, script permissions, and secret scanning.
- **[advanced-programmer](agent/skills/advanced-programmer/SKILL.md)**: Senior systems, backend, and full-stack development patterns.
- **[readme-architect](agent/skills/readme-architect/SKILL.md)**: Authoring anti-hype, high-signal README files.
- **[agents-architect](agent/skills/agents-architect/SKILL.md)**: Authoring and safely evolving AGENTS.md operating specifications.
- **[repo-governance](agent/skills/repo-governance/SKILL.md)**: Open-source health checklists and the unbroken link graph.
- **[release-architect](agent/skills/release-architect/SKILL.md)**: Drafting semantic GitHub release bodies, migration guides, and release gates.
- **[security-hardener](agent/skills/security-hardener/SKILL.md)**: Secret defense, credential isolation, and memory-safe design.
- **[root-cause-debugger](agent/skills/root-cause-debugger/SKILL.md)**: Forensic debugging, minimal reproducible examples, and invariant repair.
- **[devops-architect](agent/skills/devops-architect/SKILL.md)**: CI workflows, GitHub Actions security, and toolchain pinning.
- **[workflow-scaffolder](agent/skills/workflow-scaffolder/SKILL.md)**: Scaffolding reusable, self-documenting CLI scripts.

---

## Adding or Modifying Tools

To add a new tool:
1. Choose an appropriate category under `tools/<category>/` or create a new category folder.
2. Create the executable script:
   ```bash
   #!/usr/bin/env bash
   # Description: <Brief one-line summary for auto-discovery>
   set -eo pipefail
   TOOLBOX_ROOT="$(cd -P "$(dirname "${BASH_SOURCE[0]}")/../.." >/dev/null 2>&1 && pwd)"
   source "${TOOLBOX_ROOT}/tools/lib/common.sh"
   # Implementation...
   ```
3. Grant execution permissions: `chmod +x tools/<category>/<command>`.
4. Run `./toolbox audit check` to ensure syntax, permissions, and security pass cleanly.
5. Document the tool in `README.md` and record the change in `CHANGELOG.md`.
