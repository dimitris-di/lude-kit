# AGENTS.md

Conventions for AI agents (Codex, Claude Code, Cursor, Aider, Copilot) working inside this repo.

## What this repo is

A library of senior grade Agent Skills for multi agent orchestration. Every entry under `skills/` is one self contained role or capability, authored to the [open Agent Skills specification](https://agentskills.io/specification) so it runs unchanged on Claude Code and OpenAI Codex.

## Layout

```
skills/
  personas/      <skill-name>/SKILL.md
  capabilities/  <skill-name>/SKILL.md
  stacks/        <skill-name>/SKILL.md
  README.md                     # full catalog
shared/
  style-guide.md                # authoring bar, read before writing a skill
  trigger-vocabulary.md         # canonical verbs/synonyms for descriptions
  skill-template/SKILL.md       # starting point for new skills
install/                        # install scripts for Claude and Codex
.github/                        # issue + PR templates
README.md
CONTRIBUTING.md
CODE_OF_CONDUCT.md
SECURITY.md
LICENSE                         # Apache-2.0
```

## Rules for changes

1. **Read `shared/style-guide.md` before touching any `SKILL.md`.** It defines the structure every skill in this repo follows.
2. **Folder name must match the `name:` field.** Lowercase kebab, 1 to 64 chars, no leading/trailing/consecutive hyphens.
3. **Only portable frontmatter in `SKILL.md`**, `name`, `description`, `license`, `metadata`. Platform specific config goes in sibling files (`agents/openai.yaml`, `agents/claude.yaml`), never in `SKILL.md`.
4. **Description front loads triggers.** It is the matcher, not a tagline. Under 1024 chars.
5. **Body under 500 lines / ~5,000 tokens.** Single file per skill in batch 1.
6. **No emojis** unless the deliverable template demands one.

## Testing a skill

A skill is considered correct when:

1. Its `description` alone would route a user with the relevant intent to this skill and not a sibling.
2. Its body, read top to bottom, leaves no question about what artifact it produces and when to defer.
3. It cleanly hands off to the right partner skill for work outside its scope.

There are no automated tests yet; skill review is manual against `shared/style-guide.md` §Verification.

## Commit messages

Conventional commits. One skill per commit when possible.

```
feat(skills): add senior-backend-engineer
docs(style-guide): clarify description char budget
fix(skill/senior-frontend-engineer): tighten triggers
```

## Out of scope

- Per skill `AGENTS.md` files. AGENTS.md is a repo level convention, not a skill format. Skills use `SKILL.md`.
- Vendor locked patterns in `SKILL.md` frontmatter. Use sibling files for that.
