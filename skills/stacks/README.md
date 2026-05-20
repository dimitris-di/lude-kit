# Stacks

Stack- or technology specific experts that complement the personas with depth in one ecosystem.

A stack skill knows the idioms, traps, and best practices of one technology, its dialect, its standard library, its deployment story, its testing tools. Personas hand off to a stack expert when the work is technology bound rather than role bound.

## Planned (batch 3)

- `rails-expert`, Ruby on Rails idioms, ActiveRecord, hotwire.
- `django-expert`, Django ORM, DRF, admin, async.
- `nextjs-expert`, Next.js App Router, RSC, Cache Components.
- `kubernetes-expert`, manifests, controllers, operators, day-2 ops.
- `terraform-expert`, modules, state, providers, drift.
- `postgres-expert`, query tuning, indexing, replication, MVCC.
- `redis-expert`, data structures, persistence, eviction.
- `aws-expert`, service selection, IAM, networking, cost.
- `gcp-expert`, equivalent breadth on Google Cloud.
- `swift-ios-expert`, SwiftUI, concurrency, App Store mechanics.

See the [open roadmap issues](https://github.com/dimitris-di/LudeSkills/issues?q=is%3Aissue+label%3Anew-skill) for current proposals.

## Authoring a stack expert

1. Open a "new skill" issue first.
2. Copy [`shared/skill-template/SKILL.md`](../../shared/skill-template/SKILL.md) into a new folder here.
3. Stack skills are most useful when they capture the **idioms** and **gotchas** that don't appear in the docs, the parts that a senior engineer in that stack has memorized.
4. Be specific about versions where the dialect has shifted (e.g., Rails 7 vs 8, Next.js App Router vs Pages).
