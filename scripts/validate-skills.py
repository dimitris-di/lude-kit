#!/usr/bin/env python3
"""Validate SKILL.md and subagent files in this repo.

Checks per SKILL.md:
  1. Frontmatter is parseable YAML.
  2. `name` matches the parent folder name.
  3. `description` exists and the full `description:` block (key plus value)
     is under 1024 characters.
  4. The body contains zero em-dash characters.

Checks per subagent file (subagents/*.md):
  1. Frontmatter is parseable YAML.
  2. Required keys: name, description. Optional: tools, model.

Exit code is 0 only if every file passes.
"""
from __future__ import annotations

import os
import sys
from pathlib import Path

import yaml

REPO_ROOT = Path(__file__).resolve().parent.parent
SKILLS_DIR = REPO_ROOT / "skills"
SUBAGENTS_DIR = REPO_ROOT / "subagents"

EM_DASH = "—"
DESC_LIMIT = 1024


def split_frontmatter(text: str):
    """Return (frontmatter_str, body_str) or (None, text) if no frontmatter."""
    if not text.startswith("---\n") and not text.startswith("---\r\n"):
        return None, text
    rest = text.split("\n", 1)[1]
    end = rest.find("\n---")
    if end == -1:
        return None, text
    fm = rest[:end]
    body_start = end + len("\n---")
    body = rest[body_start:]
    if body.startswith("\n"):
        body = body[1:]
    return fm, body


def extract_description_block(fm_text: str) -> str:
    """Return the raw `description:` block including key, for length check."""
    lines = fm_text.splitlines()
    out = []
    in_desc = False
    desc_indent = None
    for line in lines:
        stripped = line.lstrip()
        if not in_desc:
            if stripped.startswith("description:"):
                in_desc = True
                desc_indent = len(line) - len(stripped)
                out.append(line)
            continue
        if line.strip() == "":
            out.append(line)
            continue
        cur_indent = len(line) - len(line.lstrip())
        if cur_indent > desc_indent:
            out.append(line)
        else:
            break
    return "\n".join(out)


def check_skill(path: Path) -> list[str]:
    errs: list[str] = []
    text = path.read_text(encoding="utf-8")
    fm_text, body = split_frontmatter(text)
    if fm_text is None:
        errs.append("missing frontmatter")
        return errs
    try:
        data = yaml.safe_load(fm_text)
    except yaml.YAMLError as e:
        errs.append(f"yaml parse error: {e}")
        return errs
    if not isinstance(data, dict):
        errs.append("frontmatter is not a mapping")
        return errs

    folder_name = path.parent.name
    name = data.get("name")
    if name != folder_name:
        errs.append(f"name '{name}' does not match folder '{folder_name}'")

    desc = data.get("description")
    if not desc or not str(desc).strip():
        errs.append("description missing or empty")
    else:
        # Per the open Agent Skills spec, description value is capped at 1024 chars.
        # Measure the resolved value, not the raw YAML block (which includes the
        # key and indentation overhead).
        desc_str = str(desc).strip()
        if len(desc_str) > DESC_LIMIT:
            errs.append(
                f"description is {len(desc_str)} chars, must be <= {DESC_LIMIT}"
            )

    if EM_DASH in body:
        count = body.count(EM_DASH)
        errs.append(f"body contains {count} em-dash character(s)")

    return errs


def check_subagent(path: Path) -> list[str]:
    errs: list[str] = []
    text = path.read_text(encoding="utf-8")
    fm_text, _ = split_frontmatter(text)
    if fm_text is None:
        errs.append("missing frontmatter")
        return errs
    try:
        data = yaml.safe_load(fm_text)
    except yaml.YAMLError as e:
        errs.append(f"yaml parse error: {e}")
        return errs
    if not isinstance(data, dict):
        errs.append("frontmatter is not a mapping")
        return errs

    if "name" not in data or not str(data.get("name", "")).strip():
        errs.append("missing required key: name")
    if "description" not in data or not str(data.get("description", "")).strip():
        errs.append("missing required key: description")

    allowed = {"name", "description", "tools", "model"}
    extras = set(data.keys()) - allowed
    if extras:
        errs.append(f"unknown keys: {sorted(extras)}")

    return errs


def main() -> int:
    results: list[tuple[Path, list[str]]] = []

    if SKILLS_DIR.is_dir():
        for skill_md in sorted(SKILLS_DIR.glob("*/*/SKILL.md")):
            results.append((skill_md, check_skill(skill_md)))

    if SUBAGENTS_DIR.is_dir():
        for sub in sorted(SUBAGENTS_DIR.glob("*.md")):
            results.append((sub, check_subagent(sub)))

    failures = 0
    for path, errs in results:
        rel = path.relative_to(REPO_ROOT)
        if errs:
            failures += 1
            print(f"FAIL {rel}")
            for e in errs:
                print(f"  - {e}")
        else:
            print(f"PASS {rel}")

    total = len(results)
    print()
    print(f"checked {total} file(s), {failures} failure(s)")
    return 1 if failures else 0


if __name__ == "__main__":
    sys.exit(main())
