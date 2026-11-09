---
name: devops-architect
description: Guides authoring and maintaining GitHub Actions CI/CD workflows, toolchain pinning, caching strategies, and security-first pipeline design.
---

# DevOps Architect Skill

This skill defines standards for authoring, maintaining, and auditing continuous integration and delivery pipelines using GitHub Actions with maximum reproducibility, security, and dynamic dependency recency.

---

## Security and Principle of Least Privilege

Workflows execute arbitrary code with access to repository contexts. Strict permission boundaries are mandatory:

### Explicit Top-Level Permissions
- Every workflow file must define an explicit top-level `permissions:` block following least-privilege principles:
  ```yaml
  permissions:
    contents: read
  ```
- Never leave permissions unbounded or rely on permissive organization-wide defaults. Elevate permissions only on specific jobs that require them, such as release publishing.

### Dynamic Action Version Verification
- **Never Hardcode Stale Action Versions**: AI agents repeatedly default to obsolete versions from training memory (such as `@v2` or `@v4`).
- **Dynamic Query Requirement**: Before writing or updating any GitHub Actions workflow, query the GitHub API to discover the true, latest stable release tag:
  ```bash
  curl -sSL "https://api.github.com/repos/actions/checkout/releases/latest" | grep '"tag_name":'
  ```
- Always pin to the verified latest major release.

---

## Pipeline Performance and Fail-Fast Architecture

Optimize developer feedback loops by ordering jobs strategically:

### Staged Execution Order
Structure workflows so that fast, zero-cost static checks run before expensive compilation or integration tests:
- **Lint and Syntax**: Shellcheck, code formatting checks, and static audits.
- **Pedantic Compilation**: Type checking and strict compiler linter passes treating warnings as errors.
- **Unit and Property Tests**: Hermetic unit test execution.
- **Integration and Matrix Runs**: Multi-OS or multi-architecture builds.

### Hermetic Dependency Caching
- Cache dependency artifacts using cryptographic hash keys derived from canonical lockfiles:
  ```yaml
  key: ${{ runner.os }}-cargo-${{ hashFiles('**/Cargo.lock') }}
  ```
- Avoid unkeyed or overly broad cache restoration keys that could contaminate clean builds.

---

## Clean User Interface and Naming Standards

Workflows must be visually informative in the GitHub Actions UI:

### Full Naming Discipline
- Provide explicit, human-readable `name:` properties for every workflow, job, and step.
- Good: `name: "Verify Shell Script Syntax and Permissions"`
- Bad: omitting `name` or using uninformative keys like `run: ./check.sh`.

---

## Calibration and Golden Examples

### GitHub Actions CI Transformation

#### Generic LLM Workflow
```yaml
# Generic LLM: Missing permissions, outdated actions, no descriptive names, slow ordering
name: CI
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2 # Severely outdated!
      - uses: actions/setup-python@v2 # Severely outdated!
      - run: pip install -r requirements.txt
      - run: pytest
      - run: flake8 # Ran heavy tests before checking syntax!
```
*Why this fails*: Missing top-level `permissions:`, uses deprecated action tags from training memory (`@v2`), lacks descriptive names for UI visibility, and executes expensive tests before cheap linter gates.

#### Mahan Standard
```yaml
# Mahan Standard: Explicit permissions, dynamically verified latest actions, full naming, fail-fast order
name: "Continuous Integration"

on:
  push:
    branches: ["main"]
    paths-ignore: ["**.md", "docs/**"]
  pull_request:
    branches: ["main"]
    paths-ignore: ["**.md", "docs/**"]

permissions:
  contents: read

jobs:
  static-checks:
    name: "Static Code and Security Audit"
    runs-on: ubuntu-latest
    steps:
      - name: "Checkout Source Code"
        uses: actions/checkout@v7 # Dynamically verified latest stable major tag

      - name: "Validate Script Syntax and Secret Hygiene"
        run: ./toolbox audit check

  test-suite:
    name: "Hermetic Test Matrix"
    needs: [static-checks]
    runs-on: ubuntu-latest
    steps:
      - name: "Checkout Source Code"
        uses: actions/checkout@v7

      - name: "Restore Dependency Cache"
        uses: actions/cache@v4
        with:
          path: ~/.cache
          key: ${{ runner.os }}-deps-${{ hashFiles('**/lockfile') }}

      - name: "Execute Deterministic Unit Tests"
        run: ./run-tests.sh
```
*Why this succeeds*: Enforces least-privilege `contents: read`, uses verified latest major action tags, provides descriptive names for the GitHub Actions visual UI, filters unnecessary doc triggers, and enforces fail-fast pipeline gating.

---

## Agent Verification Checklist

Before publishing any workflow YAML:
- Confirm top-level `permissions:` block is present.
- Verify all action references use the latest stable major versions discovered dynamically.
- Ensure all job dependencies (`needs: [...]`) follow fail-fast ordering.
- Check that no sensitive secrets or tokens are echoed into step logs.
