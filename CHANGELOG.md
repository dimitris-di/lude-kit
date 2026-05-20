# Changelog

All notable changes to Lude Kit are documented here.

The format follows [Keep a Changelog](https://keepachangelog.com/) and the project follows [Semantic Versioning](https://semver.org/). Releases are date stamped rather than version numbered until the catalog stabilizes at 100 skills.

## Unreleased

_Nothing yet._

## 2026-05-21 Public release

**Repository**
- Renamed from `LudeSkills` to `lude-kit` on GitHub. Old URL redirects.
- Flipped to public visibility under Apache-2.0.
- Added repo topics: claude-code, claude-skills, openai-codex, agent-skills, ai-agents, llm, multi-agent, subagents, prompt-engineering, developer-tools.

**Added**
- `CHANGELOG.md`, `ROADMAP.md`, `FAQ.md`, `EXAMPLES.md`, `SKILL_LINT.md`.
- `scripts/validate-skills.py` plus `.github/workflows/validate-skills.yml` for CI validation.
- 30 dispatchable subagents under `subagents/`, grouped as 10 specialists (`architect`, `code-reviewer`, `security-reviewer`, `debugger`, `refactorer`, `perf-investigator`, `test-engineer`, `tech-writer`, `ic-coordinator`, `postmortem-writer`), 10 orchestrators (`orchestrate-feature-build`, `orchestrate-incident-response`, `orchestrate-migration`, `orchestrate-launch`, `orchestrate-security-review`, `orchestrate-perf-investigation`, `orchestrate-refactor`, `orchestrate-ai-feature`, `orchestrate-new-service`, `orchestrate-bug-fix`), and 10 library maintenance agents (`skill-author-persona`, `skill-author-capability`, `skill-author-stack`, `skill-reviewer`, `skill-trigger-tightener`, `skill-deduplicator`, `skill-handoff-auditor`, `skill-freshness-checker`, `skill-catalog-updater`, `skill-eval-runner`).
- `install/install-claude-agents.sh` for installing subagents into `~/.claude/agents/`.

**Changed**
- Project wide prose hyphen sweep: every English word compound hyphen removed. Identifiers, license names, and tech tokens preserved.
- All 70 skill descriptions trimmed to within the 1024 char spec cap.
- 9 subagent descriptions converted to YAML folded blocks to fix parse failures.
- README rewritten as an open source landing page with Quickstart, Subagents section, Docs section, and validation note.

## Batch history

### Batch 7 (shipped 2026-05-21) language and framework stack experts

**Added**
- `golang-expert`, `rust-expert`, `python-expert`, `typescript-expert`, `java-expert`, `csharp-dotnet-expert`, `flutter-expert`, `react-native-expert`, `tailwind-expert`, `playwright-expert`.

### Batch 6 (shipped 2026-05-20) AI engineering personas

**Added**
- `senior-llm-app-engineer`, `senior-ai-agent-engineer`, `senior-rag-engineer`, `senior-eval-engineer`, `senior-fine-tuning-engineer`, `senior-voice-ai-engineer`, `senior-cv-engineer`, `senior-recommender-engineer`, `senior-model-router-engineer`, `senior-ai-safety-engineer`.

### Batch 5 (shipped 2026-05-19) industry vertical personas

**Added**
- `fintech-engineer`, `healthcare-engineer`, `gov-tech-engineer`, `edtech-engineer`, `ecommerce-engineer`, `media-streaming-engineer`, `iot-fleet-engineer`, `automotive-engineer`, `compliance-engineer`, `logistics-engineer`.

### Batch 4 (shipped 2026-05-18) specialty personas

**Added**
- `senior-data-engineer`, `senior-ml-engineer`, `senior-data-scientist`, `senior-mlops-engineer`, `senior-mobile-engineer`, `senior-embedded-engineer`, `senior-game-engineer`, `senior-blockchain-engineer`, `senior-platform-engineer`, `senior-developer-advocate`.

### Batch 3 (shipped 2026-05-17) stack experts

**Added**
- `rails-expert`, `django-expert`, `nextjs-expert`, `kubernetes-expert`, `postgres-expert`, `terraform-expert`, `redis-expert`, `aws-expert`, `gcp-expert`, `swift-ios-expert`.

### Batch 2 (shipped 2026-05-16) capability skills

**Added**
- `senior-code-reviewer`, `senior-debugger`, `senior-refactorer`, `senior-performance-engineer`, `incident-commander`, `api-contract-designer`, `data-modeler`, `migration-planner`, `dependency-auditor`, `postmortem-author`.

### Batch 1 (shipped 2026-05-15) SDLC personas

**Added**
- `staff-software-architect`, `engineering-team-lead`, `senior-product-manager`, `senior-ux-designer`, `senior-frontend-engineer`, `senior-backend-engineer`, `senior-devops-sre`, `senior-qa-test-engineer`, `principal-security-engineer`, `senior-technical-writer`.

**Changed**
- Repo wide prose sweep to remove em-dashes and English word compound hyphens (antipattern, tradeoff, postmortem, subsystem) from skill bodies and docs. Identifiers in backticks kept their hyphens.

### Initial scaffolding (2026-05-15)

**Added**
- Repository layout: `skills/personas/`, `skills/capabilities/`, `skills/stacks/`, `shared/`, `install/`, with `subagents/` added later.
- Top level docs: `README.md`, `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, `SECURITY.md`.
- License: `Apache-2.0`.
- Author tooling under `shared/`: style guide, trigger vocabulary, skill template.
- GitHub issue templates (`new-skill.yml`, bug, request) and a pull request template.
- Install scripts: `install/install-claude.sh` for Claude Code and `install/install-codex.sh` for OpenAI Codex, both symlink based so `git pull` propagates updates.
