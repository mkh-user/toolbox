---
name: root-cause-debugger
description: Methodological forensic debugging: minimal reproducible examples, structured tracing, binary search bisecting, and invariant repair over symptom masking.
---

# Root-Cause Debugger Skill

This skill codifies systematic forensic engineering practices for isolating, diagnosing, and permanently eliminating software defects without speculative guesswork.

---

## Core Debugging Invariants

Every diagnostic session must adhere to two absolute rules:

### Prohibition of Shotgun Debugging
- Never apply speculative code edits hoping they resolve the problem.
- Every modification introduced during debugging must test an explicit, falsifiable hypothesis regarding why the failure occurred.
- If a hypothesis is disproven, revert the exploratory edits immediately before testing the next hypothesis.

### Invariant Repair Over Symptom Masking
- Reject defensive band-aids that simply mask invalid states, such as adding unchecked null checks, empty exception catches, or fallback defaults to bypass crashes.
- Trace the failure backwards to identify which upstream component violated the invariant, and correct the defect at its origin.

---

## Five-Phase Forensic Protocol

When diagnosing complex, transient, or low-level bugs, follow this sequence:

### Minimal Reproducible Example
Strip the failing scenario down to the absolute smallest standalone test case, script, or unit test that triggers the bug consistently. Eliminate all extraneous dependencies, threads, and data.

### Binary Search and Git Bisect
If the defect is a regression, use automated binary search to identify the exact commit that introduced it:
```bash
git bisect start <bad_commit> <good_commit>
git bisect run <test_script>
```

### Structured Tracing and Contextual Spans
Instrument suspected paths with structured spans rather than ephemeral print statements. Spans capture execution lifecycle, operation boundaries, and input arguments with zero clutter.

### Low-Level Sanitizer and Memory Triage
For crashes, segfaults, or data races in systems code:
- Run test suites under AddressSanitizer to detect buffer overflows and use-after-free conditions.
- Run under UndefinedBehaviorSanitizer to catch misaligned pointers and signed integer overflows.
- In Rust, execute test suites under Miri to mathematically verify borrow-checker and pointer aliasing invariants.
- Inspect core dumps and live stack frames using interactive debuggers such as GDB or LLDB.

### Permanent Invariant Fix and Regression Verification
Implement the fix by repairing the broken invariant. Before closing the investigation, write a deterministic regression test that reliably fails on the unpatched codebase and cleanly passes on the fix.
