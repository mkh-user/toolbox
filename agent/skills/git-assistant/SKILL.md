---
name: git-assistant
description: Automates Git operations, diff analysis, conventional commit authoring, and branch hygiene checks.
---

# Git Assistant Skill

This skill guides AI agents and developers in maintaining a clean git repository, writing standardized conventional commit messages, and conducting pre-commit diff hygiene.

## Core Capabilities

1. **Diff Summarization**: Rapidly analyzes staged and unstaged changes, identifying files added, modified, or deleted, and summarizing semantic intent.
2. **Conventional Commit Generation**: Drafts accurate, conventional commit messages adhering to repository guidelines (`feat`, `fix`, `docs`, `refactor`, `chore`).
3. **Branch & Repository Hygiene**: Scans for dangling untracked files, stale caches, and merged branches.

## Companion CLI Commands

The repository provides native CLI tools backing this skill:

```bash
# Summarize current working tree changes
./toolbox git diff-sum

# Smart interactive conventional commit helper
./toolbox git commit

# Clean untracked caches and temporary files safely
./toolbox git clean
```

## Agent Guidelines

- Before generating a commit, run `git status` and `git diff --cached` (or `./toolbox git diff-sum`) to inspect exact modifications.
- Verify that no credentials, tokens, or temporary files are staged.
- Ensure the commit type matches the primary nature of the modification:
  - New tools / user capabilities -> `feat`
  - Bug fixes / regressions -> `fix`
  - Documentation updates -> `docs`
  - Internal cleanup without behavioral change -> `refactor`
