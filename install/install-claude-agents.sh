#!/usr/bin/env bash
# Symlink every subagent in ./subagents/<name>.md into ~/.claude/agents/<name>.md
# Idempotent: re-running updates broken symlinks, leaves intact ones alone.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
AGENTS_SRC="$REPO_ROOT/subagents"
AGENTS_DST="${CLAUDE_AGENTS_DIR:-$HOME/.claude/agents}"

if [[ ! -d "$AGENTS_SRC" ]]; then
  echo "error: $AGENTS_SRC does not exist" >&2
  exit 1
fi

mkdir -p "$AGENTS_DST"

installed=0
skipped=0
while IFS= read -r -d '' src; do
  name="$(basename "$src")"
  target="$AGENTS_DST/$name"

  if [[ -L "$target" ]]; then
    current="$(readlink "$target")"
    if [[ "$current" == "$src" ]]; then
      skipped=$((skipped + 1))
      continue
    fi
    rm "$target"
  elif [[ -e "$target" ]]; then
    echo "skip: $target exists and is not a symlink (leaving alone)" >&2
    skipped=$((skipped + 1))
    continue
  fi

  ln -s "$src" "$target"
  echo "linked: $name"
  installed=$((installed + 1))
done < <(find "$AGENTS_SRC" -mindepth 1 -maxdepth 1 -name '*.md' -print0)

echo
echo "Claude Code subagents install complete. $installed linked, $skipped skipped."
echo "Subagents directory: $AGENTS_DST"
