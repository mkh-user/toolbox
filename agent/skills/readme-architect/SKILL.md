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
Document how autonomous AI assistants discover, execute, and verify operations within the repository, linking directly to [AGENTS.md](../../../AGENTS.md).

### Governance and Licensing
Link to contributing guidelines, security policies, and license files.

---

## Calibration and Golden Examples

Use these before-and-after transformations to calibrate tone, framing, and information density.

### Architectural Rationale Transformation

#### Generic LLM Output
```markdown
# Pite Game Engine
Pite is a blazing-fast, modern, next-generation 2D game engine built with Rust and Python. It offers seamless workflows, cutting-edge visual editors, and powerful scripting capabilities to supercharge your indie game development journey!
```
*Why this fails*: Loaded with unmeasured hype words ("blazing-fast", "seamless", "cutting-edge"), vague promises, zero technical justification for why Rust or Python was chosen, and no boundary definitions.

#### Mahan Standard
```markdown
# Pite

> Python scripting and Rust native performance for 2D desktop games.

## Why it is built this way

Pite is designed around deliberate architectural choices that prioritize developer ergonomics, reliability, and fast iteration:

### Python for scripting
Gameplay scripting is primarily about decision-making, game flow, and rapid iteration rather than raw numeric compute. Python provides an expressive, approachable syntax with an immense ecosystem, making gameplay logic intuitive to write and inspect.

### Rust at the core
Games demand predictable frame times, memory safety, and native execution speed. Pite builds its engine core in Rust: 2D rendering, physics simulation, scene graph traversal, and asset decoding all execute with native performance and concurrency safety, leaving Python free to orchestrate gameplay without performance bottlenecks.

### Thoughtful defaults
- Missing audio hardware? Automatic silent simulation keeps the game running without crashing.
- Script modified? Live hot reload preserves node state and physics velocities.
- Asset moved or renamed? Content-addressed UIDs keep references intact across scenes and scripts.
- Sharing your game? One-command export produces a self-contained bundle with no Python installation required on the player's machine.

### Scope and focus
- Focused on 2D desktop: Pite is dedicated strictly to 2D games on Linux, Windows, and macOS. 3D, mobile, and web targets are outside its current scope.
- Active development: Pite is in the 0.x release series. Core APIs and file formats are stable and tested, with continuous refinements to features and tooling.
```
*Why this succeeds*: Precise problem-solution framing, concrete technical justification for the polyglot boundary, explicit problem-and-solution defaults, and honest non-goals.

### Alternative Comparison Transformation

#### Generic LLM Output
```markdown
### Why Choose Us Over Other Engines?
Pite is much faster and simpler than bloated engines like Godot or overly complex ECS frameworks like Bevy. It is the ultimate choice for developers who want simplicity and raw power!
```
*Why this fails*: Arrogant, dismissive of mature projects, unbacked by data, and provides zero useful decision criteria.

#### Mahan Standard
```markdown
### Why Pite instead of other game engines

- Godot: Pite is not trying to replace Godot. If Godot fits your workflow, use Godot. Pite exists for cases where you want a smaller, Python-native alternative with smaller binary exports (measured on the minimal-2d template: ~20 MB on Windows vs ~70 MB in Godot).
- Bevy: Bevy is designed for developers who want to write their game entirely in Rust, ECS-first, without an editor. Pite is for developers who want to write gameplay in Python, scene-first, with an integrated visual editor.
- Love2D and Pygame: Excellent code-only frameworks that give you an input loop and draw calls. What they do not provide is an integrated visual editor, scene hierarchy model, asset UID tracker, or zero-config standalone desktop export. Pite does.
```
*Why this succeeds*: Respectful, honest, metric-backed, and accurately defines the exact trade-offs so developers can self-select appropriately.

---

## Agent Verification Checklist

Before finalizing any `README.md`:
- Verify all links resolve to valid, existing files.
- Test every code and terminal block in a clean shell environment.
- Check that no numbered or parenthetical headings are present.
- Ensure the document contains zero volatile, rot-prone statistics.
