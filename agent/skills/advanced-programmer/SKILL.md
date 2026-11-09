---
name: advanced-programmer
description: Senior full-stack and systems engineering standards covering Architecture, Systems, Code Review, Testing, Debugging, Documentation, and DevOps.
---

# Advanced Programmer Skill

This skill codifies senior-grade engineering discipline, architectural principles, and execution craft across systems programming, polyglot scripting, documentation architecture, and developer tooling.

---

## Systems and Polyglot Architecture

- **Memory and Cache Awareness**: Respect hardware memory hierarchies. Design data structures for cache locality, such as structures-of-arrays where appropriate, favoring contiguous vectors over pointer graphs.
- **Ownership and Borrowing**: Design clean ownership trees with single owners. Avoid cyclic reference counts through explicit data flow and channel-based message passing.
- **Fail Fast and Loud**: Validate boundaries at ingress. Reject invalid states immediately with strongly typed domain errors using `thiserror`. Never swallow or downgrade errors.
- **Zero-Cost Abstractions**: Leverage compile-time evaluation via generics and traits to shift computation and invariants from runtime to compile time without incurring heap allocation penalties.

---

## Rigorous Code Review Criteria

Code reviews must reject pull requests immediately if any of the following anti-patterns are present:
- **Silent Error Swallowing**: Catch blocks that ignore errors, empty exception clauses, or unhandled result types.
- **Unchecked Panics**: Any `.unwrap()` or `.expect()` outside unit test modules without formal, documented invariant proofs.
- **Hidden Allocations**: Unnecessary cloning, excessive heap allocations in loops, or inefficient string concatenations in hot paths.
- **Missing Regression Tests**: Bug fixes submitted without an accompanying test that fails on the unpatched code and passes on the fix.
- **Vague Commits and Diff Sprawl**: Commits that mix refactors with features or lack Conventional Commit structure.
- **Premature Abstraction**: Introducing multi-layered interfaces, factories, or wrapper classes for single-use logic.

---

## Property-Based Testing and Verification

- **Table-Driven Unit Tests**: Structure unit tests into declarative test tables covering happy paths, boundary limits, and invalid inputs.
- **Property-Based Testing**: Use property testing libraries to generate randomized inputs verifying invariants rather than isolated snapshot values.
- **Sanitizer and Safety Verification**: Test low-level and unsafe code under AddressSanitizer, UndefinedBehaviorSanitizer, and Miri to guarantee absence of memory leaks and undefined behavior.
- **Hermetic Execution**: Tests must never depend on external network state, unpinned clock timestamps, or host-specific paths.

---

## Systematic Root-Cause Debugging

- **Minimal Reproducible Example**: Strip failing code to the smallest standalone reproduction before touching implementation logic.
- **Structured Tracing with Spans**: Instrument systems using structured spans capturing operation context, request identifiers, and timing, rather than inserting ephemeral print statements.
- **Git Bisect**: Pinpoint the exact commit introducing a regression using automated binary search.
- **Fix the Invariant, Not the Symptom**: Never apply defensive band-aids without discovering why the invalid state existed upstream in the first place.

---

## Documentation Craft and Density Calibration

- **Uniform Density**: Ensure uniform documentation density across the codebase. Complex algorithms demand high-signal invariant documentation; trivial accessors require zero comments.
- **Contract-First Public Docs**:
  - Public functions must include explicit contract sections:
    - `# Errors`: Exact conditions triggering an error return.
    - `# Panics`: Documented conditions that could panic.
    - `# Safety`: Caller-verified invariants required before invoking unsafe code.
- **Why Over What**: Never narrate syntax. Document design trade-offs, concurrency models, and algorithmic rationale.
- **Living Doctests**: Embed verified code examples directly in doc comments so that doctest suites enforce documentation accuracy continuously.

---

## Master Readme Authoring

Every `README.md` must be high-signal, anti-hype, and immediately usable:
- **Anti-Hype Rule**: Ban marketing buzzwords. State concrete capabilities, benchmarks, and supported platforms.
- **Visual Mental Model**: Include a clear Mermaid diagram illustrating system boundaries, architecture, or workflow pipelines.
- **Copy-Pasteable Quick Start**: Provide commands that an engineer can copy directly into a terminal to clone, build, verify, and run the project within 60 seconds.
- **Reference Table**: Feature a tabular summary of CLI commands or public APIs with clear descriptions and argument flags.

---

## Operating Manual Authoring for Autonomous Agents

Authoring `AGENTS.md` creates an authoritative instruction anchor for autonomous coding assistants:
- **Modular Blueprint**: Keep sections discrete so elements can be expanded or dropped without breaking agent comprehension.
- **Mental Model and Boundaries**: Define the repository's architectural principles and technical stack.
- **Quick Verification Runbook**: List exact, single-line commands to build, test, lint, and audit the repository.
- **Strict Red Lines**: State non-negotiables: zero credential leakage, never swallow errors, ask before destructive changes.
- **Annotated Sitemap**: Maintain an accurate directory map detailing file locations and responsibilities.

---

## Changelog Craft and Semantic Releases

- **Keep a Changelog Format**: Maintain `CHANGELOG.md` organized under standard SemVer headers.
- **Standard Categories**:
  - `Added` for new features and commands.
  - `Changed` for modifications in existing functionality.
  - `Deprecated` for soon-to-be removed features.
  - `Removed` for deleted capabilities.
  - `Fixed` for any bug patch.
  - `Security` for vulnerability mitigations.
- **Audience-Targeted Entries**: Write changelog items from the consumer's perspective emphasizing impact rather than raw git hashes or file lists.
- **Changelog Synchronization**: Update `CHANGELOG.md` concurrently with every user-facing `feat` or `fix` commit.

---

## Reusable Scripts and Workflow Automation

- **Bash Template Discipline**:
  - Always enforce `set -eo pipefail`.
  - Resolve script parent root dynamically.
  - Embed dynamic discovery metadata.
  - Delegate shared interface routines to a central library.
- **Reproducible CI Workflows**:
  - Pin toolchain versions.
  - Run linting, formatting, security auditing, and test suites in parallel matrix jobs.

---

## User Experience and Developer Ergonomics

- **Actionable Remediation**: Every error message must clearly present:
  - What operation failed.
  - The root cause.
  - The exact command or configuration to resolve it.
- **Progressive Disclosure**: Keep default output clean and high-level; expose full diagnostic logs via `--verbose` or `-v`.
- **Safe Defaults**: Destructive commands must require explicit flags and provide non-destructive previews.
