# Examples

Concrete prompts, the skills that activate, and the artifacts they produce. Use this page to get a feel for what the library does in practice and how the pieces compose into multi step work.

Every example below assumes the library is installed. Skills activate automatically when their trigger descriptions match the prompt. Subagents are dispatched explicitly via the `Agent` tool.

---

## Single skill activations

Fifteen prompts a developer might actually type, and what shows up when they hit enter.

> "Help me design the database schema for a multi tenant SaaS billing system."

→ Activates: `staff-software-architect`, `senior-backend-engineer`, `data-modeler`, `fintech-engineer`.
→ Produces:
- ADR on tenant isolation strategy (row, schema, or database).
- Double entry ledger schema with money type, currency, and posting rules.
- Idempotency design for charge and refund endpoints.
- PCI scope diagram with tokenization boundary.

> "This Postgres query takes 4 seconds. EXPLAIN ANALYZE attached."

→ Activates: `postgres-expert`, `senior-performance-engineer`, `senior-debugger`.
→ Produces:
- Annotated walkthrough of the plan, identifying the dominant cost.
- Index recommendation with before and after row estimates.
- Autovacuum tuning for the hot table.
- A repro script and a regression test that asserts the new plan.

> "We need SOC 2 Type 2 by end of Q3. Where do we start?"

→ Activates: `compliance-engineer`, `principal-security-engineer`, `senior-devops-sre`.
→ Produces:
- Gap assessment against the Trust Services Criteria.
- Control library with owner and evidence source per control.
- Evidence automation plan wired into CI and the cloud account.
- A 90 day plan with weekly milestones and the auditor RFP draft.

> "Build a RAG pipeline over our 12,000 support articles."

→ Activates: `senior-rag-engineer`, `senior-eval-engineer`, `senior-llm-app-engineer`.
→ Produces:
- Chunking and embedding strategy with citations.
- Hybrid retrieval design (BM25 plus dense) with a reranker.
- A gold set of 200 questions with expected citations.
- Eval harness with regression gates and slice metrics.

> "Our React Native app crashes on Android 12 only. Repro inconsistent."

→ Activates: `react-native-expert`, `senior-mobile-engineer`, `senior-debugger`.
→ Produces:
- Hypothesis tree for the crash class (native module, JSI, Reanimated worklet).
- Minimal repro plan with device matrix and OS variants.
- Fix candidate with rollback path.
- Crash watch dashboard and a staged rollout plan via EAS.

> "Design the API for our orders system. Public, versioned, idempotent."

→ Activates: `api-contract-designer`, `senior-backend-engineer`.
→ Produces:
- OpenAPI 3.1 spec with pagination, filtering, and error envelope.
- Idempotency key contract and replay semantics.
- Versioning policy and deprecation timeline.
- A contract test suite scaffold.

> "We had a sev2 last night. Need the postmortem by Friday."

→ Activates: `postmortem-author`, `incident-commander`.
→ Produces:
- Blameless writeup with UTC timeline anchored to log links.
- Contributing factors grouped into prevent, detect, mitigate.
- Action item table with owners and due dates.
- A two paragraph executive summary.

> "Build a voice agent that answers calls from our 1-800 line."

→ Activates: `senior-voice-ai-engineer`, `senior-llm-app-engineer`, `senior-ai-safety-engineer`.
→ Produces:
- Latency budget: time to first audio under 800ms.
- Barge in and turn taking spec.
- Telephony integration plan (Twilio SIP, mu law, 8 kHz).
- Prompt injection defense for tool calls.

> "Live stream our conference with under 5 second glass to glass latency."

→ Activates: `media-streaming-engineer`.
→ Produces:
- LL-HLS or CMAF chunked packaging plan with target latency budget.
- ABR ladder for desktop, mobile, and smart TV.
- DRM key flow if access controls are needed.
- QoE telemetry plan (startup time, rebuffer ratio, VSF).

> "Patient portal needs to ingest lab results from a state HIE."

→ Activates: `healthcare-engineer`, `api-contract-designer`, `compliance-engineer`.
→ Produces:
- FHIR R4 resource mapping for Observation and DiagnosticReport.
- HL7 v2 ORU bridge if the HIE still emits v2.
- PHI handling boundary and HIPAA audit log requirements.
- BAA checklist and data flow diagram.

> "Roll out OTA firmware to 200,000 fielded thermostats safely."

→ Activates: `iot-fleet-engineer`, `senior-embedded-engineer`, `senior-devops-sre`.
→ Produces:
- Staged rollout plan with rings, health gates, and automatic rollback.
- A/B partition layout and bootloader handoff.
- Bandwidth and dollars per device per month budget.
- Reconnect storm mitigation when a wave reboots.

