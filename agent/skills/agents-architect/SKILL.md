---
name: agents-architect
description: Guides authoring, updating, and evolving AGENTS.md operating manuals for autonomous AI assistants without context loss or rule regression.
---

# Agents Architect Skill

This skill defines the methodology for drafting, structuring, and safely updating `AGENTS.md` files—the primary behavioral and architectural anchors for AI coding assistants.

---

## Core Purpose of AGENTS.md

`AGENTS.md` bridges the gap between human architectural intent and autonomous agent execution. It provides:
- A high-signal mental model and system architecture map.
- A fast verification runbook for deterministic health checks.
- Non-negotiable red lines defining safety, credential isolation, and interaction rules.
- A directory sitemap outlining component responsibilities.

---

## Protocol for Updating Existing AGENTS.md Files

When modifying an already established `AGENTS.md`, agents must avoid blind rewrites and observe strict safety invariants:

### Protected Sections Invariant
- Core behavioral boundaries, interaction protocols, and safety red lines are protected zones. Never modify, weaken, or drop them unless the user explicitly requests an update.
- Only operational sections—such as the Quick Verification Runbook, Directory Sitemap, and Command Tables—should dynamically sync as new tools are introduced.

### Pre-Flight Semantic Audit
- Before applying edits, parse all existing constraints to guarantee that new instructions do not contradict established rules or create semantic ambiguity.

### Tool Verification Guard
- Never register a command, script, or file path in `AGENTS.md` unless it has been physically verified to exist, execute cleanly, and pass static auditing.

### Ban on Volatile Statistics
- Never hardcode metrics that rot quickly, such as lines of code, test case counts, database migration heads, or ephemeral commit hashes. Focus strictly on durable invariants and workflows.

---

## Standard Structural Blueprint

A resilient `AGENTS.md` is structured into modular, expandable blocks:

### System Architecture and Mental Model
Visual Mermaid diagrams and high-level architectural philosophies explaining how the codebase functions.

### Quick Verification Runbook
Single-line, copy-pasteable commands to test, lint, format, and audit the repository.

### Non-Negotiable Red Lines
Absolute constraints that agents must never violate:
- Zero credential exposure.
- Ask before destructive work.
- The Zero-Guessing Rule: interrogate rather than assume.
- Systems invariants: zero unwrap in production, strict error propagation.

### Directory Sitemap and Responsibilities
An annotated tree of directories and files defining what lives where and why.

### Extending and Modifying the Repository
Step-by-step guidance on adding new modules, tools, or tests while maintaining documentation concurrency.

---

## Agent Verification Checklist

Before saving changes to `AGENTS.md`:
- Confirm all markdown links use valid paths.
- Ensure no numbered or parenthetical headings were introduced.
- Verify that no existing red lines or user preferences were deleted.
