---
name: workflow-scaffolder
description: Standards and templates for scaffolding bulletproof, reusable CLI tools and shell automation scripts.
---

# Workflow Scaffolder Skill

This skill defines the technical standards, architectural structure, and safety patterns required to craft reusable, self-documenting CLI utilities and automation scripts.

---

## The Standardized Five-Part Script Template

Every executable shell tool must adhere to this five-part header:

```bash
#!/usr/bin/env bash
# Description: One-line concise summary for automated CLI discovery
set -eo pipefail

TOOLBOX_ROOT="$(cd -P "$(dirname "${BASH_SOURCE[0]}")/../.." >/dev/null 2>&1 && pwd)"
# shellcheck source=tools/lib/common.sh
source "${TOOLBOX_ROOT}/tools/lib/common.sh"
```

### Shebang Portability
Use `#!/usr/bin/env bash` rather than hardcoding system-dependent paths like `/bin/bash`.

### Description Metadata
Place `# Description:` on line 2. This enables the root dispatcher to parse and display commands automatically in help listings.

### Safety Invariants
Enforce `set -eo pipefail` immediately to ensure the script aborts on any unhandled non-zero exit and correctly propagates pipe failures.

### Dynamic Root Resolution
Resolve the project root relative to the script's physical location, resolving symlinks defensively.

### Centralized Helpers
Source shared UI, formatting, and logging functions from `common.sh` rather than defining ad-hoc ANSI escape sequences.

---

## Unified Flag and Argument Parsing

All interactive and automated scripts must support standard command-line flags:

### Help and Usage Menus
- Always provide `-h` and `--help` flags displaying usage syntax, available commands, flag definitions, and defaults.

### Progressive Output Control
- Default to clean, high-signal output. Provide `-v` and `--verbose` for detailed diagnostic and trace outputs.

### Non-Destructive Previews
- Irreversible or mutating commands must support `--dry-run` or prompt for user confirmation before executing deletions or overwrites.

---

## Defensive Input and State Validation

- Check for command prerequisites using helper checks such as `has_cmd` before attempting invocation.
- Verify path existence and directory boundaries early, exiting immediately with clear remediation instructions if preconditions fail.
- Always quote variables to prevent globbing and word-splitting accidents.
