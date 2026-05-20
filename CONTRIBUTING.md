# Contributing to LudeSkills

Thanks for thinking about contributing. This library succeeds or fails on the quality of each skill, so the bar is high and the process is opinionated. Read this in full before opening your first PR.

## TL;DR

1. Pick or propose a skill. Open a "new skill" issue first if it doesn't already exist in [`skills/README.md`](skills/README.md) or the roadmap.
2. Copy [`shared/skill-template/SKILL.md`](shared/skill-template/SKILL.md) into the right category folder.
3. Write to the bar defined in [`shared/style-guide.md`](shared/style-guide.md). No exceptions.
4. Self review against the §Quality bar section inside your own skill.
5. Open a PR using the template. One skill per PR.

## What belongs in this library

A skill belongs here if it meets all of these:

- **Reusable across organizations.** Skills that encode a single company's internal process don't belong; skills that encode an industry standard role or capability do.
- **Self contained.** The skill produces value without depending on private APIs, vendor accounts, or proprietary data.
- **Senior grade.** The skill matches the judgement of a senior practitioner of that role, not a junior reading a checklist.
- **Distinct.** No meaningful overlap with an existing skill. If the overlap is real, propose merging or splitting in an issue first.

## What does not belong

- Skills that wrap a single product's CLI (those belong in that product's own plugin).
- Skills that automate destructive or unauthorized operations.
- Personal preferences disguised as best practices.
- "Be more X" persona skills with no concrete deliverable.

## Categories

Skills live under one of three categories. Pick the one that fits best, when in doubt, open an issue.

| Category | What it contains | Examples |
|---|---|---|
| `skills/personas/` | Senior grade role personas an orchestrator can dispatch to. | `staff-software-architect`, `senior-frontend-engineer` |
| `skills/capabilities/` | Cross role capabilities focused on a single job. | `code-reviewer`, `debugger`, `postmortem-author` |
| `skills/stacks/` | Stack or technology specific experts. | `rails-expert`, `kubernetes-expert`, `terraform-expert` |

## The bar

Every skill must:

1. Have a `SKILL.md` whose folder name matches the `name:` field exactly (lowercase kebab, 1 to 64 chars, no leading/trailing/consecutive hyphens).
2. Use only the portable frontmatter, `name`, `description`, `license`, `metadata`. Platform specific config goes in sibling files (`agents/openai.yaml`, `agents/claude.yaml`), never in `SKILL.md`.
3. Have a `description` that front loads trigger phrases, names antitriggers, and stays under 1024 characters.
4. Stay under 500 lines / ~5,000 tokens of body.
5. Follow the 9 section structure: Role → When to invoke → Operating principles → Workflow → Deliverables → Quality bar → Antipatterns → Handoffs → Quick reference.
6. Name handoff partners by skill name in backticks so the library composes.

Read [`shared/style-guide.md`](shared/style-guide.md) before claiming any of the above is done.

## Authoring workflow

```bash
# 1. fork + clone
git clone git@github.com:<you>/LudeSkills.git
cd LudeSkills

# 2. branch
git switch -c skill/your-skill-name

# 3. scaffold from the template
mkdir -p skills/<category>/your-skill-name
cp shared/skill-template/SKILL.md skills/<category>/your-skill-name/SKILL.md

# 4. write the skill. iterate.

# 5. self-review against shared/style-guide.md §Verification

# 6. install locally and try it in a real prompt
./install/install-claude.sh    # or install-codex.sh
```

## Commit messages

Conventional Commits. One skill per commit when possible.

```
feat(skills): add senior-rails-expert
feat(skills): add capabilities/code-reviewer
docs(style-guide): clarify description char budget
fix(skill/senior-frontend-engineer): tighten triggers
chore: bump install script to walk nested categories
```

Allowed types: `feat`, `fix`, `docs`, `chore`, `refactor`, `test`, `style`.

## Pull request expectations

- One skill per PR. New category additions are a separate PR.
- The PR description follows [`.github/PULL_REQUEST_TEMPLATE.md`](.github/PULL_REQUEST_TEMPLATE.md).
- The PR author has self verified against §Verification in the style guide.
- The author has installed the skill locally and tried it in a real prompt at least once.
- No reformatting of unrelated skills in the same PR.

Reviewers will check the description triggers, the body structure, and (subjectively but seriously) whether the skill would change behavior usefully when activated. A skill that adds no signal over the model's defaults will be declined.

## Review timeline

- New skill PRs: first review within 7 days.
- Edits / fixes to existing skills: first review within 3 days.
- Security sensitive changes (anything that grants new tool permissions or touches `principal-security-engineer`): require a second reviewer.

## Code of Conduct

Participation is governed by [`CODE_OF_CONDUCT.md`](CODE_OF_CONDUCT.md). Be kind. Disagree with the work, not the person.

## Reporting security issues

Do **not** open public issues for security findings. See [`SECURITY.md`](SECURITY.md).

## License

By contributing you agree that your contributions are licensed under the project's [Apache-2.0 license](LICENSE).
