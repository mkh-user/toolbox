# Git Standards & Workflow Rules

Conventions for version control, commit message structuring, clean history maintenance, and PR hygiene.

## 1. Conventional Commits Standard
All commit messages must follow the Conventional Commits specification:
```
<type>(<scope>): <short imperative description>

[optional detailed body explaining why and what changed]

[optional footer(s), e.g., Closes #123]
```

### Allowed Types:
- `feat`: A new feature or user-facing tool.
- `fix`: A bug fix or patch.
- `docs`: Documentation changes only (README, comments, docstrings).
- `style`: Formatting, missing semi-colons, whitespace (no code change).
- `refactor`: Code refactoring without adding features or fixing bugs.
- `perf`: Performance improvements.
- `test`: Adding or correcting tests.
- `chore`: Maintenance tasks, dependency updates, build tooling.

### Rules for the Subject Line:
- Use the imperative mood ("add", "fix", "support", NOT "added", "fixes", "adding").
- Do not capitalize the first letter following the type prefix.
- Do not end with a period (`.`).
- Keep the first line under 72 characters.

## 2. Commit Hygiene & Atomic Commits
- **Atomic Changes**: Group related modifications into coherent, self-contained commits. Do not mix unrelated refactors with new features.
- **Diff Inspection**: Always run `git status` and review `git diff --cached` before committing to avoid staging accidental temporary files or debug artifacts.
- **No Build Artifacts**: Never commit `.pyc`, `__pycache__`, `.DS_Store`, build outputs, or scratch files.

## 3. Branching & PR Etiquette
- Use descriptive branch names: `feature/<feature-name>`, `fix/<issue-name>`, `docs/<topic>`.
- Pull and rebase frequently from the main branch to minimize merge conflicts.
