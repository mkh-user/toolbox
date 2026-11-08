# Code Quality & Architecture Rules

Standards for crafting resilient, maintainable, and high-performance polyglot tooling across shell, Python, and configuration files.

## 1. Shell Scripting Standards (Bash)
- **Safety Flags**: Every bash script must begin with `set -eo pipefail` to ensure fail-fast execution and propagate pipe errors.
- **Header Metadata**: Include a `# Description: <one-line summary>` immediately after the shebang to enable dynamic CLI auto-discovery and self-documenting help.
- **Portability**:
  - Use `#!/usr/bin/env bash` rather than hardcoded paths like `/bin/bash`.
  - Resolve the script's root directory dynamically using `dirname "${BASH_SOURCE[0]}"` to guarantee it runs correctly regardless of working directory or symlink location.
- **Variable Quoting**: Always double-quote variable references (`"$VAR"`, `"$@"`), except where word splitting is explicitly intended.
- **Reusable Helpers**: Source shared logging and formatting functions from `tools/lib/common.sh` (`log_info`, `log_success`, `log_warn`, `log_error`).

## 2. Python Scripting Standards
- **Zero Unnecessary Dependencies**: Default to Python standard library (`sys`, `os`, `argparse`, `pathlib`, `json`, `urllib`) for core utilities so scripts run immediately on clean environments.
- **Type Annotations**: Use modern type hinting (`typing` / built-in generics) for functions and public interfaces.
- **Graceful Degradation**: When optional rich third-party libraries (e.g., `rich`, `typer`, `pydantic`) are beneficial, wrap imports in `try/except ImportError` blocks with graceful standard library fallbacks.
- **Code Style**: Follow PEP 8 guidelines: clear variable names, docstrings for functions/classes, and explicit exception handling (never bare `except:`).

## 3. CLI Design & Ergonomics
- Provide `--help` / `-h` flags for all tools with clear usage examples, available flags, and default values.
- Return meaningful exit codes: `0` for success, non-zero (`1`, `2`) for failures.
- Use ANSI color formatting sparingly to guide attention (`GREEN` for success, `RED` for errors, `CYAN` for paths/commands, `YELLOW` for warnings), and disable styling when stdout is not a TTY.
