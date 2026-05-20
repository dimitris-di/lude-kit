# FAQ

Answers to the questions a new visitor or contributor is most likely to ask. If something is missing, open a [Discussion](https://github.com/dimitris-di/LudeSkills/discussions) once the repo is public, or email **demetrisd25@gmail.com**.

## What is this?

### What is LudeSkills?

LudeSkills is a curated library of senior grade Agent Skills for Claude Code and OpenAI Codex. Every skill encodes one role or one job at the bar of a senior practitioner, with a precise `description` that activates it only when the user's intent matches. The library currently ships seventy skills across personas, capabilities, and stack experts, with one hundred as the target before public release. Install once and the right specialist shows up automatically when triggers fire in a real prompt. See the [README](README.md) for the pitch and the full catalog at [`skills/README.md`](skills/README.md).

### What is an Agent Skill?

An Agent Skill is a folder containing a single `SKILL.md` with YAML frontmatter and a Markdown body, following the open [Agent Skills specification](https://agentskills.io/specification). The matcher preloads only the `description` at startup; the body loads only when triggered. That progressive disclosure keeps the context window cheap until the skill is actually needed.

### How is this different from a custom system prompt?

A system prompt is always on and pays the token cost on every turn, whether it is relevant or not. A skill is dormant until its trigger matches, then loads a focused brief for that turn. You can have seventy skills installed and pay for none of them on a turn that does not need any. See the `How a skill works` section in the [README](README.md).

### How is this different from an MCP server?

An MCP server exposes tools, resources, and data to a model. A skill is instructions and judgement, the brief a senior would carry into the room. They compose well: a skill tells the model how to think about a problem, an MCP server gives it the data and actions to act on. A skill is not a replacement for an MCP server, and an MCP server is not a replacement for a skill.

### How does it differ from frameworks like AutoGPT, CrewAI, LangChain agents?

Those frameworks are runtimes. They orchestrate loops, tool calls, and memory. LudeSkills is content, the role briefs that any runtime can route to. The skills format is platform native to Claude Code and Codex; you do not write Python glue to use them, you drop the folder and the host handles dispatch. If you build your own orchestrator on top of Claude or Codex, the same skills compose into your flow.

## Using the library

### Which platforms does it support?

Claude Code and OpenAI Codex today, via the open [Agent Skills specification](https://agentskills.io/specification). One folder, one `SKILL.md`, both hosts. The portable frontmatter in [`shared/style-guide.md`](shared/style-guide.md) is the contract. Platform specific config, when ever needed, lives in sibling files (`agents/claude.yaml`, `agents/openai.yaml`), never inside `SKILL.md`.

### Does it work with Claude Desktop / Claude API directly?

Skills are a Claude Code primitive, not a Claude Desktop or raw API one. If you are calling the Claude API directly you can still reuse a skill body as a system prompt scaffold for a single role, but you lose the automatic trigger dispatch. The full value is in the host: Claude Code, Codex, or an orchestrator you build that respects the spec.

### Will skills work in subagents I spawn?

Yes. Subagents inherit the installed skill library and the matcher pulls the right skill into the spawned conversation when its triggers fire. The 30 curated subagents in [`subagents/`](subagents/) are designed for exactly this; each one pins a model where it matters and locks in the relevant skill.

### Will skills work in plugins / agentic systems built on top of Claude Code?

Yes, as long as the host honors the Agent Skills spec and reads from the standard install path. The install scripts symlink into `~/.claude/skills/` and `~/.agents/skills/`, so anything that respects those paths picks up the catalog for free.

### Do I need to do anything to enable a skill once installed?

No. After running `./install/install-claude.sh` or `./install/install-codex.sh` the host picks up every skill on the next session. Trigger phrases in your prompts pull the right ones automatically. The README `Quickstart` covers the three install commands.

### How do I disable a specific skill I do not want?

Delete the symlink for that skill from your install directory, for example `rm ~/.claude/skills/<skill-name>`. The source folder under `skills/` stays untouched, and a future `git pull` will not resurrect the symlink unless you rerun the install script. If you want a permanent local override, fork the repo and remove the skill folder.

## Skills vs subagents

### What is the difference?

A skill loads on demand inside an existing conversation when its trigger description matches. A subagent is a named entry point you (or an orchestrator) explicitly dispatch via the `Agent` tool; it spawns a fresh conversation with a constrained toolset, a pinned model, and the relevant skill preloaded. Skills are the brief; subagents are the doorway.

### When should I create a subagent vs author a new skill?

Start with a skill. A skill is the lower cost, higher reuse unit, it composes into any conversation that fits its triggers. Add a subagent only when you also need a dedicated dispatch surface: a constrained tool set, a pinned model, or a stable name an orchestrator can call by hand. The 30 subagents in [`subagents/`](subagents/) all wrap existing skills.

### Why are skills better than copy pasting system prompts?

A copy pasted prompt is always on, lives in one chat, and rots the moment you tweak it elsewhere. A skill is versioned, reviewable, composable with other skills, and only pays its token cost when its triggers fire. The same skill works across Claude Code and Codex without duplication, and the `Handoffs` section in each skill names the partner skills so the library composes into multi step flows.

### Can a subagent and a skill share the same name?

In practice they do not, because the subagents in this library wrap skills and use shorter dispatch names (for example `architect` wraps `staff-software-architect`). Nothing in the spec forbids name overlap, but mirroring the skill name on the subagent makes routing ambiguous, so we avoid it.

## Authoring

### How do I propose a new skill?

Open a `new-skill` issue first using the template in [`.github/ISSUE_TEMPLATE/new-skill.yml`](.github/ISSUE_TEMPLATE/new-skill.yml), describing the role or job, the artifacts it produces, and why it is distinct from existing skills. Once accepted, follow the authoring workflow in [`CONTRIBUTING.md`](CONTRIBUTING.md). One skill per PR.

### Can I fork and customize a skill for my company?

Yes, the license is `Apache-2.0`. Fork the repo, edit the skill folder, install from your fork. If your edits are reusable across organizations and meet the bar in [`shared/style-guide.md`](shared/style-guide.md), upstream them via a PR. Company specific process belongs in your fork, not in the main library.

### What is the license? Can I use this commercially?

`Apache-2.0`. Use it, fork it, ship it, embed it in commercial products. Keep the license file and the copyright notice. See [LICENSE](LICENSE).

### How long should a skill be?

Under 500 lines and ~5,000 tokens for the body, with the `description` under 1024 characters. The body follows the nine section structure in [`shared/style-guide.md`](shared/style-guide.md). If a section does not pull its weight, cut it.

### Why is the description so important?

The matcher preloads only the `description`. If the description does not contain the verbs and nouns a real user would type, the skill never activates, no matter how well written the body is. Treat it as a search query, not a tagline. The trigger vocabulary in [`shared/trigger-vocabulary.md`](shared/trigger-vocabulary.md) is house style.

## Quality and safety

### Are the skills opinionated? Whose opinions?

Yes, deliberately. Each skill carries the operating principles of a senior practitioner in that role, drawn from a maintainer with practical experience and from public best practice in that field. Opinions are stated and defended in the body. A skill that hedges on every principle would be useless to dispatch.

### What if I disagree with a principle in a skill?

Open an issue or a PR with the counter argument and the evidence. Disagreement on substance is welcome; the bar is that the new position has to be defensible at the senior level, not just preference. The maintainers will not flip a principle on taste alone.

### Are security and AI safety skills defensive only?

Yes. Skills like `principal-security-engineer`, `senior-ai-safety-engineer`, `compliance-engineer`, and `dependency-auditor` are scoped to systems the user owns or is authorized to test. They will not produce offensive tooling, exploitation payloads, or attacks on third party infrastructure. See [`SECURITY.md`](SECURITY.md).

### Is anything in here AI generated slop?

No. Every skill is hand authored, reviewed against [`shared/style-guide.md`](shared/style-guide.md), and verified against real prompts before merging. AI is used for drafting and editing the way any author uses tooling, but a skill that adds no signal over the model's defaults is declined. See the `Verification` section of the style guide.

## Roadmap and community

### When will this be public?

Once batch 10 ships and the bar holds across the full one hundred skill catalog. Seventy of one hundred have landed; batches 8, 9, 10 are planned. See the `Roadmap` table in the [README](README.md).

### How can I help reach 100 skills?

Open a `new-skill` issue against the roadmap, claim a slot, and submit a PR that meets the bar. Reviews of existing skills (typos, missing handoffs, tightened triggers) are also welcome and ship faster than new skill PRs. Read [`CONTRIBUTING.md`](CONTRIBUTING.md) first.

### Is there a Discord / community space?

Not yet. Once the repo is public, GitHub Discussions on the repo is the canonical space. A Discord may follow if there is enough sustained activity to justify it.

### How do I report a bug?

Open a GitHub issue with a minimal reproduction: the prompt you ran, the skill you expected, the skill that activated, and the host (Claude Code or Codex) with version. Bugs in a specific skill should reference the skill name in the title.

### How do I report a security issue?

Do not open a public issue. Follow the responsible disclosure process in [`SECURITY.md`](SECURITY.md). Security sensitive changes inside the repo also require a second reviewer; see the `Review timeline` section of [`CONTRIBUTING.md`](CONTRIBUTING.md).
