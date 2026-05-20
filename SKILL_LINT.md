# Skill lint

This repo ships a small CI linter that guards the shape of every `SKILL.md`
and every subagent definition. It runs on every pull request and on every
push to `main`. If it fails, the PR cannot merge until the listed files
are fixed.

The linter is intentionally narrow. It enforces the contract that
orchestrators and IDEs rely on, nothing more. Prose quality is reviewed by
humans.

## What gets checked

For every file matching `skills/*/*/SKILL.md`:

1. The file starts with a YAML frontmatter block delimited by `---` lines,
   and the block parses cleanly with PyYAML.
2. The `name:` field equals the parent folder name. For example, a file at
   `skills/personas/staff-software-architect/SKILL.md` must declare
   `name: staff-software-architect`.
3. A `description:` field is present and non empty. The full description
   block, including the `description:` key and any folded value lines,
   stays under 1024 characters. Both Claude Code and Codex preload only
   this field, so the limit is a hard cap, not a guideline.
4. The body of the file (everything after the closing `---`) contains
   zero em-dash characters. The style guide bans them.

For every file matching `subagents/*.md`:

1. The file has a parseable YAML frontmatter block.
2. The frontmatter has a `name` key and a `description` key, both non
   empty.
3. The only keys present are `name`, `description`, `tools`, `model`. The
   last two are optional. Any other key fails the check.

Anything not covered above is out of scope for the linter. Section order,
heading style, line counts, and trigger word coverage are the author's job
and the reviewer's job.

## Running locally

From the repo root:

```bash
pip install PyYAML
python3 scripts/validate-skills.py
```

The script prints one line per file, either `PASS <path>` or `FAIL <path>`
followed by indented reasons. At the end it prints a summary like
`checked 42 file(s), 0 failure(s)` and exits with code `0` on full green
or `1` if any file failed.

You can run it against a single branch before pushing to avoid a red CI
run. The script has no side effects and writes nothing.

## Common failures and fixes

`name 'foo' does not match folder 'foo-bar'`
: The folder was renamed but the frontmatter was not, or vice versa. Pick
  one spelling and apply it to both. The folder name is the canonical
  identifier.

`description missing or empty`
: The frontmatter has no `description:` key, or the value is blank. Add a
  trigger oriented description following the style guide.

`description block is 1183 chars, must be under 1024`
: Trim the description. Drop adjectives that do not add trigger words.
  Move long examples into the body. Keep the verbs and nouns a user would
  type.

`body contains N em-dash character(s)`
: Replace each em dash character (U+2014) with a comma, a colon, or a sentence
  break. Many editors auto convert two hyphens into an em dash, so check
  editor settings as well.

`yaml parse error: ...`
: The frontmatter is not valid YAML. Common causes: a stray tab, an
  unquoted colon inside a value, or a missing closing `---`. Paste the
  frontmatter into a YAML validator to find the line.

`missing required key: name`
: A subagent file is missing its `name:` or `description:` field. Both
  are mandatory.

`unknown keys: ['memory']`
: A subagent file has a key outside the allowed set. The allowed set is
  `name`, `description`, `tools`, `model`. If a new key is genuinely
  needed, update the linter in the same PR.

## How CI uses it

The workflow lives at `.github/workflows/validate-skills.yml`. It runs on
Ubuntu latest, installs Python 3.12, installs PyYAML, and runs the
script. The job fails if the script exits non zero. The failed log lists
every offending file with its reasons, so a contributor can fix in one
pass.

The check is required on the `main` branch. To add or remove rules,
update `scripts/validate-skills.py` and this doc in the same PR so the
contract stays in sync.
