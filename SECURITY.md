# Security policy

## Reporting a vulnerability

If you believe you've found a security issue in this repository — in a skill, an install script, a workflow, or anywhere else — please **do not open a public GitHub issue**.

Instead, email **demetrisd25@gmail.com** with:

- A description of the issue.
- Steps to reproduce.
- The impact you believe it has.
- Your name and a way to credit you (optional).

You will receive an acknowledgement within **3 business days** and a status update within **7 business days**.

## Scope

What we consider in scope:

- Skill content that could materially mislead an agent into producing unsafe code, exfiltrating secrets, escalating privileges, or evading authorized security controls.
- Install scripts that could compromise a user's machine on execution.
- Repository workflows that could leak secrets or grant unintended write access.

What is out of scope:

- General advice in a skill that you disagree with. Open a regular issue or PR.
- Vulnerabilities in third-party tools the skills reference. Report those to the tool's maintainers.
- Hypothetical risks with no realistic exploit.

## Disclosure

We follow coordinated disclosure. Once a fix is available and users have had a reasonable window to upgrade, the issue may be disclosed publicly with credit to the reporter unless they prefer to remain anonymous.

## Supply chain

This repository:

- Contains no executable application code beyond shell install scripts.
- Pins no third-party dependencies (the skills are Markdown).
- Uses signed commits for maintainer releases when feasible.

If you spot a supply-chain risk we've missed, the report process above applies.
