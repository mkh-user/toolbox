# Code Quality & Engineering Standards

Standards for crafting resilient, maintainable, high-performance software across systems programming (Rust, C/C++), scripting (Python, Bash), and automation.

---

## 1. Systems & Low-Level Standards (Rust / C / C++)

### Strict Compiler & Linter Flags
- **Zero Warnings Tolerated**: Every compilation and linter run must enforce warnings as hard errors:
  - Rust: `cargo clippy --all-targets --all-features -- -D warnings`
  - C/C++: `-Wall -Wextra -Wpedantic -Werror`
- **Memory Safety & Invariants**:
  - Adhere strictly to RAII and Rust ownership/borrow semantics.
  - Audit all `unsafe` blocks with explicit safety invariant comments (`// SAFETY: ...`).
  - Verify code against memory sanitizers (AddressSanitizer, UndefinedBehaviorSanitizer, and Miri for Rust).

### Idiomatic Error Handling
- **No Unchecked Unwraps**: Never call `.unwrap()` or `.expect()` outside of tests or provably unreachable invariants with documented proofs.
- **Crate Conventions**:
  - Use `thiserror` for granular, strongly typed domain error enums in library code.
  - Use `anyhow` for application entry points and CLI error propagation with contextual `.context("...")`.
- **Fail Fast & Loud**: Never swallow errors silently or return sentinel error values (`-1`, `NULL`, `None`) when a proper error type can be returned.

### High-Performance Data & Observability
- **Zero-Copy & Layouts**: Use `serde` with zero-copy borrows (`&'a str`, `Cow<'a, str>`) for high-throughput serialization pipelines. Mind struct memory alignment and cache-line boundaries.
- **Structured Tracing**: Use the `tracing` ecosystem with contextual spans instead of ad-hoc `println!` or basic logging.
- **Deterministic Benchmarking**: Benchmark performance-critical paths using `criterion` with statistical regression tracking.

---

## 2. Shell Scripting Standards (Bash)

- **Safety Flags**: Every script must begin with `set -eo pipefail` to ensure immediate failure on unhandled errors and pipeline failures.
- **Header Metadata**: Include a `# Description: <one-line summary>` on line 2 for automatic discovery and self-documenting CLI integration.
- **Dynamic Portability**:
  - Use `#!/usr/bin/env bash`.
  - Resolve script root dynamically via `dirname "${BASH_SOURCE[0]}"` to guarantee execution regardless of working directory or symlinks.
- **Quoting & Variables**: Double-quote all variable references (`"$VAR"`, `"$@"`).
- **Reusable Core**: Source shared logging and formatting functions from `tools/lib/common.sh`.

---

## 3. Python Scripting Standards

- **Zero Unnecessary Dependencies**: Rely on the Python standard library (`sys`, `os`, `pathlib`, `argparse`, `json`, `subprocess`) for core utilities to ensure immediate execution on clean runtimes.
- **Strict Typing**: Mandate type hints across all function signatures, dataclasses, and public APIs.
- **Graceful Fallbacks**: Wrap optional rich third-party libraries (`rich`, `typer`, `pydantic`) in `try/except ImportError` blocks with standard-library fallbacks.

---

## 4. Documentation Density & Verbosity Calibration

To prevent patchy, uneven documentation across the repository, adhere to a uniform density metric:

- **Contract-First Public Docs**:
  - In Rust: Every public function/trait must document contracts using standard sections:
    - `/// # Errors`: Conditions under which the function returns an `Err`.
    - `/// # Panics`: Conditions under which the function might panic.
    - `/// # Safety`: Required caller invariants when calling `unsafe` functions.
  - In Python: Google-style docstrings documenting Args, Returns, and Raises.
- **"Why" Over "What"**: Comments must never restate what the syntax does. Explain *why* an invariant is maintained, algorithmic trade-offs, and edge-case rationale.
- **Living Examples**: Public documentation must include runnable doctests (`cargo test --doc` or `doctest`) to ensure documentation cannot become obsolete.
- **Uniform Density**: Avoid monoliths with 50 lines of trivial comments next to undocumented complex logic. Calibrate verbosity strictly to algorithmic complexity.

---

## 5. UX & Developer Ergonomics (DX)

- **Actionable Remediation**: Error messages must follow a 3-part structure:
  1. **What failed**: Direct statement of the failure.
  2. **Root cause**: Why the failure occurred.
  3. **Remediation**: Exact, copy-pasteable command to resolve it.
- **Progressive Disclosure**: Keep default CLI output minimal and clean; provide `--verbose` / `-v` for granular debug diagnostics.
- **Safe Defaults**: Destructive actions must require explicit confirmation or `--force` flags. Offer non-destructive dry-run previews (`--dry-run`).
- **Standard POSIX Conventions**: Support `-h` / `--help`, return standard exit codes (`0` for success, non-zero for errors), and respect non-TTY redirection (strip ANSI colors when piped).
