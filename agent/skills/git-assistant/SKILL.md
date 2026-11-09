---
name: git-assistant
description: Automates Git operations, diff analysis, conventional commit authoring, and branch hygiene checks.
---

# Git Assistant Skill

This skill guides AI agents and developers in maintaining a clean git repository, writing standardized conventional commit messages, and conducting pre-commit diff hygiene using native Git commands.

---

## Core Capabilities

- **Diff Summarization**: Rapidly analyzes staged and unstaged changes, identifying files added, modified, or deleted, and summarizing semantic intent.
- **Conventional Commit Generation**: Drafts accurate, conventional commit messages adhering to repository guidelines (`feat`, `fix`, `docs`, `refactor`, `chore`).
- **Branch and Repository Hygiene**: Scans for dangling untracked files, stale caches, and merged branches.

---

## Standard Git Operations

Use native Git commands to inspect and maintain repository hygiene:

```bash
# Summarize working tree changes and stats
git status -s
git diff --stat

# Inspect staged changes before authoring commit
git diff --cached

# Purge untracked cache directories
git clean -fdX
```

---

## Agent Guidelines

- Before generating a commit, run `git status` and `git diff --cached` to inspect exact modifications.
- Verify that no credentials, tokens, or temporary files are staged.
- Ensure the commit type matches the primary nature of the modification:
  - New tools or user capabilities: `feat`
  - Bug fixes or regressions: `fix`
  - Documentation updates: `docs`
  - Internal cleanup without behavioral change: `refactor`
