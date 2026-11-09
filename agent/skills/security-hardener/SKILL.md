---
name: security-hardener
description: Establishes security hygiene, credential zero-leakage defense, dependency supply-chain auditing, and memory-safety verification.
---

# Security Hardener Skill

This skill guides agents and engineers in auditing, hardening, and verifying codebases against credential leakage, supply-chain vulnerabilities, injection vectors, and memory safety defects.

---

## Multi-Layer Secret Defense

Protecting sensitive credentials is a non-negotiable operational boundary:

### Zero Secret Exposure
- Prohibit hardcoded API keys, OAuth tokens, private keys, certificates, and passwords across all tracked repository files.
- Mask all sensitive tokens in terminal outputs and logs using truncated previews or redactions.
- Isolate credentials strictly in environment variables or sanctioned platform stores such as Google Colab Userdata.

### Pre-Commit and Static Secret Scanning
- Ensure `.gitignore` comprehensively filters `.env`, `*.pem`, `*.key`, `*token*`, and transient credential directories.
- Regularly run static regex leak detection across tracked files and working tree diffs using tools such as `./toolbox audit check`.

---

## Dependency Supply-Chain Guard

External dependencies represent expanding attack surfaces. Enforce strict supply-chain discipline:

### Automated Vulnerability Auditing
- Regularly scan lockfiles against official vulnerability advisories using specialized tools:
  - Rust: `cargo audit`
  - Python: `pip-audit`
- Treat reported high or critical CVEs as blocking defects.

### Lockfile Integrity and Pinned Dependencies
- Commit canonical lockfiles (`Cargo.lock`, `poetry.lock`) to ensure deterministic, reproducible builds.
- Audit newly introduced dependencies for bloat, unnecessary transitive trees, or unmaintained upstreams.

---

## Memory Safety and Unsafe Code Auditing

In systems languages like Rust, C, and C++, memory boundaries must be provably defended:

### Unsafe Invariant Proofs
- Every `unsafe` block must be accompanied by an explicit `// SAFETY:` doc comment detailing the exact caller preconditions and memory invariants that prevent undefined behavior.
- Validate pointer validity, memory alignment, non-null guarantees, and lifetime bounds before raw pointer dereferences.

### Integer and Buffer Defenses
- Prevent integer overflows in arithmetic operations on untrusted inputs by using checked arithmetic methods.
- Eliminate buffer out-of-bounds risks by favoring slice iteration over manual indexing.

---

## Shell and Command Injection Defense

Automation scripts and shell commands must defend against arbitrary command execution:

### Strict Variable Quoting
- Always enclose variable references and arrays in double quotes to prevent unintended word splitting and glob expansion.
- Avoid dynamic subshells incorporating unsanitized user input.

### Prohibition of Unsafe Constructs
- Never use `eval` or pipe untrusted strings directly into interpreters.
- Sanitize and validate all user-supplied file paths, ensuring directory traversal attempts using parent path segments are caught and rejected.
