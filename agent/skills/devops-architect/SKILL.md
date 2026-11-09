---
name: devops-architect
description: Guides authoring and maintaining GitHub Actions CI/CD workflows, toolchain pinning, caching strategies, and security-first pipeline design.
---

# DevOps Architect Skill

This skill defines standards for authoring, maintaining, and auditing continuous integration and delivery pipelines using GitHub Actions with maximum reproducibility and security.

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

### Modern and Verified Action Versions
- **Mandatory Action Recency**: AI agents frequently default to deprecated action versions from training data. Never use outdated major versions such as `actions/checkout@v2` or `v3`.
- Always verify and pin the current stable release, such as `actions/checkout@v4`.
- Regularly check action dependencies for security advisories and deprecation warnings.

---

## Pipeline Performance and Fail-Fast Architecture

Optimize developer feedback loops by ordering jobs strategically:

### Staged Execution Order
Structure workflows so that fast, zero-cost static checks run before expensive compilation or integration tests:
1. **Lint and Syntax**: Shellcheck, code formatting checks, and static audits.
2. **Pedantic Compilation**: Type checking and strict compiler linter passes treating warnings as errors.
3. **Unit and Property Tests**: Hermetic unit test execution.
4. **Integration and Matrix Runs**: Multi-OS or multi-architecture builds.

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

## Agent Verification Checklist

Before publishing any workflow YAML:
- Confirm top-level `permissions:` block is present.
- Verify all action references use the latest stable major versions.
- Ensure all job dependencies (`needs: [...]`) follow fail-fast ordering.
- Check that no sensitive secrets or tokens are echoed into step logs.
