<div align="center">

# LudeSkills

**A library of senior grade Agent Skills for Claude Code and OpenAI Codex.**

*Drop in a whole engineering org. Dispatch the right specialist when you need them.*

[![License](https://img.shields.io/badge/license-Apache--2.0-blue.svg)](LICENSE)
[![Skills](https://img.shields.io/badge/skills-10-brightgreen.svg)](skills/README.md)
[![Spec](https://img.shields.io/badge/spec-Agent%20Skills-purple.svg)](https://agentskills.io/specification)
[![Status](https://img.shields.io/badge/status-private%20alpha-orange.svg)](#status)

</div>

---

## What is this

LudeSkills is a curated, opinionated set of **Agent Skills**, folders of Markdown that turn a general purpose AI agent into a senior specialist on demand. Drop the library into your environment and the right skill activates automatically when its triggers match the work in front of you.

Each skill is one role or one job, written to the bar of a senior practitioner. They're designed to be composed: an architect produces a design, an engineer implements it, a security principal reviews it, a tech writer documents it, all in the same multi agent session.

The library follows the open [Agent Skills specification](https://agentskills.io/specification), so the same folder runs on **Claude Code** and **OpenAI Codex** with no per platform duplication.

## Why

General purpose AI coding agents are competent at everything and excellent at nothing. They behave like a smart generalist who has read a lot but never shipped a feature. Skills change that. A skill is a small, focused brief that pulls the agent into the mindset, opinions, and deliverables of a specific role, for the duration of the task, and only when it's relevant.

LudeSkills gives you:

- **A team in a folder.** Ten senior roles spanning the SDLC; more coming.
- **Multi agent ready.** Each skill names its handoff partners, so orchestrators can dispatch the right one at the right time.
- **Cross platform.** Same files work on Claude Code and Codex. Install once, use anywhere.
- **Opinionated, not generic.** Every skill encodes specific, defensible practices a senior engineer would defend in a review.
- **Compose, don't bloat.** Triggers are precise. Skills load only when relevant. No prompt bloat from unused capabilities.

## Status

**Private alpha.** First 10 skills landed; review and refinement in progress. The library will be open sourced under Apache-2.0 once the first 100 skills land and stabilize.

## Quickstart

```bash
git clone git@github.com:dimitris-di/LudeSkills.git
cd LudeSkills

# Claude Code (symlinks into ~/.claude/skills/)
./install/install-claude.sh

# OpenAI Codex (symlinks into ~/.agents/skills/)
./install/install-codex.sh
```

The scripts symlink, so future `git pull`s update your installed skills without rerunning anything.

Custom install location:

```bash
CLAUDE_SKILLS_DIR=/path/to/claude/skills ./install/install-claude.sh
CODEX_SKILLS_DIR=/path/to/agents/skills  ./install/install-codex.sh
```

Try it out:

```
> "Help me design the database schema for a multi-tenant SaaS billing system"
  → senior-backend-engineer activates.

> "I need to break this epic into tickets for the team this sprint"
  → engineering-team-lead activates.

> "Review this auth flow for IDOR and CSRF risk"
  → principal-security-engineer activates.
```

## What's in the library

| Category | Count | What it contains |
|---|---|---|
| [`personas/`](skills/personas/) | 10 | Senior grade role personas an orchestrator can dispatch to. |
| [`capabilities/`](skills/capabilities/) | 0 | Cross role capabilities focused on a single job. *Planned: batch 2.* |
| [`stacks/`](skills/stacks/) | 0 | Stack specific experts (Rails, Kubernetes, Postgres, …). *Planned: batch 3.* |

Full catalog with descriptions and links: **[`skills/README.md`](skills/README.md)**.

### Batch 1 (shipped): the SDLC personas

A 10 skill team spanning the software development lifecycle:

- **[`staff-software-architect`](skills/personas/staff-software-architect/SKILL.md)**, system design, tech selection, ADRs, build vs buy.
- **[`engineering-team-lead`](skills/personas/engineering-team-lead/SKILL.md)**, sprint planning, ticket breakdown, unblocking, delegation.
- **[`senior-product-manager`](skills/personas/senior-product-manager/SKILL.md)**, PRDs, prioritization, user stories, launch plans.
- **[`senior-ux-designer`](skills/personas/senior-ux-designer/SKILL.md)**, flows, IA, wireframe critique, microcopy, usability.
- **[`senior-frontend-engineer`](skills/personas/senior-frontend-engineer/SKILL.md)**, React/Next/Vue/Svelte, a11y, performance, design systems.
- **[`senior-backend-engineer`](skills/personas/senior-backend-engineer/SKILL.md)**, APIs, data modeling, queues, idempotency, migrations.
- **[`senior-devops-sre`](skills/personas/senior-devops-sre/SKILL.md)**, CI/CD, IaC, observability, on call & incident response.
- **[`senior-qa-test-engineer`](skills/personas/senior-qa-test-engineer/SKILL.md)**, test strategy, pyramid, regression, flake hunting.
- **[`principal-security-engineer`](skills/personas/principal-security-engineer/SKILL.md)**, threat modeling, secure review, OWASP, secrets.
- **[`senior-technical-writer`](skills/personas/senior-technical-writer/SKILL.md)**, READMEs, API refs, changelogs, onboarding docs.

## How it works

Each skill is a folder containing a single `SKILL.md` with YAML frontmatter and a Markdown body. The frontmatter holds the metadata that matchers use to decide when to activate the skill; the body holds the brief that loads only on activation. This is **progressive disclosure**, your context window stays cheap until the skill is actually needed.

```
skills/personas/staff-software-architect/
└── SKILL.md
```

```yaml
---
name: staff-software-architect
description: >
  Use when designing a system, choosing a database / framework / cloud /
  message bus, writing an ADR or RFC, deciding build vs buy, planning capacity
  or scaling, reviewing an architecture diagram or proposal, sequencing a
  migration, or weighing technical trade-offs at the CTO level.
license: Apache-2.0
metadata:
  version: "1.0.0"
  category: persona
---

# Staff Software Architect

## Role
...
```

Every skill in this library follows the same nine section structure, Role → When to invoke → Operating principles → Workflow → Deliverables → Quality bar → Antipatterns → Handoffs → Quick reference, so an orchestrator can scan many of them quickly and so reviewers know exactly what's missing.

## Multi agent composition

LudeSkills is designed for orchestrator-style setups where a coordinating agent spawns subagents with specific roles. Every skill ends with a **Handoffs** section that names the partner skills for adjacent work, so the library composes:

```
User: "We want to add team SSO to the dashboard."

→ senior-product-manager       writes the one-pager + success metric
→ staff-software-architect     picks SAML vs OIDC, writes the ADR
→ principal-security-engineer  threat models the auth flow
→ senior-ux-designer           flows sign in + invite + role switch
→ senior-frontend-engineer     implements the UI
→ senior-backend-engineer      implements endpoints + sessions
→ senior-qa-test-engineer      writes the regression suite
→ senior-devops-sre            rolls out behind a flag, sets SLOs
→ senior-technical-writer      writes admin doc + release notes
```

## Roadmap

| Batch | Theme | Status |
|---|---|---|
| 1 | SDLC personas (architect → writer) | ✅ shipped |
| 2 | Capability skills (review, debug, refactor, perf, postmortem, …) | planned |
| 3 | Stack experts (Rails, Django, Next.js, K8s, Postgres, Terraform, …) | planned |
| 4 | Specialty roles (data engineer, ML engineer, mobile, embedded) | planned |
| 5 | Industry verticals (fintech, healthcare, gov, edu) | planned |

Target: **100 skills** before the public open source release. Want to shape what comes next? Open a [new-skill issue](.github/ISSUE_TEMPLATE/new-skill.yml).

## Contributing

PRs welcome once the repo is public. The bar is high and the process is opinionated, read [`CONTRIBUTING.md`](CONTRIBUTING.md) before opening one. Quick links:

- [Contribution guide](CONTRIBUTING.md), workflow, structure, commit style.
- [Style guide](shared/style-guide.md), the authoring bar.
- [Trigger vocabulary](shared/trigger-vocabulary.md), house-style for descriptions.
- [Skill template](shared/skill-template/SKILL.md), copy-paste starting point.
- [Code of Conduct](CODE_OF_CONDUCT.md).
- [Security policy](SECURITY.md).

## Who's behind this

Built and maintained by **Dimitris Dimitriou** ([@dimitris-di](https://github.com/dimitris-di)). The library is hand-written, reviewed, and battle tested in real engineering workflows before it ships.

Questions, ideas, or pushback? Open a [Discussion](https://github.com/dimitris-di/LudeSkills/discussions) (once the repo is public) or reach out at **demetrisd25@gmail.com**.

## Acknowledgments

- The open [Agent Skills specification](https://agentskills.io/specification) for the cross platform format.
- [Anthropic Claude Code](https://docs.claude.com/en/docs/claude-code/skills) and [OpenAI Codex](https://developers.openai.com/codex/skills) for shipping skills as first class primitives.
- Every engineer whose habits, opinions, and war stories made it into these skills.

## License

[Apache-2.0](LICENSE). Use it, fork it, ship it.
