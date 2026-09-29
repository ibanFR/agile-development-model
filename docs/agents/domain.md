# Domain Docs

How the engineering skills should consume this repo's domain documentation when exploring the codebase.

## Before exploring, read these

- **`CONTEXT.md`** at the repo root.
- **`adrs/`** — read ADRs that touch the area you're about to work in.

If any of these files don't exist, **proceed silently**. Don't flag their absence; don't suggest creating them upfront. The `/domain-modeling` skill (reached via `/grill-with-docs` and `/improve-codebase-architecture`) creates them lazily when terms or decisions actually get resolved.

## File structure

Single-context repo:

```
/
├── CONTEXT.md
├── adrs/
│   ├── 0001-record-architecture-decisions.md
│   └── 0002-knowledge-base-and-living-documentation.md
└── docs/
```

## Use the glossary's vocabulary

When your output names a domain concept (in an issue title, a refactor proposal, a hypothesis, a test name), use the term as defined in `CONTEXT.md`. Don't drift to synonyms the glossary explicitly avoids.

If the concept you need isn't in the glossary yet, that's a signal — either you're inventing language the project doesn't use (reconsider) or there's a real gap (note it for `/domain-modeling`).

## Accepted ADRs are immutable

ADRs follow Michael Nygard's style (ADR-0001): an accepted ADR is _immutable_, a record of what was decided at the time, however stale it reads now.

When a decision changes, write a new ADR, then link the pair in their Status sections — the only lines an accepted ADR ever gains:

- **Replaces** the old decision: the old ADR gets `Superseded by [ADR-NNNN](...)`, the new one `Supersedes [ADR-NNNN](...)`.
- **Changes part of** a decision that still stands: the old ADR gets `Amended by [ADR-NNNN](...)`, the new one `Amends [ADR-NNNN](...)`.

ADR-0005's Status, for example, reads `Accepted`, then `Amended by [ADR-0006](0006-render-the-generated-site-with-the-c4-plantuml-exporter.md)`.

## Flag ADR conflicts

If your output contradicts an existing ADR, surface it explicitly rather than silently overriding:

> _Contradicts ADR-0002 (knowledge base and living documentation) — but worth reopening because…_
