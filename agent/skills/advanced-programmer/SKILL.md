---
name: advanced-programmer
description: Senior full-stack engineering standards: Clean Code, Code Review, Testing, Systematic Debugging, In-Code & User Documentation, UX/DX, Content Generation, and DevOps.
---

# Advanced Programmer Skill

This skill defines the engineering discipline, architectural principles, and execution standards required for senior-grade software development.

---

## 1. Code Architecture & Implementation
- **Separation of Concerns**: Isolate core domain logic from CLI presentation, file I/O, and external APIs.
- **Defensive & Resilient Design**:
  - Validate inputs and boundaries early (fail fast).
  - Handle external resource failures (network disconnects, missing files, permission denials) gracefully.
  - Write idempotent operations wherever possible.
- **KISS & YAGNI**: Avoid over-engineering, unnecessary abstractions, or heavyweight dependencies when clean, readable standard-library implementations suffice.

---

## 2. Rigorous Code Review
- **Security & Hygiene First**:
  - Scan for secret leakage, SQL/command injection vulnerabilities, unvalidated user input, and unsafe shell expansions.
- **Performance & Complexity**:
  - Scrutinize time complexity (O(N) vs O(N²)), file handle leaks, unbounded loops, and memory bloat.
- **Maintainability & Readability**:
  - Verify meaningful naming, clear structure, and absence of dead or copy-pasted code.

---

## 3. Test Engineering & Verification
- **Verification Before Completion**: Never assume code works because it looks right—run and verify it.
- **Test Scenarios**:
  - Happy path: Primary expected inputs and workflows.
  - Edge cases: Empty inputs, missing files, non-standard flags, large datasets.
  - Failure modes: Permission errors, missing commands, invalid formats.
- **Deterministic Testing**: Tests must be hermetic and reproducible without depending on volatile external services.

---

## 4. Systematic Root-Cause Debugging
- **Observe, Don't Guess**: Formulate hypotheses based on exact error messages, stack traces, and exit codes.
- **Minimal Reproduction**: Isolate the smallest command or snippet that reproduces the issue.
- **Fix the Cause, Not Just the Symptom**: Address the underlying logic or assumption failure rather than applying cosmetic band-aids.
- **Regression Prevention**: Whenever a bug is fixed, ensure a test or verification step validates that it cannot reoccur.

---

## 5. Documentation & Technical Communication
- **In-Code Documentation**:
  - Provide concise docstrings and header comments explaining *why* an approach was taken, not just what the code does.
  - Keep comments synchronized with code changes (maintain documentation integrity).
- **User & Developer Manuals**:
  - Structure `README.md` and guides with clear value propositions, quick starts, copy-pasteable commands, and troubleshooting sections.
- **CLI Help Systems**:
  - Every CLI script must provide `--help` detailing usage syntax, argument definitions, default values, and concrete examples.

---

## 6. Content Generation (UI, Web & Technical Copy)
- **Clarity & Tone**: Professional, direct, action-oriented, and free of fluff or buzzwords.
- **Information Hierarchy**: Lead with the most important action/metric first; use progressive disclosure for deep details.
- **User-Centric UI Copy**: Error messages must state:
  1. What happened.
  2. Why it happened.
  3. The exact command or step to fix it.

---

## 7. User Experience (UX) & Developer Ergonomics (DX)
- **Immediate Feedback**: Long-running operations must provide progress indicators or status milestones.
- **Non-Destructive Defaults**: Default to safe operations; require explicit flags or confirmation prompts for irreversible actions.
- **Predictable CLI Conventions**: Support standard POSIX flags (`-h`, `--help`, `-v`, `--version`), respect terminal capabilities (disable ANSI codes when output is redirected), and return standard exit codes.

---

## 8. Simple DevOps & Reproducibility
- **Portable Environments**: Scripts must run across standard environments (Linux, Colab, WSL, macOS) without assumptions about pre-installed third-party packages.
- **Automated Verification**: Provide single-command health audits (`./toolbox audit check`) suitable for local verification and CI pipelines (GitHub Actions).
