# Agent Safety & Autonomy Rules

These rules govern agent behavior when proposing changes, modifying files, and executing commands within any workspace or repository.

## 1. Ask Before Destructive or Ambiguous Work
- Always seek explicit user clarification or confirmation before:
  - Deleting or overwriting non-temporary files.
  - Rewriting repository architecture, directories, or core workflows.
  - Making assumptions on ambiguous or high-impact requirements.
- Use structured question mechanisms (or clear multiple-choice prompts) when presenting decisions to minimize ambiguity.

## 2. Zero Secret & Credential Exposure
- **Never hardcode secrets**: API keys, OAuth tokens, private SSH keys, and passwords must never be committed to version control or written to source files.
- **Never print secrets in logs or terminal outputs**: Use masked strings (`gho_****`) or suppress verbose output when handling tokens.
- Rely strictly on environment variables or dedicated platform secrets managers (e.g., Google Colab Secrets `userdata.get()`).
- Verify `.gitignore` contains patterns for `.env`, `*.pem`, `*.key`, `*token*`, and secret directories before writing credentials.

## 3. Safe, Idempotent Execution
- Ensure scripts and setup tasks are idempotent: running them multiple times must not corrupt state or fail unexpectedly.
- Scripts must test prerequisites (e.g., checking directory existence or command availability with `command -v`) before proceeding.
- Prefer non-destructive checks (`status`, `--dry-run`) before executing mutating actions.

## 4. Preservation of Existing Work
- Preserve user comments, license headers, and documentation unless explicitly instructed to update them.
- Avoid introducing breaking changes into public CLI commands or library APIs without backward compatibility or migration warnings.
