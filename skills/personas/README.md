# Personas

Senior grade role personas an orchestrator can dispatch to.

Each skill in this folder represents a senior practitioner of a specific role. They are designed to compose: an architect produces a design, an engineer implements it, a security principal reviews it, a tech writer documents it.

See the [full catalog](../README.md) for the list and links.

## What makes a skill belong here

A skill belongs under `personas/` if it:

- Represents a coherent **role** that exists at most engineering organizations.
- Holds opinions about how that role should operate that go beyond defaults.
- Produces durable, named **artifacts** (PRDs, ADRs, plans, reviews) rather than generic advice.
- Composes cleanly with the other personas via explicit handoffs.

## What does not belong here

- Single-job capabilities (`code-reviewer`, `debugger`, `postmortem-author`), those go under `capabilities/`.
- Stack specific experts (`rails-expert`, `kubernetes-expert`), those go under `stacks/`.
- Skills that wrap a vendor product, those belong with that vendor.

## Authoring a new persona

1. Open a "new skill" issue first to confirm fit.
2. Copy [`shared/skill-template/SKILL.md`](../../shared/skill-template/SKILL.md) into a new folder here.
3. Follow [`shared/style-guide.md`](../../shared/style-guide.md).
4. Name the handoff partners explicitly so the library composes.
