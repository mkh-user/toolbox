# Changelog

All notable changes to the `toolbox` repository are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]

---

## [0.1.0] - 2026-11-09

### Added
- **Dynamic CLI Dispatcher (`./toolbox`)**: Zero-dependency executable CLI with automated category discovery and formatted command listings.
- **Shared Scripting Library (`tools/lib/common.sh`)**: ANSI terminal color formatting, structured loggers (`info`, `success`, `warn`, `error`), command validators, and interactive confirmation helpers.
- **Environment & Credential Bootstrap (`tools/setup/`)**:
  - `status`: Non-destructive inspection of Google Drive mount, Colab Secrets, GitHub CLI auth, and Antigravity tokens.
  - `colab`: Single-command environment initialization (mounts Drive, configures `gh`, and restores `agy` token).
  - `gh`: Secure authentication for GitHub CLI using `GH_TOKEN` loaded strictly from Google Colab Secrets (`userdata`).
  - `agy`: Backup and restoration tool for Antigravity OAuth tokens (`~/.gemini/antigravity-cli/antigravity-oauth-token`) to Google Drive.
- **Runtime Persistence (`tools/colab/`)**:
  - `save`: Archives dotfiles (`~/.gitconfig`, `~/.bashrc`, `~/.ssh/`, `~/.config/gh/`) and custom manifest paths into `/content/drive/MyDrive/colab_backup.tar.gz`.
  - `restore`: Silent one-step extraction to `$HOME` with automated SSH key permission hardening (`chmod 700 / 600`).
- **Git Hygiene & Commit Automation (`tools/git/`)**:
  - `diff-sum`: Formatted breakdown of staged, unstaged, and untracked changes with diff line counts.
  - `commit`: Conventional Commit authoring tool with interactive type/scope prompts and flag-based arguments.
  - `clean`: Safe detection and cleanup of `__pycache__`, `.pytest_cache`, and temporary files with dry-run confirmation.
- **Code Quality & Security Auditing (`tools/audit/`)**:
  - `check`: Automated static validation of bash syntax (`bash -n`), tool file permissions, and credential leak scanning.
- **Agent Rules & Intelligence Assets (`agent/rules/`)**:
  - `interaction.md`: Mandates the Three-Phase collaboration workflow (Mentor, Grill, Execute) and the Zero-Guessing Rule ("Grill, Don't Guess").
  - `code-quality.md`: Polyglot standards, Systems/Rust rules (Clippy `-D warnings`, zero unwrap, `thiserror`/`anyhow`), and uniform documentation density.
  - `safety.md`: Credential protection protocols and non-destructive execution guidelines.
  - `git.md`: Conventional Commits specification and diff hygiene standards.
- **Agent Skills (`agent/skills/`)**:
  - `advanced-programmer`: Comprehensive senior engineering standards across Architecture, Systems/Rust, Code Review, Testing, Debugging, Documentation, README/AGENTS.md authoring, Changelogs, UX/DX, and DevOps.
  - `toolbox`: Agent navigation and CLI usage reference.
  - `git-assistant`: Working tree diff analysis and commit authoring.
  - `code-auditor`: Automated static analysis and security scanning.
- **Repository Documentation**:
  - `AGENTS.md`: Authoritative operating manual and architecture blueprint for autonomous AI assistants.
  - `README.md`: High-signal, anti-hype user guide with quick start commands and reference tables.
