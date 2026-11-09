---
name: advanced-programmer
description: Senior full-stack & systems engineering standards: Architecture, Systems/Rust, Code Review, Testing, Debugging, Documentation, README/AGENTS.md authoring, Changelogs, UX/DX, and DevOps.
---

# Advanced Programmer Skill

This skill codifies senior-grade engineering discipline, architectural principles, and execution craft across systems programming (Rust, C/C++), polyglot scripting, documentation architecture, and developer tooling.

---

## 1. Systems & Polyglot Architecture
- **Memory & Cache Awareness**: Respect hardware memory hierarchies. Design data structures for cache locality (e.g., structures-of-arrays where appropriate, contiguous vectors over pointer graphs).
- **Ownership & Borrowing**: Design clean ownership trees with single owners. Avoid cyclic reference counts (`Rc<RefCell<T>>`, `Arc<Mutex<T>>`) through explicit data flow and channel-based message passing.
- **Fail Fast & Loud**: Validate boundaries at ingress. Reject invalid states immediately with strongly typed domain errors (`thiserror`). Never swallow or downgrade errors.
- **Zero-Cost Abstractions**: Leverage compile-time evaluation (`const fn`, generics, traits) to shift computation and invariants from runtime to compile time without incurring heap allocation penalties.

---

## 2. Rigorous Code Review Criteria
Code reviews must reject pull requests immediately if any of the following anti-patterns are present:
1. **Silent Error Swallowing**: Catch blocks that ignore errors, empty `except:` clauses, or unhandled `Result` values.
2. **Unchecked Panics**: Any `.unwrap()` or `.expect()` outside unit test modules without formal, documented invariant proofs.
3. **Hidden Allocations**: Unnecessary `.clone()`, excessive heap allocations in loops, or inefficient string concatenations in hot paths.
4. **Missing Regression Tests**: Bug fixes submitted without an accompanying test that fails on the unpatched code and passes on the fix.
5. **Vague Commits & Diff Sprawl**: Commits that mix refactors with features or lack Conventional Commit structure.
6. **Premature Abstraction**: Introducing multi-layered interfaces, factories, or wrapper classes for single-use logic.

---

## 3. Property-Based Testing & Verification
- **Table-Driven Unit Tests**: Structure unit tests into declarative test tables covering happy paths, boundary limits (empty strings, zero, max values, null states), and invalid inputs.
- **Property-Based Testing**: Use property testing libraries (e.g., `proptest`, `hypothesis`) to generate thousands of randomized inputs verifying invariants rather than isolated snapshot values.
- **Sanitizer & Safety Verification**: Test low-level and unsafe code under AddressSanitizer (ASan), UndefinedBehaviorSanitizer (UBSan), and Miri to mathematically guarantee absence of memory leaks and undefined behavior.
- **Hermetic Execution**: Tests must never depend on external network state, unpinned clock timestamps, or host-specific paths.

---

## 4. Systematic Root-Cause Debugging
- **Minimal Reproducible Example (MRE)**: Strip failing code to the smallest standalone reproduction before touching implementation logic.
- **Structured Tracing with Spans**: Instrument systems using structured spans (`tracing`) capturing operation context, request IDs, and timing, rather than inserting ephemeral `println!` statements.
- **Git Bisect**: Pinpoint the exact commit introducing a regression using automated binary search (`git bisect run <test_script>`).
- **Fix the Invariant, Not the Symptom**: Never apply defensive band-aids (e.g., adding a null check) without discovering why the invalid state existed upstream in the first place.

---

## 5. Documentation Craft & Density Calibration
- **Uniform Density**: Ensure uniform documentation density across the codebase. Complex algorithms demand high-signal invariant documentation; trivial accessors require zero comments.
- **Contract-First Public Docs**:
  - Public functions must include explicit contract sections:
    - `# Errors`: Exact conditions triggering an error return.
    - `# Panics`: Documented conditions that could panic.
    - `# Safety`: Caller-verified invariants required before invoking `unsafe` code.
- **"Why" Over "What"**: Never narrate syntax. Document design trade-offs, concurrency models, and algorithmic rationale.
- **Living Doctests**: Embed verified code examples directly in doc comments (`/// ````) so that `cargo test --doc` or `doctest` enforces documentation accuracy continuously.

---

## 6. README.md Master Craft
Every `README.md` must be high-signal, anti-hype, and immediately usable:
- **Anti-Hype Rule**: Ban marketing fluff ("blazing-fast", "revolutionary", "seamless"). State concrete capabilities, benchmarks, and supported platforms.
- **Visual Mental Model**: Include a clear Mermaid diagram illustrating system boundaries, architecture, or workflow pipelines.
- **Copy-Pasteable Quick Start**: Provide commands that an engineer can copy directly into a terminal to clone, build, verify, and run the project within 60 seconds.
- **Reference Table**: Feature a tabular summary of CLI commands or public APIs with clear descriptions and argument flags.

---

## 7. AGENTS.md & Agent Steerability
Authoring `AGENTS.md` creates an authoritative instruction anchor for autonomous coding agents (Antigravity, Claude, Cursor):
- **Modular Blueprint**: Keep sections discrete so elements can be expanded or dropped without breaking agent comprehension.
- **Mental Model & Boundaries**: Define the repository's architectural principles and technical stack.
- **Quick Verification Runbook**: List exact, single-line commands to build, test, lint, and audit the repository.
- **Strict Red Lines**: State non-negotiables: zero credential leakage, never swallow errors, ask before destructive changes.
- **Annotated Sitemap**: Maintain an accurate directory map detailing file locations and responsibilities.

---

## 8. Changelog Craft & Semantic Releases
- **Keep a Changelog Format**: Maintain `CHANGELOG.md` organized under standard SemVer headers (`## [X.Y.Z] - YYYY-MM-DD` and `## [Unreleased]`).
- **Standard Categories**:
  - `Added` for new features and commands.
  - `Changed` for modifications in existing functionality.
  - `Deprecated` for soon-to-be removed features.
  - `Removed` for deleted capabilities.
  - `Fixed` for any bug patch.
  - `Security` for vulnerability mitigations.
- **Audience-Targeted Entries**: Write changelog items from the consumer's perspective emphasizing impact (e.g., "Fix memory leak during WebSocket reconnection") rather than raw git hashes or file lists.
- **Changelog Synchronization**: Update `CHANGELOG.md` concurrently with every user-facing `feat` or `fix` commit.

---

## 9. Reusable Scripts & Workflow Automation
- **Bash Template Discipline**:
  - Always enforce `set -eo pipefail`.
  - Resolve script parent root dynamically (`dirname "${BASH_SOURCE[0]}"`).
  - Embed dynamic discovery metadata (`# Description: ...`).
  - Delegate shared UI/logging routines to a central library (`tools/lib/common.sh`).
- **Reproducible CI Workflows**:
  - Pin toolchain versions (`rust-toolchain.toml`, `.python-version`).
  - Run linting, formatting, security auditing, and test suites in parallel matrix jobs.

---

## 10. UX & Developer Ergonomics (DX)
- **Actionable Remediation**: Every error message must clearly present:
  1. What operation failed.
  2. The root cause.
  3. The exact command or configuration to resolve it.
- **Progressive Disclosure**: Keep default output clean and high-level; expose full diagnostic logs via `--verbose` / `-v`.
- **Safe Defaults**: Destructive commands must require explicit flags (`--force`) and provide non-destructive previews (`--dry-run`).
