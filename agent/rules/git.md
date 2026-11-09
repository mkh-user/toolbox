# Git Standards and Workflow Rules

Conventions for version control, commit message structuring, clean history maintenance, and pull request hygiene.

---

## Conventional Commits Standard

All commit messages must follow the Conventional Commits specification:
```
<type>(<scope>): <short imperative description>

[optional detailed body explaining why and what changed]

[optional footer, e.g., Closes #123]
```

### Allowed Types
- `feat`: A new feature or user-facing tool.
- `fix`: A bug fix or patch.
- `docs`: Documentation changes only.
- `style`: Formatting and whitespace with no code change.
- `refactor`: Code refactoring without adding features or fixing bugs.
- `perf`: Performance improvements.
- `test`: Adding or correcting tests.
- `chore`: Maintenance tasks, dependency updates, build tooling.

### Rules for the Subject Line
- Use the imperative mood: `add`, `fix`, `support`, not `added`, `fixes`, `adding`.
- Do not capitalize the first letter following the type prefix.
- Do not end with a period.
- Keep the first line under 72 characters.

---

## Commit Hygiene and Atomic Commits

- **Atomic Changes**: Group related modifications into coherent, self-contained commits. Do not mix unrelated refactors with new features.
- **Diff Inspection**: Always run `git status` and review staged changes before committing to avoid staging accidental temporary files or debug artifacts.
- **No Build Artifacts**: Never commit compiled artifacts, cache directories, or temporary scratch files.

---

## Branching and Pull Request Etiquette

- Use descriptive branch names: `feature/<feature-name>`, `fix/<issue-name>`, `docs/<topic>`.
- Pull and rebase frequently from the main branch to minimize merge conflicts.
