---
name: repo-governance
description: Establishes open-source repository governance, the unbroken link reachability graph, contributor workflows, and health audit checklists.
---

# Repository Governance Skill

This skill defines the governance standards, open-source health checklists, and document linking architecture required to maintain a transparent, navigable, and community-ready repository.

---

## The Unbroken Link Chain Principle

Every document, rule, and skill in the repository must be connected through an explicit reference trail:

### Zero Orphaned Files
- No markdown guide, operational rule, or skill definition may exist in isolation without a direct relative link from primary entry anchors.
- Human Entry Point: [README.md](../../../README.md) links to all high-level governance, guides, and contributing workflows.
- Agent Entry Point: [AGENTS.md](../../../AGENTS.md) links to all behavioral rules, executable tools, and agent skills.

### Relative Navigation Integrity
- All intra-repository links must use valid relative or file links that resolve reliably across local file systems and GitHub web interfaces.

---

## Role Clarity and Document Separation

Distinct audiences require dedicated documentation interfaces:

### Human Developer Guides
- `README.md`: High-level onboarding, architecture rationale, and quick starts.
- `CONTRIBUTING.md`: Pull request standards, commit hygiene, and local developer environment setup.
- `SECURITY.md`: Vulnerability disclosure policies and credential protection expectations.
- `CHANGELOG.md`: Human-readable version history organized by user-facing impact.

### AI Agent Operating Specifications
- `AGENTS.md`: Authoritative mental model, operational red lines, and execution runbooks for autonomous coding assistants.
- `agent/rules`: Modular rulesets covering interaction protocols, safety boundaries, and code quality standards.
- `agent/skills`: Concrete skill specifications equipping agents with deep operational methodologies.

---

## Repository Health Checklist

Before certifying repository health or issuing a release, verify these criteria:

### Legal and Identity Invariants
- A permissive, valid `LICENSE` file is committed at the repository root.
- Author identity and maintainer contact information are clearly declared.

### Document Completeness
- `README.md`, `AGENTS.md`, `CHANGELOG.md`, `CONTRIBUTING.md`, and `SECURITY.md` exist and are cross-linked.
- No numbered or parenthetical headings are present across repository documentation.

### Clean Verification Gate
- All shell tools have executable permissions (`+x`).
- The repository passes `./toolbox audit check` with zero syntax errors, zero warnings, and zero detected secrets.
