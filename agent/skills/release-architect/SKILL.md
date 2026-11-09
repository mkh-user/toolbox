---
name: release-architect
description: Guides authoring high-impact, anti-hype GitHub release bodies, migration guides, breaking change callouts, and release verification gates.
---

# Release Architect Skill

This skill defines the methodology for crafting, evaluating, and publishing production-grade release bodies for GitHub Releases, package registries, and tagged milestones.

---

## Core Purpose

A release body is the public communication interface between project maintainers and downstream consumers. It must:
- Highlight the operational theme and architectural value of the release without marketing hyperbole.
- Provide clear, actionable migration guides with code snippets for every breaking change.
- Deliver curated, user-impact change inventories rather than raw commit message dumps.
- Provide copy-pasteable installation and upgrade commands.

---

## Essential Structural Hierarchy

Every production release body must follow this structure:

### Thematic Headline
A single blockquote sentence summarizing the primary focus of the release:
```markdown
> Multi-layer 2D tilemaps with Rapier2D greedy collider coalescing and unified scene-script saving.
```

### Breaking Changes and Migration Guide
If the release introduces breaking changes or deprecations, place this section immediately beneath the headline. Never hide breaking changes at the bottom.
- State what changed and why.
- Provide explicit Before and After code snippets showing how downstream code must adapt.

### Major Highlights
Spotlight 1 to 3 major capabilities with architecture context and copy-pasteable code or configuration snippets.

### Curated Change Inventory
Group changes into standard user-facing categories:
- **Added**: New APIs, tools, and user-facing capabilities.
- **Changed**: Modifications in runtime behavior, defaults, or ergonomics.
- **Fixed**: Bug patches and regression fixes.
- **Performance**: Benchmark-backed speedups and memory optimizations.
- **Security**: Vulnerability patches and credential hardening.

### Upgrade Commands
Provide direct terminal commands for upgrading via package managers or binary releases.

### Verification and Diff Links
Link directly to the full GitHub commit comparison between the previous tag and the new release.

---

## Calibration and Golden Examples

### Release Body Transformation

#### Generic LLM Output
```markdown
# 🎉 Release v0.3.0 is Here! 🚀

We are super thrilled to announce the incredible release of v0.3.0! This release brings tons of amazing new features, performance enhancements, and bug fixes to make your experience seamless and revolutionary!

## What's Changed
* Fixed bug in tree.rs by @contributor in #12
* Update dependencies by @bot in #14
* Add tilemaps by @dev in #15
* Some APIs were changed, please see documentation.
* Refactor stuff

**Full Changelog**: https://github.com/org/repo/commits/v0.3.0
```
*Why this fails*: Fluffy marketing intro with excessive emojis, raw unedited PR titles, vague breaking change warning with zero migration guidance, and broken commit compare link.

#### Mahan Standard
```markdown
> Multi-layer 2D tilemaps with Rapier2D greedy collider coalescing and unified scene-script saving.

## Breaking Changes and Migration Guide

### Control Hierarchy and Property Accessors
`Control` now inherits from `Node2D` (`Node → Node2D → Control → Label and Button`). Subclasses overriding `_process` must call `super()._process(delta)` to preserve engine-owned tick loops.

#### Before
```python
class CustomButton(Button):
    def _process(self, delta):
        self.do_custom_logic()
```

#### After
```python
class CustomButton(Button):
    def _process(self, delta):
        super()._process(delta)  # Required to preserve click polling
        self.do_custom_logic()
```

---

## Highlights

### 2D Tilemaps Subsystem
Added multi-layer grid tilemaps via `.ptmap` TOML sidecars referencing atlas frames. Adjacent solid tiles coalesce into maximal static box colliders in Rapier2D, preventing internal edge snagging for character controllers.

```python
tilemap = self.get_node("WorldMap")
tilemap.set_cell(layer=0, col=5, row=10, frame="grass_center")
```

---

## Change Inventory

### Added
- Multi-layer grid tilemaps with frustum-culled GPU batch rendering.
- Simultaneous scene and script saving on `Ctrl+S` triggering immediate hot reload.
- Full-featured Assets panel file browser with creation dialogs and keyboard shortcuts.

### Changed
- UI hierarchy refactored: `Control` extends `Node2D`, inheriting position and rotation transforms directly.
- Standardized scene formatting for color properties.

### Fixed
- Fixed dead field writes when assigning `self.texture` and `self.atlas` from Python.
- Restored persistence of physics properties across hot reloads.

---

## Upgrade

```bash
cargo install --locked pite-cli --version 0.3.0
```

**Full Commit Diff**: https://github.com/piteengine/pite/compare/v0.2.0...v0.3.0
```
*Why this succeeds*: Clean thematic summary, explicit breaking change migration snippets, concrete feature highlights, curated change bullets, copy-pasteable upgrade commands, and an exact tag-to-tag comparison link.

---

## Pre-Flight Release Gate

Before publishing any release body, verify these criteria:
- **Version Manifest Sync**: Confirm the release tag exactly matches the version declared in `Cargo.toml`, `pyproject.toml`, or package manifest files.
- **Changelog Parity**: Confirm release notes synchronize with `CHANGELOG.md` under the tagged version header.
- **Link and Diff Resolution**: Confirm that comparison links (`vPrev...vNext`) and issue links resolve to real commits.
- **Typography Check**: Ensure zero numbered headings, zero parenthetical headings, and zero trailing punctuation are present.
