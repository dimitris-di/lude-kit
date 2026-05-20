# Capabilities

Cross-role capabilities focused on a single job. Personas reach for these the way a person reaches for a power tool.

A capability skill is narrower than a persona and broader than a vendor wrapper. It encodes one job — review this PR, debug this stack trace, write this postmortem — and does it excellently regardless of the surrounding role.

## Planned (batch 2)

- `senior-code-reviewer` — PR review with severity-labeled, blocking-grade feedback.
- `senior-debugger` — root-cause diagnosis from logs / repros / stack traces.
- `senior-refactorer` — incremental, behavior-preserving structural change.
- `senior-performance-engineer` — find and fix latency / throughput / memory regressions.
- `incident-commander` — coordinate live incident response.
- `api-contract-designer` — design REST / GraphQL / gRPC contracts before code.
- `data-modeler` — schema design, normalization, indexing.
- `migration-planner` — sequence destructive changes safely.
- `dependency-auditor` — supply-chain and CVE review.
- `postmortem-author` — blameless postmortems with action items.

See the [open roadmap issues](https://github.com/dimitris-di/LudeSkills/issues?q=is%3Aissue+label%3Anew-skill) for current proposals.

## Authoring a capability

1. Open a "new skill" issue first.
2. Copy [`shared/skill-template/SKILL.md`](../../shared/skill-template/SKILL.md) into a new folder here.
3. Capabilities lean harder on **Workflow** and **Deliverables** than personas do — the job is narrow, so the steps and outputs should be sharp.
4. Name the personas that typically reach for this capability under **Handoffs**.
