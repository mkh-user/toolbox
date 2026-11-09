# Security Policy

Security and credential integrity are fundamental tenets of the `toolbox` repository and its agent rulesets.

---

## Supported Versions

Only the latest commit on `main` receives active security fixes.

| Version | Supported |
|---|---|
| Latest `main` | Yes |
| Earlier releases | No |

---

## Reporting a Vulnerability

If you discover a security vulnerability, credential leak, or sensitive flaw in this repository or its tools:

- **Do Not Open a Public Issue**: Do not file a public GitHub issue or pull request disclosing the vulnerability.
- **Reporting Channel**: Send an email directly to the maintainer at `khalili1388mahan@gmail.com` with the subject line `[SECURITY] Toolbox Vulnerability Report`.
- **Include Details**:
  - Description of the vulnerability.
  - Minimal reproducible example or command demonstration.
  - Affected files and potential remediation steps.

Maintainers will respond within 48 hours to confirm receipt and coordinate a patch.

---

## Security Principles and Credential Protection

All tools and AI agents operating within this project must strictly uphold the [Safety Rules](agent/rules/safety.md):

- **Zero Secret Exposure**: Tokens, API keys, private keys, and passwords must never be committed to git, logged in terminal output, or written to disk.
- **Isolation of Credentials**: Platform tokens must be sourced strictly from environment variables or secure platform stores such as Google Colab Userdata.
- **Automated Scanning**: The static scanner `./toolbox audit check` checks for exposed credential patterns and private key headers.

---

## Contributor Guidelines

For contribution and pull request standards, refer to [CONTRIBUTING.md](CONTRIBUTING.md).
