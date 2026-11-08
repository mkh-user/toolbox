---
name: code-auditor
description: Audits code quality, bash script syntax, permission sanity, and scans for accidentally exposed credentials or secrets.
---

# Code Auditor Skill

This skill provides automated static inspection, linting checks, permission verification, and credential leak scanning across the codebase.

## Capabilities

1. **Bash Syntax Validation**: Uses `bash -n` to detect syntax errors, unclosed quotes, and bad control flows across all shell scripts without executing them.
2. **Permission Auditing**: Verifies that executable tools in `tools/` have executable permissions (`+x`) and secure permissions on sensitive directories.
3. **Secret & Key Leak Detection**: Scans tracked and modified files for high-entropy tokens, private key headers (`BEGIN RSA PRIVATE KEY`, `BEGIN OPENSSH PRIVATE KEY`), GitHub PAT patterns (`ghp_`, `gho_`), and hardcoded secrets.

## Companion CLI Command

```bash
# Run comprehensive audit across repository
./toolbox audit check
```

## Agent Guidelines

- Run `./toolbox audit check` after creating or editing shell scripts or Python tools.
- Never bypass secret checks: if an audit flags a potential credential, verify whether it is a real token or an innocent placeholder. If real, remove it immediately and inform the user.
