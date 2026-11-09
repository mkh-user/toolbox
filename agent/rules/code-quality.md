# Code Quality and Engineering Standards

Standards for crafting resilient, maintainable, high-performance software across systems programming, scripting, and automation.

---

## Systems and Low-Level Standards

### Strict Compiler and Linter Flags
- **Zero Warnings Tolerated**: Every compilation and linter run must enforce warnings as hard errors:
  - Rust: `cargo clippy --all-targets --all-features -- -D warnings`
  - C and C++: `-Wall -Wextra -Wpedantic -Werror`
- **Memory Safety and Invariants**:
  - Adhere strictly to RAII and Rust ownership and borrow semantics.
  - Audit all `unsafe` blocks with explicit safety invariant comments (`// SAFETY: ...`).
  - Verify code against memory sanitizers: AddressSanitizer, UndefinedBehaviorSanitizer, and Miri.

### Idiomatic Error Handling
- **No Unchecked Unwraps**: Never call `.unwrap()` or `.expect()` outside of tests or provably unreachable invariants with documented proofs.
- **Crate Conventions**:
  - Use `thiserror` for granular, strongly typed domain error enums in library code.
  - Use `anyhow` for application entry points and CLI error propagation with contextual `.context("...")`.
- **Fail Fast and Loud**: Never swallow errors silently or return sentinel error values when a proper error type can be returned.

### High-Performance Data and Observability
- **Zero-Copy and Memory Layouts**: Use `serde` with zero-copy borrows (`&'a str`, `Cow<'a, str>`) for high-throughput serialization pipelines. Mind struct memory alignment and cache-line boundaries.
- **Structured Tracing**: Use the `tracing` ecosystem with contextual spans instead of ad-hoc printing or basic logging.
- **Deterministic Benchmarking**: Benchmark performance-critical paths using `criterion` with statistical regression tracking.

---

## Shell Scripting Standards

- **Safety Flags**: Every script must begin with `set -eo pipefail` to ensure immediate failure on unhandled errors and pipeline failures.
- **Header Metadata**: Include a `# Description: <one-line summary>` on line 2 for automatic discovery and self-documenting CLI integration.
- **Dynamic Portability**:
  - Use `#!/usr/bin/env bash`.
  - Resolve script root dynamically via `dirname "${BASH_SOURCE[0]}"` to guarantee execution regardless of working directory or symlinks.
- **Quoting and Variables**: Double-quote all variable references (`"$VAR"`, `"$@"`).
- **Reusable Core**: Source shared logging and formatting functions from `tools/lib/common.sh`.

---

## Python Scripting Standards

- **Zero Unnecessary Dependencies**: Rely on the Python standard library (`sys`, `os`, `pathlib`, `argparse`, `json`, `subprocess`) for core utilities to ensure immediate execution on clean runtimes.
- **Strict Typing**: Mandate type hints across all function signatures, dataclasses, and public APIs.
- **Graceful Fallbacks**: Wrap optional rich third-party libraries (`rich`, `typer`, `pydantic`) in import fallback blocks with standard-library defaults.

---

## Documentation Density and Verbosity Calibration

To prevent patchy, uneven documentation across the repository, adhere to a uniform density metric:

- **Contract-First Public Docs**:
  - In Rust: Every public function or trait must document contracts using standard sections:
    - `/// # Errors`: Conditions under which the function returns an `Err`.
    - `/// # Panics`: Conditions under which the function might panic.
    - `/// # Safety`: Required caller invariants when calling `unsafe` functions.
  - In Python: Google-style docstrings documenting Args, Returns, and Raises.
- **Why Over What**: Comments must never restate what the syntax does. Explain *why* an invariant is maintained, algorithmic trade-offs, and edge-case rationale.
- **Living Examples**: Public documentation must include runnable doctests (`cargo test --doc` or `doctest`) to ensure documentation cannot become obsolete.
- **Uniform Density**: Avoid monoliths with 50 lines of trivial comments next to undocumented complex logic. Calibrate verbosity strictly to algorithmic complexity.

---

## User Experience and Developer Ergonomics

- **Actionable Remediation**: Error messages must follow a 3-part structure:
  - **What failed**: Direct statement of the failure.
  - **Root cause**: Why the failure occurred.
  - **Remediation**: Exact, copy-pasteable command to resolve it.
- **Progressive Disclosure**: Keep default CLI output minimal and clean; provide `--verbose` or `-v` for granular debug diagnostics.
- **Safe Defaults**: Destructive actions must require explicit confirmation or `--force` flags. Offer non-destructive dry-run previews (`--dry-run`).
- **Standard POSIX Conventions**: Support `-h` and `--help`, return standard exit codes (`0` for success, non-zero for errors), and respect non-TTY redirection.
