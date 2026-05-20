# Roadmap

This is the working roadmap for Lude Kit. It covers what shipped, what is planned through the 1.0 milestone at 100 skills, and where the project could go after that. The repo is already public on GitHub at https://github.com/dimitris-di/lude-kit under `Apache-2.0`.

The roadmap is a living document. Priorities shift with community signal and with the platforms (Claude Code, Codex) themselves. See [How priorities change](#how-priorities-change) at the bottom.

## Current state

| Metric | Value |
|---|---|
| Skills shipped | 70 |
| Batches shipped | 7 of 10 |
| Personas | 40 |
| Capabilities | 10 |
| Stacks | 20 |
| Subagents shipped | 30 |
| Slash commands shipped | 10 |
| Status | Public alpha, 70 of 100 skills, already open sourced under `Apache-2.0`. Pushing to one hundred. |
| 1.0 milestone | At 100 skills (after batch 10) |
| License | `Apache-2.0` |

The 30 subagents split into 10 specialists (named entry points around the highest leverage skills), 10 orchestrators (multi skill flows like feature build, incident response, migration, launch), and 10 library maintenance agents (skill author, reviewer, deduplicator, trigger tightener, catalog updater, eval runner, and similar).

The 10 slash commands wrap common multi agent reviews into one keystroke each: `/review-macos-app`, `/review-website`, `/review-api-service`, `/review-mobile-app`, `/review-cli-tool`, `/prep-oss-release`, `/security-audit`, `/perf-audit`, `/a11y-audit`, `/lude-style`. They install into `~/.claude/commands/` and `~/.codex/prompts/`.

## Shipped (batches 1 to 7)

| Batch | Theme | Count | Recap |
|---|---|---|---|
| 1 | SDLC personas | 10 | The team you would staff a feature with: architect, tech lead, PM, UX, frontend, backend, DevOps/SRE, QA, security, tech writer. |
| 2 | Capability skills | 10 | Cross role power tools: code review, debugging, refactoring, performance engineering, incident command, API contract design, data modeling, migration planning, dependency auditing, postmortem authoring. |
| 3 | Stack experts | 10 | First wave of stack specialists: Rails, Django, Next.js, Kubernetes, Postgres, Terraform, Redis, AWS, GCP, Swift/iOS. |
| 4 | Specialty personas | 10 | Roles outside the default SDLC slice: data, ML, MLOps, data science, mobile, embedded, game, blockchain, platform, developer advocate. |
| 5 | Industry verticals | 10 | Domain shaped engineers: fintech, healthcare, gov tech, edtech, ecommerce, media streaming, IoT fleet, automotive, compliance, logistics. |
| 6 | AI engineering | 10 | LLM app, AI agent, RAG, eval, fine tuning, voice AI, computer vision, recommender, model router, AI safety. |
| 7 | Language and framework stacks | 10 | Go, Rust, Python, TypeScript, Java, C#/.NET, Flutter, React Native, Tailwind, Playwright. |

Every shipped skill follows the nine section structure from the [style guide](shared/style-guide.md) (Role, When to invoke, Operating principles, Workflow, Deliverables, Quality bar, Antipatterns, Handoffs, Quick reference) and was hand reviewed against the trigger vocabulary before merging.

## Planned (batches 8 to 10)

### Batch 8: more capabilities (10)

Cross role capability skills that fill obvious gaps in the current library. These are not personas; they are jobs that cut across roles.

| Skill | One liner |
|---|---|
| `accessibility-auditor` | WCAG 2.2 audits, keyboard and screen reader sweeps, remediation plans. |
| `i18n-strategist` | Localization architecture, ICU MessageFormat, RTL, locale matrices. |
| `feature-flag-strategist` | Flag taxonomy, kill switches, rollout rings, flag debt cleanup. |
| `chaos-engineer` | Game days, failure injection, blast radius bounding, hypothesis design. |
| `cost-optimizer` | FinOps, unit economics per request, rightsizing, commitment strategy. |
| `legacy-modernizer` | Strangler fig migrations, seam finding, dead code excavation. |
| `release-train-conductor` | Release calendars, freeze windows, change advisory boards, rollback drills. |
| `oncall-coach` | Rotation design, paging hygiene, runbook authoring, on call onboarding. |
| `developer-experience-engineer` | Local dev loops, build speed, golden paths, internal tooling. |
| `documentation-strategist` | Information architecture for docs, doc as code, freshness systems. |

These slot under `skills/capabilities/` and bring the capability count to 20.

### Batch 9: AI infra plus more verticals (10)

Half AI infrastructure, half new industry verticals where the library currently has gaps.

AI infrastructure (3):

| Skill | One liner |
|---|---|
| `vector-db-engineer` | pgvector, Pinecone, Weaviate, Qdrant, hybrid search, recall vs latency. |
| `gpu-infra-engineer` | GPU pools, scheduling, MIG, spot fleets, NCCL, training cluster operations. |
| `model-serving-engineer` | Triton, vLLM, TGI, batching, KV cache, autoscaling for inference. |

Verticals (7):

| Skill | One liner |
|---|---|
| `gaming-platform-engineer` | Matchmaking, live ops, anti cheat, account systems for games. |
| `traveltech-engineer` | GDS integrations, fare search, PNR lifecycle, ancillaries. |
| `agritech-engineer` | Field data pipelines, satellite imagery, farm management systems. |
| `energy-grid-engineer` | SCADA, smart meter data, DERMS, market settlement. |
| `realestate-tech-engineer` | MLS feeds, listings, valuation models, transaction workflows. |
| `legaltech-engineer` | Contract intelligence, case management, citation handling, redlining. |
| `cybersecurity-product-engineer` | Building security products (EDR, SIEM, scanner) versus defending one. |

This batch lands the count at 90 and rounds out the most asked for AI infra surface.

### Batch 10: hardening pass

Batch 10 is not 10 new skills. It is the gate to 1.0.

| Workstream | Output |
|---|---|
| Cross skill review | Every description re read for trigger overlap and gap coverage. Antitriggers tightened where two skills compete. |
| Description polish | Consistency pass across all 100 descriptions: verb shape, synonym coverage, antitrigger placement, char budget. |
| Trigger eval | A curated prompt set is run against the catalog. Each prompt has expected and forbidden activations. Misfires are fixed at the description layer, not in the body. |
| Handoff audit | Every `Handoffs` section is verified against the actual catalog. No dead references. |
| Catalog regen | `skills/README.md` and `subagents/README.md` regenerated from frontmatter. |
| Hardening pass for 1.0 | Cross skill polish, trigger eval, docs site (see below), examples site, marketing badges, contribution flow, issue templates, security policy, CoC. |

The release is no longer the gating event. Quality is. Batch 10 ships when the catalog reads as one library, not as ten batches stapled together.

## Beyond 100

Post 1.0 directions worth considering. None of these are committed; they are the candidate set for what comes after the 1.0 milestone lands.

### Codex first class support

The library already targets both Claude Code and Codex through the open Agent Skills spec. A focused parity audit would confirm every skill triggers correctly on both, and codify Codex specific overrides (model hints, tool restrictions, sandbox settings) under `agents/openai.yaml` siblings where useful. Today most skills do not need either platform file; that should stay the default.

### More language packs

Triggers are currently English only. A user who types "diseña un sistema de facturación" gets nothing useful from a description full of English verbs. Language packs would ship localized trigger phrases (Spanish, Japanese, German first) alongside the English ones, without forking the body. Open question: a sibling description per locale, or a single multilingual description.

### A docs site

GitHub README plus `skills/README.md` is fine at 100 skills. It will not scale to 200. Candidates: Mintlify, Nextra, Docusaurus. The site is generated from frontmatter so the source of truth stays in the skill folders.

### An eval harness

Batch 10 runs a one shot trigger eval. A standing eval harness would turn that into CI: every PR runs the prompt set and reports activation deltas, so a trigger regression in one skill is caught the moment the description changes. The `skill-eval-runner` subagent is the seed.

### Skill marketplace and discovery UI

A browsable catalog with filters (category, stack, vertical, capability) and a search that previews the trigger description and the body. Lower priority than the eval harness, but useful for newcomers.

### Skill versioning and changelog per skill

`metadata.version` already exists in frontmatter. The next step is a per skill `CHANGELOG.md` and a semver discipline so consumers can pin or upgrade individual skills. Useful once external teams depend on specific skill behavior.

### Plugin packaging

If Claude Code plugins become the recommended distribution path, package Lude Kit as a plugin so installation is one command. Same for Codex if the equivalent ships. The symlink installers stay as the fallback for users on bare configs.

## How priorities change

This roadmap is a working document, not a commitment. The order and contents of batches 8 to 10 will move based on:

- Community signal: which gaps real users hit first.
- Platform changes: when Claude Code or Codex ship new primitives, skills adapt before new skills land.
- Maintenance load: a stale skill is worse than a missing one. Hardening always wins over breadth.

If you want to propose a change to the roadmap, open a Discussion first. PRs that add a skill not on the roadmap are welcome but should link to a Discussion that argues for it. The bar to add a skill is the same as the bar to keep one: it produces a distinct artifact, it has a tight trigger, and it does not duplicate a skill that already ships.
