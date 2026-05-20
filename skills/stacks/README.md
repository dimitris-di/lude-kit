# Stacks

Stack- or technology specific experts that complement the personas with depth in one ecosystem.

A stack skill knows the idioms, traps, and best practices of one technology, its dialect, its standard library, its deployment story, its testing tools. Personas hand off to a stack expert when the work is technology bound rather than role bound.

## Shipped (batch 3)

- [`rails-expert`](rails-expert/SKILL.md), Rails 7/8 idioms: ActiveRecord, Hotwire, Sidekiq/Solid Queue, strong_migrations, RSpec.
- [`django-expert`](django-expert/SKILL.md), Django 5: ORM, DRF, signals discipline, async views, Celery, migrations.
- [`nextjs-expert`](nextjs-expert/SKILL.md), App Router, RSC, Server Actions, Cache Components, Fluid Compute.
- [`kubernetes-expert`](kubernetes-expert/SKILL.md), manifests, probes, PDB, RBAC, NetworkPolicy, GitOps, day two ops.
- [`terraform-expert`](terraform-expert/SKILL.md), modules, state, providers, drift detection, OIDC for CI.
- [`postgres-expert`](postgres-expert/SKILL.md), EXPLAIN ANALYZE, indexing, autovacuum, partitioning, logical replication.
- [`redis-expert`](redis-expert/SKILL.md), data structures, persistence, eviction, Cluster, hot keys, latency.
- [`aws-expert`](aws-expert/SKILL.md), IAM, VPC, service selection, Organizations, OIDC, cost footguns.
- [`gcp-expert`](gcp-expert/SKILL.md), projects, Workload Identity Federation, VPC Service Controls, Cloud Run, BigQuery.
- [`swift-ios-expert`](swift-ios-expert/SKILL.md), SwiftUI, Swift Concurrency, SwiftData, BGTaskScheduler, App Store submission.

See the [open roadmap issues](https://github.com/dimitris-di/LudeSkills/issues?q=is%3Aissue+label%3Anew-skill) for proposals beyond batch 3.

## Authoring a stack expert

1. Open a "new skill" issue first.
2. Copy [`shared/skill-template/SKILL.md`](../../shared/skill-template/SKILL.md) into a new folder here.
3. Stack skills are most useful when they capture the **idioms** and **gotchas** that don't appear in the docs, the parts that a senior engineer in that stack has memorized.
4. Be specific about versions where the dialect has shifted (e.g., Rails 7 vs 8, Next.js App Router vs Pages).
