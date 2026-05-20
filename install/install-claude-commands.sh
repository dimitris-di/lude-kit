#!/usr/bin/env bash
# Symlink every slash command in ./commands/<name>.md into ~/.claude/commands/<name>.md
# After install, invoke them as /<name> [args] inside Claude Code.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="$REPO_ROOT/commands"
DST="${CLAUDE_COMMANDS_DIR:-$HOME/.claude/commands}"

if [[ ! -d "$SRC" ]]; then
  echo "error: $SRC does not exist" >&2
  exit 1
fi

mkdir -p "$DST"

installed=0
skipped=0
while IFS= read -r -d '' src_file; do
  base="$(basename "$src_file")"
  target="$DST/$base"

  if [[ -L "$target" ]]; then
    current="$(readlink "$target")"
    if [[ "$current" == "$src_file" ]]; then
      skipped=$((skipped + 1))
      continue
    fi
    rm "$target"
  elif [[ -e "$target" ]]; then
    echo "skip: $target exists and is not a symlink (leaving alone)" >&2
    skipped=$((skipped + 1))
    continue
  fi

  ln -s "$src_file" "$target"
  echo "linked: ${base%.md}"
  installed=$((installed + 1))
done < <(find "$SRC" -mindepth 1 -maxdepth 1 -name '*.md' -print0)

echo
echo "Claude Code slash commands install complete. $installed linked, $skipped skipped."
echo "Commands directory: $DST"
echo "Invoke them inside Claude Code as /<name> [args]."
