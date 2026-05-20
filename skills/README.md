# Skills catalog

The full index of skills in this library. Use this page to browse what's available, find handoff partners, and check what's planned but not yet written.

Each entry links to the skill's `SKILL.md`, which is the canonical source of truth.

---

## Personas

Senior grade role personas an orchestrator can dispatch to. Treat them like the people you'd staff a feature with, design, build, secure, ship, support.

| Skill | Job in one line |
|---|---|
| [`staff-software-architect`](personas/staff-software-architect/SKILL.md) | System design, tech selection, ADRs, build vs buy, CTO-grade tradeoffs. |
| [`engineering-team-lead`](personas/engineering-team-lead/SKILL.md) | Sprint planning, ticket breakdown, unblocking, delegation, 1:1 prep. |
| [`senior-product-manager`](personas/senior-product-manager/SKILL.md) | PRDs, prioritization, user stories, roadmaps, launch plans. |
| [`senior-ux-designer`](personas/senior-ux-designer/SKILL.md) | User flows, IA, wireframe critique, microcopy, usability heuristics. |
| [`senior-frontend-engineer`](personas/senior-frontend-engineer/SKILL.md) | React/Next/Vue/Svelte, a11y, perf budgets, design system consumption. |
| [`senior-backend-engineer`](personas/senior-backend-engineer/SKILL.md) | API design, data modeling, services, queues, idempotency. |
| [`senior-devops-sre`](personas/senior-devops-sre/SKILL.md) | CI/CD, IaC, observability, on call & incident response. |
| [`senior-qa-test-engineer`](personas/senior-qa-test-engineer/SKILL.md) | Test strategy, pyramid, e2e, regression, flake hunting. |
| [`principal-security-engineer`](personas/principal-security-engineer/SKILL.md) | Threat modeling, secure code review, OWASP, secrets hygiene. |
| [`senior-technical-writer`](personas/senior-technical-writer/SKILL.md) | READMEs, API references, changelogs, onboarding docs. |

## Capabilities

Cross role capabilities focused on a single job. Personas reach for these the way a person reaches for a power tool.

*Empty for now. Planned for the next batch, see [§Roadmap](../README.md#roadmap).*

## Stacks

Stack specific experts that complement the personas with technology depth.

*Empty for now. Planned for batch 3, see [§Roadmap](../README.md#roadmap).*

---

## How to read a skill

Every skill in this library follows the same nine section structure so you can scan many of them quickly:

1. **Role**, who this skill is when invoked.
2. **When to invoke**, verbose trigger situations.
3. **Operating principles**, the opinions that shape the work.
4. **Workflow**, concrete steps the skill follows.
5. **Deliverables**, the artifacts it produces, with templates.
6. **Quality bar**, the self-verification checklist.
7. **Antipatterns**, what this skill explicitly does not do.
8. **Handoffs**, when to defer to another skill.
9. **Quick reference**, cheat sheet for reactivation.

If you're contributing, the same nine sections are required. See [`shared/style-guide.md`](../shared/style-guide.md).

## Composition example

A realistic multi agent flow that uses several skills together:

```
User: "We want to add team SSO to the dashboard."

→ senior-product-manager       writes the one-pager and success metric
→ staff-software-architect     picks SAML vs OIDC, writes the ADR
→ principal-security-engineer  threat models the auth flow
→ senior-ux-designer           flows the sign in + invite + role switch
→ senior-frontend-engineer     implements the UI
→ senior-backend-engineer      implements the endpoints + sessions
→ senior-qa-test-engineer      writes the regression suite
→ senior-devops-sre            rolls out behind a flag, sets the SLOs
→ senior-technical-writer      writes the admin doc and the release notes
```

Each skill knows which skill to hand off to next, see the **Handoffs** section of any `SKILL.md`.
