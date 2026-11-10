---
name: toolbox
description: Manage and run developer tools, setup automation (gh, agy, colab), and environment persistence utilities.
---

# Toolbox Skill

This skill equips agents to interact with the repository's native `./toolbox` CLI dispatcher and modular tool suites.

---

## Overview

`toolbox` is a standalone, modular developer and agent toolkit designed to work out of the box with zero external dependencies.

- Root dispatcher: `./toolbox <category> <command> [args...]`
- Auto-discovery: Automatically identifies executable scripts in `tools/<category>/`
- Shared utilities: Sourced from `tools/lib/common.sh`

---

## Directory Structure

```
toolbox/
├── toolbox                      # Root executable CLI dispatcher
├── AGENTS.md                    # Operating specification for AI agents
├── CHANGELOG.md                 # Semantic version history
├── CONTRIBUTING.md              # Contributor guidelines
├── SECURITY.md                  # Security disclosure policy
├── README.md                    # User manual and reference tables
├── tools/
│   ├── lib/
│   │   └── common.sh           # Logging, colors, helper functions
│   ├── setup/
│   │   ├── colab               # Mounts Drive, configures gh, restores agy token
│   │   ├── gh                  # Authenticates GitHub CLI via Colab Secrets
│   │   ├── agy                 # Backup, restore, status for Antigravity token
│   │   └── status              # Environment and credential inspector
│   ├── colab/                  # Runtime persistence, backup, and restore
│   ├── skills/                 # Agent skill discovery and inspection
│   └── audit/                  # Static syntax and security scanner
└── agent/
    ├── skills/                 # Agent operational skills
    └── rules/                  # Behavioral and coding rulesets
```

---

## Available Commands

### Environment Setup Commands

Check environment status:
```bash
./toolbox setup status
```
Inspects Google Drive mount state, Colab secrets availability, GitHub CLI auth status, and Antigravity token presence.

One-stop Colab initialization:
```bash
./toolbox setup colab
```
Mounts Google Drive at `/content/drive`, logs in to GitHub CLI using `GH_TOKEN` from Colab Userdata, and restores the cached Antigravity token.

Mount Google Drive:
```bash
./toolbox setup drive
./toolbox setup drive status
```
Mounts Google Drive at `/content/drive` if not already mounted, and provides status inspection and forced remounting options.

GitHub CLI token management:
```bash
./toolbox setup gh
./toolbox setup gh save
./toolbox setup gh restore
./toolbox setup gh status
```
Authenticates `gh` using Colab Secrets, Google Drive backup (`/content/drive/MyDrive/.secrets/gh-token`), or environment variables. Supports saving active credentials to Google Drive and restoring them across cloud runtimes.

Antigravity token management:
```bash
./toolbox setup agy status
./toolbox setup agy save
./toolbox setup agy restore
```

### Runtime Persistence Commands

Save runtime state to Google Drive:
```bash
./toolbox colab save
./toolbox colab save -i ~/.my_custom_folder
```

Restore runtime state from Google Drive:
```bash
./toolbox colab restore
```

### Code and Security Audit

Run static repository audit:
```bash
./toolbox audit check
```

---

## Agent Guidelines When Invoking Toolbox

- **Strict Namespacing**: Always invoke commands with category prefixes (e.g., `./toolbox setup status`, never bare `./toolbox status`).
- **Safe State Inspection**: Before attempting operations that require credentials or mounted storage, run `./toolbox setup status` to verify prerequisite state.
- **Do Not Leak Secrets**: Never pass secrets or tokens directly on the command line; `toolbox` handles credential retrieval directly via secure environment APIs.
