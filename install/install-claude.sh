#!/usr/bin/env bash
# Symlink every skill in ./skills/<category>/<name>/ into ~/.claude/skills/<name>/
# Idempotent: rerunning updates broken symlinks, leaves intact ones alone.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_SRC="$REPO_ROOT/skills"
SKILLS_DST="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"

if [[ ! -d "$SKILLS_SRC" ]]; then
  echo "error: $SKILLS_SRC does not exist" >&2
  exit 1
fi

mkdir -p "$SKILLS_DST"

installed=0
skipped=0
# Find every SKILL.md two levels deep: skills/<category>/<skill>/SKILL.md
while IFS= read -r -d '' skill_md; do
  skill_dir="$(dirname "$skill_md")"
  name="$(basename "$skill_dir")"
  target="$SKILLS_DST/$name"

  if [[ -L "$target" ]]; then
    current="$(readlink "$target")"
    if [[ "$current" == "$skill_dir" ]]; then
      skipped=$((skipped + 1))
      continue
    fi
    rm "$target"
  elif [[ -e "$target" ]]; then
    echo "skip: $target exists and is not a symlink (leaving alone)" >&2
    skipped=$((skipped + 1))
    continue
  fi

  ln -s "$skill_dir" "$target"
  echo "linked: $name"
  installed=$((installed + 1))
done < <(find "$SKILLS_SRC" -mindepth 3 -maxdepth 3 -name SKILL.md -print0)

echo
echo "Claude Code install complete. $installed linked, $skipped skipped."
echo "Skills directory: $SKILLS_DST"