> "Audit our smart contract before the token launch on Monday."

→ Activates: `senior-blockchain-engineer`, `principal-security-engineer`.
→ Produces:
- Threat model covering reentrancy, oracle manipulation, MEV.
- Findings list with severity and a fix or accept decision.
- Test plan including invariant fuzzing.
- A go or no go recommendation with explicit unknowns.

> "Our government services site fails WCAG 2.1 AA in three places."

→ Activates: `gov-tech-engineer`, `senior-ux-designer`, `senior-frontend-engineer`.
→ Produces:
- Audit of the three violations with code level fixes.
- Plain language rewrite of the affected pages.
- Keyboard and screen reader test matrix.
- A regression check wired into CI.

> "Customers report duplicate charges when they retry checkout."

→ Activates: `fintech-engineer`, `senior-debugger`, `senior-backend-engineer`.
→ Produces:
- Root cause hypothesis tree starting from the idempotency key.
- Reconciliation query against the processor.
- Fix with replay safe contract.
- Customer comms template and refund script.

> "Our Next.js app spends 3 seconds in hydration on slow phones."

→ Activates: `nextjs-expert`, `senior-frontend-engineer`, `senior-performance-engineer`.
→ Produces:
- RSC versus client boundary review.
- Bundle analyzer pass identifying the top three offenders.
- Streaming and Suspense plan to push interactivity earlier.
- A Lighthouse mobile target and a CI budget.

---

## Multi step orchestration

Three end to end stories. Each shows the orchestrator dispatching named subagents in sequence, with the artifact handed to the next step.

### Story 1: shipping team SSO to the dashboard

Goal: add SAML and OIDC sign in, invitation flow, and role switching to the customer dashboard. Six week target.

1. `orchestrate-feature-build` reads the request, drafts the dispatch plan, and queues the steps below.
2. `senior-product-manager` writes the one pager. Returns the problem statement, target user, success metric (activation of SSO at the org level within 30 days), and a cut line for the MVP.
3. `staff-software-architect` writes the ADR. Returns the choice (support both SAML 2.0 and OIDC, OIDC first), session model, and the build versus buy decision against WorkOS and Auth0.
4. `principal-security-engineer` threat models the flow. Returns a STRIDE table, signed assertion validation rules, and a checklist for SAML XML signature wrapping.
5. `senior-ux-designer` flows the surfaces. Returns wireframes for sign in, invite, role switch, and the admin connection setup screen, plus microcopy.
6. `senior-backend-engineer` implements the endpoints. Returns connection model, session refresh, the SCIM 2.0 user provisioning endpoints, and migration scripts.
7. `senior-frontend-engineer` builds the UI. Returns the React components, the admin console screens, and Playwright tests for the happy path.
8. `senior-qa-test-engineer` writes the regression suite. Returns SAML and OIDC fixtures for the top five IdPs and a checklist for tenant isolation.
9. `senior-devops-sre` rolls out behind a flag. Returns the launch plan, SLOs for the auth path, and a kill switch.
10. `senior-technical-writer` writes the admin guide and the release notes. Returns the docs and a customer email template.

Final artifact set: one pager, ADR, threat model, design files, code, test suite, SLO sheet, rollout plan, customer docs.

### Story 2: an LLM powered customer support copilot

Goal: ship a copilot inside the support agent console that drafts replies grounded in the help center and the customer's recent tickets.

1. `orchestrate-ai-feature` plans the work, names the eval gate as the entry condition for code, and dispatches.
2. `senior-eval-engineer` builds the gold set first. Returns 150 labeled tickets across categories (billing, account, technical), slice metrics, and a regression threshold the system must clear before each release.
3. `senior-rag-engineer` designs retrieval. Returns chunking strategy for help center articles, an embedding choice, hybrid BM25 plus dense retrieval, a reranker, and citation rules.
4. `senior-llm-app-engineer` implements the app. Returns the prompt as code, structured output schema, retry policy, and the call site that emits eval traces.
5. `senior-ai-safety-engineer` reviews for prompt injection. Returns the indirect injection test set (poisoned articles, poisoned ticket content), a tool authorization matrix, and the output safety pipeline.
6. `senior-model-router-engineer` configures the gateway. Returns the route config (Claude as primary, GPT as fallback), cost tracking per call site, a semantic cache, and per tenant rate limits.
7. `senior-frontend-engineer` builds the console UI. Returns the draft panel, citation chips, the accept and edit flow, and keyboard shortcuts.
8. `senior-devops-sre` rolls out. Returns the staged launch (5 percent, then 25, then 100), the kill switch, the dashboard, and the on call runbook.

Final artifact set: gold set, retrieval pipeline, app code, safety review, gateway config, UI, rollout plan. The eval gate stays wired into CI so future prompt changes do not regress quality.

