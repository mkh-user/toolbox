---
name: readme-architect
description: Guides authoring and maintaining high-signal, anti-hype README.md files with architectural rationale, visual models, and living examples.
---

# Readme Architect Skill

This skill equips agents and engineers to draft, evaluate, and maintain production-grade README files that communicate technical purpose with clarity and zero marketing fluff.

---

## Core Philosophy

A README is an engineering specification and onboarding interface, not an advertisement. Adhere to three primary laws:

- **Anti-Hype Filter**: Ban subjective adjectives such as "blazing-fast", "seamless", "revolutionary", or "modern". Replace them with concrete metrics, memory bounds, supported platforms, and deterministic exit codes.
- **Living Examples**: Every CLI snippet or code example must be verified against the codebase. Never publish speculative syntax or unverified commands.
- **Progressive Disclosure**: Keep the root README focused on high-level navigation, quick starts, and architecture. Delegate deep reference manuals to dedicated subdirectories such as `docs` or `agent/skills`.

---

## Essential Structural Sections

A senior-grade README follows a predictable structural hierarchy:

### One-Line Mission Statement
State exactly what the project does, for whom, and under what operational boundaries. Avoid buzzwords.

### Fast Quick Start
Provide commands that an engineer can copy directly into a terminal to clone, build, verify, and run the project within 60 seconds without prerequisite friction.

### Architectural Rationale
Explain why the system is built this way rather than reciting syntax:
- Technical design choices and trade-offs.
- Honest, metric-backed comparison against existing alternatives without dismissiveness.
- Explicit non-goals outlining what the project deliberately chooses not to support.
- Thoughtful defaults framed as problem-and-solution pairs.

### Visual Mental Model
Include a clean Mermaid flowchart or state diagram illustrating component boundaries, execution flows, and dependencies.

### Command and API Reference Table
Feature a tabular breakdown of commands, flags, arguments, default values, and brief descriptions.

### AI Agent Integration
Document how autonomous AI assistants discover, execute, and verify operations within the repository, linking directly to [AGENTS.md](file:///content/toolbox/AGENTS.md).

### Governance and Licensing
Link to contributing guidelines, security policies, and license files.

---

## Agent Verification Checklist

Before finalizing any `README.md`:
- Verify all links resolve to valid, existing files.
- Test every code and terminal block in a clean shell environment.
- Check that no numbered or parenthetical headings are present.
- Ensure the document contains zero volatile, rot-prone statistics.
