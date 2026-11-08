---
name: toolbox
description: Manage and run developer tools, setup automation (gh, agy, colab), and environment persistence utilities.
---

# Toolbox Skill

This skill equips agents to interact with the repository's native `./toolbox` CLI dispatcher and modular tool suites.

## Overview

`toolbox` is a standalone, modular developer and agent toolkit designed to work out of the box with zero external dependencies.

- Root dispatcher: `./toolbox <category> <command> [args...]`
- Auto-discovery: Automatically identifies executable scripts in `tools/<category>/`
- Shared utilities: Sourced from `tools/lib/common.sh`

## Directory Structure

```
toolbox/
├── toolbox                      # Root executable CLI dispatcher
├── tools/
│   ├── lib/
│   │   └── common.sh           # Logging, colors, helper functions
│   ├── setup/
│   │   ├── colab               # Mounts Drive, configures gh, restores agy token
│   │   ├── gh                  # Authenticates GitHub CLI via Colab Secrets (GH_TOKEN)
│   │   ├── agy                 # Backup/restore/status for Antigravity OAuth token
│   │   └── status              # Non-destructive environment & credential inspector
│   ├── colab/                  # Runtime persistence, backup & restore
│   └── git/                    # Git workflow helpers
└── agent/
    ├── skills/                 # Agent skills (e.g. this skill)
    └── rules/                  # Cross-agent behavioral rulesets
```

## Available Commands

### Environment Setup (`setup`)

1. **Check Environment Status** (Non-destructive inspection):
   ```bash
   ./toolbox setup status
   ```
   Inspects Google Drive mount state, Colab secrets availability, GitHub CLI auth status, and Antigravity token presence.

2. **One-Stop Colab Initialization**:
   ```bash
   ./toolbox setup colab
   ```
   Mounts Google Drive at `/content/drive`, logs in to GitHub CLI using `GH_TOKEN` from Colab Userdata, and restores the cached Antigravity token from `/content/drive/MyDrive/.secrets/agy-token`.

3. **GitHub CLI Setup**:
   ```bash
   ./toolbox setup gh
   ```
   Authenticates `gh` using strictly the `GH_TOKEN` secret in Colab Userdata.

4. **Antigravity Token Management**:
   ```bash
   ./toolbox setup agy status             # Check local and backup token status
   ./toolbox setup agy save               # Backup local token to Google Drive
   ./toolbox setup agy restore            # Restore token from Google Drive to local config
   ./toolbox setup agy save --path <file> # Custom backup path
   ```

### Runtime Persistence (`colab`)

1. **Save Runtime State to Google Drive**:
   ```bash
   ./toolbox colab save
   ./toolbox colab save -i ~/.my_custom_folder  # With extra path
   ```
   Packages `~/.gitconfig`, `~/.bashrc`, `~/.ssh/`, `~/.config/gh/`, and custom manifests to `/content/drive/MyDrive/colab_backup.tar.gz`.

2. **Restore Runtime State from Google Drive**:
   ```bash
   ./toolbox colab restore
   ```
   Extracts files directly to `$HOME` and sets appropriate SSH key permissions.

### Git & Hygiene Helpers (`git`)

1. **Inspect Working Tree**:
   ```bash
   ./toolbox git diff-sum
   ```
   Displays formatted breakdown of staged, unstaged, and untracked changes.

2. **Conventional Commit**:
   ```bash
   ./toolbox git commit -t feat -s setup -m "add status inspector"
   ```
   Enforces conventional commit format.

3. **Clean Caches**:
   ```bash
   ./toolbox git clean [--force]
   ```
   Removes `__pycache__` and scratch temporary files safely.

### Code & Security Audit (`audit`)

1. **Run Static Repository Audit**:
   ```bash
   ./toolbox audit check
   ```
   Validates bash syntax across all scripts, audits file permissions, and scans for leaked credentials or private keys.

## Agent Guidelines When Invoking Toolbox

- **Strict Namespacing**: Always invoke commands with category prefixes (e.g., `./toolbox setup status`, never bare `./toolbox status`).
- **Safe State Inspection**: Before attempting operations that require credentials or mounted storage, run `./toolbox setup status` to verify prerequisite state.
- **Do Not Leak Secrets**: Never pass secrets or tokens directly on the command line; `toolbox` handles credential retrieval directly via secure environment / Colab Userdata APIs.
