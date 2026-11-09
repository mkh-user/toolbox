# Contributing to Toolbox

Thank you for contributing to `toolbox`. This project provides professional-grade tools, agent rules, and skills engineered to run everywhere with zero mandatory dependencies.

---

## Architecture and Mental Model

Before making changes, review [AGENTS.md](AGENTS.md) and [README.md](README.md) to understand repository architecture, category namespacing, and non-negotiables:

- **Zero Global Dependencies**: Core utilities must run on standard Bash and POSIX utilities.
- **Dynamic Auto-Discovery**: Every tool in `tools/<category>/` must include a `# Description:` header.
- **Strict Category Namespacing**: Commands follow `./toolbox <category> <command>`.

---

## Local Development Workflow

Clone the repository and inspect health before beginning work:

```bash
git clone https://github.com/mkh-user/toolbox.git
cd toolbox

# Verify syntax, permissions, and security
./toolbox audit check

# Run automated tests
./tests/run_tests.sh

# Review current branch and working tree state
git status -s
```

---

## Conventional Commits

All commits must follow the [Conventional Commits](agent/rules/git.md) specification:

```
<type>(<scope>): <short imperative description>
```

### Allowed Types
- `feat`: New features or user-facing tools.
- `fix`: Bug fixes or patches.
- `docs`: Documentation updates.
- `style`: Formatting and whitespace changes.
- `refactor`: Internal code changes without feature or bug impact.
- `perf`: Performance improvements.
- `test`: Adding or updating tests.
- `chore`: Maintenance tasks and toolchain updates.

Example commit command:
```bash
git commit -m "feat(skills): add automated verification runner"
```

---

## Pull Request Standards

- **Atomic Diffs**: Group related modifications into self-contained commits. Do not mix unrelated refactors with new features.
- **Zero Orphaned Files**: Every new document, rule, or skill must be linked from [AGENTS.md](AGENTS.md) and [README.md](README.md).
- **Documentation Concurrency**: Update `README.md`, `CHANGELOG.md`, and relevant skills concurrently with any user-facing change.
- **Verification Gate**: Pull requests must pass `./toolbox audit check` with zero errors and zero warnings.

---

## Security Inquiries

To report a vulnerability or credential leak, please refer to our [Security Policy](SECURITY.md).
