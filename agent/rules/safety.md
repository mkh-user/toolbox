# Agent Safety and Autonomy Rules

Operational guidelines governing agent behavior when proposing changes, modifying files, and executing commands within any workspace or repository.

---

## Ask Before Destructive or Ambiguous Work

- Always seek explicit user clarification or confirmation before:
  - Deleting or overwriting non-temporary files.
  - Rewriting repository architecture, directories, or core workflows.
  - Making assumptions on ambiguous or high-impact requirements.
- Use structured question mechanisms with clear multiple-choice prompts when presenting decisions to minimize ambiguity.

---

## Zero Secret and Credential Exposure

- **Never Hardcode Secrets**: API keys, OAuth tokens, private SSH keys, and passwords must never be committed to version control or written to source files.
- **Never Print Secrets in Logs or Terminal Outputs**: Use masked strings or suppress verbose output when handling tokens.
- Rely strictly on environment variables or dedicated platform secrets managers such as Google Colab Secrets.
- Verify `.gitignore` contains patterns for `.env`, `*.pem`, `*.key`, `*token*`, and secret directories before writing credentials.

---

## Safe and Idempotent Execution

- Ensure scripts and setup tasks are idempotent: running them multiple times must not corrupt state or fail unexpectedly.
- Scripts must test prerequisites, such as checking directory existence or command availability, before proceeding.
- Prefer non-destructive checks such as `status` or `--dry-run` before executing mutating actions.

---

## Preservation of Existing Work

- Preserve user comments, license headers, and documentation unless explicitly instructed to update them.
- Avoid introducing breaking changes into public CLI commands or library APIs without backward compatibility or migration warnings.
