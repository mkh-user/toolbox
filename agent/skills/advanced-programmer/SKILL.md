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

---

## Calibration and Golden Examples

### Changelog Overhaul Transformation

#### Generic LLM or Raw Debug Log
```markdown
## Unreleased
- Fixed pyclass fields: Writing self.texture, self.atlas from Python now reaches the tree.
- The pyclasses were previously writing a dead Rust field.
- Added tilemaps subsystem.
- In rapier2d adjacent tiles merge to fix character collider catching.
- Button click timing changed: buttons fire during process instead of before physics.
- Node schemas moved to per-node files in pite-core/src/nodes/*.rs.
```
*Why this fails*: Stream-of-consciousness internal plumbing notes, unstructured bullet hierarchy, mixes major features with internal bugfixes, and fails to explain what the user can now do.

#### Mahan Standard
```markdown
## Unreleased

### Added
- **2D Tilemaps Subsystem**:
  - Added multi-layer grid tilemaps via `.ptmap` TOML sidecars referencing atlas frames.
  - Greedy collider merging: adjacent solid tiles coalesce into maximal static box colliders in Rapier2D, preventing internal edge snagging for character controllers.
  - Frustum-culled batch rendering: offscreen tiles are culled, batching visible tiles into GPU draw calls.
  - Scripting API: `pite.TileMap2D` exposes coordinate helpers (`world_to_map`, `map_to_world`), layer introspection, and cell manipulation.
  - Integrated editor tools: inspector tile palette with layer switcher and viewport interactive painting with grid snapping.
- **Simultaneous Scene and Code Save**: `Ctrl+S` saves both the active `.ptscn` scene and open Python script simultaneously, triggering an immediate hot reload without extra clicks.

### Changed
- **UI Hierarchy Refactoring**:
  - `Control` now inherits from `Node2D` (`Node → Node2D → Control → Label and Button`).
  - `Label` and `Button` inherit position and rotation transforms directly from `Node2D` alongside UI styling properties.
```
*Why this succeeds*: Bold feature titles with clean sub-bullets covering architecture, engine capabilities, developer APIs, and editor UX.

### Systems Error Handling Transformation

#### Generic LLM Implementation
```rust
// Generic LLM: Sloppy error swallowing and unchecked unwraps
pub fn parse_asset_config(path: &str) -> Option<Config> {
    let raw = std::fs::read_to_string(path).ok()?;
    let parsed: serde_json::Value = serde_json::from_str(&raw).unwrap(); // Panic risk
    Some(Config {
        name: parsed["name"].as_str().unwrap().to_string(), // Unnecessary allocation
        id: parsed["id"].as_u64().unwrap_or(0),            // Masking missing field
    })
}
```
*Why this fails*: Unchecked `.unwrap()` panics in production, `.unwrap_or(0)` silently masks invalid configuration data, and `read_to_string.ok()?` swallows I/O error causes (permissions vs file not found).

#### Mahan Standard
```rust
// Mahan Standard: Explicit domain errors, fail-fast boundary validation, zero-copy
use std::path::Path;
use thiserror::Error;

#[derive(Debug, Error)]
pub enum ConfigError {
    #[error("failed to read config file at {path}: {source}")]
    Io { path: String, #[source] source: std::io::Error },
    #[error("malformed JSON in config file at {path}: {source}")]
    Json { path: String, #[source] source: serde_json::Error },
    #[error("missing required configuration field '{field}' in {path}")]
    MissingField { path: String, field: &'static str },
}

pub fn parse_asset_config<P: AsRef<Path>>(path: P) -> Result<Config, ConfigError> {
    let path_ref = path.as_ref();
    let display_path = path_ref.display().to_string();

    let raw = std::fs::read_to_string(path_ref).map_err(|source| ConfigError::Io {
        path: display_path.clone(),
        source,
    })?;

    let parsed: serde_json::Value = serde_json::from_str(&raw).map_err(|source| ConfigError::Json {
        path: display_path.clone(),
        source,
    })?;

    let name = parsed.get("name")
        .and_then(|v| v.as_str())
        .ok_or_else(|| ConfigError::MissingField { path: display_path.clone(), field: "name" })?
        .to_string();

    let id = parsed.get("id")
        .and_then(|v| v.as_u64())
        .ok_or_else(|| ConfigError::MissingField { path: display_path, field: "id" })?;

    Ok(Config { name, id })
}
```
*Why this succeeds*: Zero panics, strongly typed domain errors identifying exact failing paths and fields, fail-fast ingress validation, and zero silent data corruption.
