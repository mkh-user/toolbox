# Changelog

All notable changes to the `toolbox` repository are documented in this file.

The format is based on Keep a Changelog, and this project adheres to Semantic Versioning.

---

## Unreleased

### Added
- **Continuous Integration Pipeline**:
  - Added `.github/workflows/ci.yml` running static code/security audits and automated tests on pushes and PRs to `main` using least-privilege `contents: read` permissions and dynamically verified `actions/checkout@v7`.
- **Automated Regression Test Suite**:
  - Added zero-dependency Bash test runner `tests/run_tests.sh` executing hermetic regression tests across CLI dispatching, dynamic category auto-discovery, skill rendering, and multi-repo static audits.
- **Multi-Repo Audit and Target Path Support**:
  - `tools/audit/check` now accepts an optional target directory path argument (`./toolbox audit check [path]`), defaulting to the current working directory.
  - Added `--help` and `-h` flags to display full audit capabilities and parameter usage.
  - Added automated Heading Laws audit: detects and rejects numbered headings, parenthetical headings, and trailing punctuation in markdown files.
  - Added intra-document link checker: validates relative links and file references with zero broken links permitted.
  - Added git tracking audit: validates that all core scripts and libraries in `tools/` are trackable by version control and not blocked by `.gitignore`.

### Changed
- **Relative Link Migration**:
  - Converted all documentation references across `README.md`, `AGENTS.md`, `CONTRIBUTING.md`, `SECURITY.md`, and skills from absolute machine URIs to portable relative markdown links.

### Removed
- **Redundant Git Tool Wrappers**:
  - Dropped `tools/git/` wrapper scripts (`clean`, `commit`, `diff-sum`) in favor of native Git commands; updated `agent/skills/git-assistant/SKILL.md` and `toolbox` documentation accordingly.

### Fixed
- **OS Files Git Ignored**:
  - Added `.DS_Store`, Spotlight, and thumb files to `.gitignore`.
- **Git Ignore Inadvertent Library Matching**:
  - Resolved broad `lib/` pattern in `.gitignore` that was inadvertently ignoring `tools/lib/common.sh`, ensuring core shared utilities are tracked.
- **GitHub Community Templates**:
  - Added `.github/ISSUE_TEMPLATE/bug_report.md` structured around minimal reproducible examples and terminal logs.
  - Added `.github/ISSUE_TEMPLATE/feature_request.md` structured around problem statements, architectural proposals, and trade-offs.
  - Added `.github/PULL_REQUEST_TEMPLATE.md` enforcing Conventional Commits and `./toolbox audit check` verification gates.
- **Skill Discovery and Inspection Tooling**:
  - `list`: Dynamically parses YAML frontmatter from all skill definitions; supports query filtering and machine-readable JSON output.
  - `show`: Displays full operational documentation for any registered skill with clean terminal formatting and raw output option.
- **Specialized Authoring and Governance Skills**:
  - `readme-architect`: Authoring anti-hype README files with architectural trade-offs and verified examples.
  - `agents-architect`: Safely evolving `AGENTS.md` operating manuals with protected sections and pre-flight audits.
  - `repo-governance`: Ensuring open-source health checklists and the unbroken link reachability graph.
  - `release-architect`: Authoring anti-hype GitHub release bodies, breaking change migration guides, and pre-flight release gates.
  - `security-hardener`: Secret zero-leakage defense, dependency supply-chain audits, and memory-safety verification.
  - `root-cause-debugger`: Forensic debugging workflows, minimal reproducible examples, and invariant repairs.
  - `devops-architect`: GitHub Actions CI design, least-privilege permissions, and toolchain pinning.
  - `workflow-scaffolder`: Scaffolding reusable, self-documenting CLI scripts with standardized 5-part headers.
- **Repository Governance Suite**:
  - `CONTRIBUTING.md`: Human contributor guide covering conventional commits, branch hygiene, and verification gates.
  - `SECURITY.md`: Vulnerability disclosure policy and credential safety guidelines.
- **Heading and Typography Standards**:
  - Enforced repository-wide prohibition of numbered headings, parenthetical headings, and trailing punctuation.

---

## 0.1.0 - 2026-11-09

### Added
- **Dynamic CLI Dispatcher**: Zero-dependency executable CLI with automated category discovery and formatted command listings.
- **Shared Scripting Library**: ANSI terminal color formatting, structured loggers, command validators, and confirmation helpers.
- **Environment and Credential Bootstrap**:
  - `status`: Non-destructive inspection of Google Drive mount, Colab Secrets, GitHub CLI auth, and Antigravity tokens.
  - `colab`: Single-command environment initialization.
  - `gh`: Secure authentication for GitHub CLI using `GH_TOKEN` loaded from Colab Secrets.
  - `agy`: Backup and restoration tool for Antigravity OAuth tokens to Google Drive.
- **Runtime Persistence**:
  - `save`: Archives dotfiles and custom manifest paths into Google Drive tarball.
  - `restore`: Silent extraction to `$HOME` with automated SSH key permission hardening.
- **Git Hygiene and Commit Automation**:
  - `diff-sum`: Formatted breakdown of staged, unstaged, and untracked changes with diff line counts.
  - `commit`: Conventional Commit authoring tool with interactive prompts and flags.
  - `clean`: Safe detection and cleanup of cache directories and temporary files.
- **Code Quality and Security Auditing**:
  - `check`: Automated static validation of bash syntax, tool file permissions, and credential leak scanning.
- **Agent Rules and Intelligence Assets**:
  - `interaction.md`: Mandates the Three-Phase collaboration workflow and the Zero-Guessing Rule.
  - `code-quality.md`: Polyglot standards, Systems and Rust rules, and uniform documentation density.
  - `safety.md`: Credential protection protocols and non-destructive execution guidelines.
  - `git.md`: Conventional Commits specification and diff hygiene standards.
- **Agent Skills**:
  - `advanced-programmer`: Comprehensive senior engineering standards across Architecture, Systems, Code Review, Testing, Debugging, Documentation, and DevOps.
  - `toolbox`: Agent navigation and CLI usage reference.
  - `git-assistant`: Working tree diff analysis and commit authoring.
  - `code-auditor`: Automated static analysis and security scanning.
