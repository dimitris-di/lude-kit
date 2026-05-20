#!/usr/bin/env bash
# Install Lude Kit subagents into Codex as skills.
#
# Codex has no native "subagent" primitive equivalent to Claude Code's
# ~/.claude/agents/. Each subagent definition file (subagents/<name>.md)
# is functionally a skill: a description with trigger phrases plus a system
# prompt body. This script wraps each as a Codex skill folder:
#
#   ~/.agents/skills/<name>/SKILL.md  ->  <repo>/subagents/<name>.md
#
# Codex follows symlinks; the inner SKILL.md is a symlink to the source.
# Codex ignores frontmatter keys it doesn't recognize (`tools`, `model`),
# so the file is compatible without editing.
#
# Idempotent: re-running heals broken symlinks and leaves intact ones alone.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="$REPO_ROOT/subagents"
DST="${CODEX_SKILLS_DIR:-$HOME/.agents/skills}"

if [[ ! -d "$SRC" ]]; then
  echo "error: $SRC does not exist" >&2
  exit 1
fi

mkdir -p "$DST"

installed=0
skipped=0
while IFS= read -r -d '' src_file; do
  base="$(basename "$src_file" .md)"
  target_dir="$DST/$base"
  target_md="$target_dir/SKILL.md"

  mkdir -p "$target_dir"

  if [[ -L "$target_md" ]]; then
    current="$(readlink "$target_md")"
    if [[ "$current" == "$src_file" ]]; then
      skipped=$((skipped + 1))
      continue
    fi
    rm "$target_md"
  elif [[ -e "$target_md" ]]; then
    echo "skip: $target_md exists and is not a symlink (leaving alone)" >&2
    skipped=$((skipped + 1))
    continue
  fi

  ln -s "$src_file" "$target_md"
  echo "linked: $base"
  installed=$((installed + 1))
done < <(find "$SRC" -mindepth 1 -maxdepth 1 -name '*.md' -print0)

echo
echo "Codex subagents-as-skills install complete. $installed linked, $skipped skipped."
echo "Skills directory: $DST"