### Story 3: production incident at 3 a.m.

Goal: page fires, customer impact suspected, structured response.

1. Page fires. `orchestrate-incident-response` activates and opens the war room.
2. `ic-coordinator` declares the incident at sev2, assigns roles (IC, comms, ops, scribe), and posts the first status update within five minutes. Returns role assignments and the live timeline doc.
3. `senior-devops-sre` mitigates. Identifies the bad deploy from the dashboard, rolls back, confirms error rate dropping. Returns the mitigation log entry.
4. `ic-coordinator` posts an interim status and an all clear when error rates hold flat for 15 minutes. Returns the all clear announcement and a handoff to investigation.
5. `senior-debugger` hunts root cause once stable. Reproduces the failure in staging, isolates the regression to a specific commit, and proposes the fix. Returns a written root cause with evidence links.
6. `postmortem-writer` produces the writeup within 48 hours. Returns the blameless postmortem with timeline, contributing factors, and an action item table.
7. Action items dispatched: `senior-qa-test-engineer` adds the regression test, `senior-devops-sre` tightens the deploy gate, `senior-technical-writer` updates the runbook. Each returns a tracked ticket and a PR link.

Final artifact set: incident timeline, mitigation log, root cause writeup, postmortem, three follow up PRs.

---

## Direct subagent dispatch

Skills activate automatically. Subagents are explicit. Call them by name when you want to pin a role for a chunk of work.

```
Agent(subagent_type: "architect",
      prompt: "Design the schema for our orders system. Multi region. EU and US. Strong consistency on order state, eventual on analytics.")

Agent(subagent_type: "code-reviewer",
      prompt: "Review the diff in this branch with severity labeled feedback. Focus on the payments package.")

Agent(subagent_type: "security-reviewer",
      prompt: "Threat model the new public webhook endpoint. STRIDE plus replay and signature forgery.")

Agent(subagent_type: "perf-investigator",
      prompt: "Checkout p95 went from 400ms to 1.8s after last Tuesday. Find the dominant cost.")

Agent(subagent_type: "debugger",
      prompt: "Intermittent 500 on POST /charges, roughly 1 in 200 requests. Stack trace and request id attached.")

Agent(subagent_type: "orchestrate-bug-fix",
      prompt: "Customer reports duplicate charges on retry. Stack trace attached. Plan the fix end to end.")

Agent(subagent_type: "orchestrate-migration",
      prompt: "Move billing off Stripe Charges API to PaymentIntents without downtime. 4 million active customers.")

Agent(subagent_type: "postmortem-writer",
      prompt: "Sev2 yesterday, payment processor outage masked by our retry storm. Slack transcript and timeline attached.")
```

Subagents return artifacts to the calling conversation. Chain them by feeding one's output into the next.

---

## Skill chaining patterns

Three patterns that cover most multi step work.

### Sequential

One role finishes, the next picks up the artifact. Use when each step depends on the previous one.

```
senior-product-manager  → PRD
staff-software-architect → ADR
senior-backend-engineer → implementation
senior-qa-test-engineer → regression suite
senior-technical-writer → docs and release notes
```

### Parallel

Independent reviews on the same artifact, run at the same time. Use for audits where the perspectives do not overlap.

```
On the same PR:
  principal-security-engineer  → security findings
  senior-performance-engineer  → perf findings
  senior-ux-designer           → a11y and usability findings

Merge the three review reports into one comment thread on the PR.
```

### Conditional

Dispatch a specialist only if the problem matches their triggers. Use to keep the context window cheap.

```
If the diff touches money or ledgers → fintech-engineer
If the diff touches PHI              → healthcare-engineer
If the diff touches a public surface → principal-security-engineer
If the bundle grew more than 5 KB    → senior-performance-engineer + nextjs-expert
If the change is to a smart contract → senior-blockchain-engineer (blocking)
```

The orchestrator subagents (`orchestrate-feature-build`, `orchestrate-bug-fix`, `orchestrate-security-review`, and the rest) bake these patterns in. Call the orchestrator when you want the planning done for you. Call the individual specialists when you already know the shape of the work.

---

## A note on activation

Skills are matched by their `description` field, not by keyword soup. If a prompt does not pull the skill you expect, the fix is usually one of:

- The prompt is too abstract. Add the concrete noun or verb the skill lists.
- Two skills overlap and the wrong one wins. Open an issue with the prompt and both descriptions.
- The work belongs to a skill that does not exist yet. Open a `new-skill` issue.

The catalog in [`skills/README.md`](skills/README.md) lists every skill with a one liner. The trigger vocabulary in [`shared/trigger-vocabulary.md`](shared/trigger-vocabulary.md) shows the house style for descriptions so you can predict what activates.
