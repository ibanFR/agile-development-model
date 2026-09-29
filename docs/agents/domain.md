# Domain Docs

How the engineering skills should consume this repo's domain documentation when exploring the codebase.

## Before exploring, read these

- **`CONTEXT.md`** at the repo root.
- **`adrs/`** — read ADRs that touch the area you're about to work in.

If any of these files don't exist, **proceed silently**: the `/domain-modeling` skill (reached via `/grill-with-docs` and `/improve-codebase-architecture`) creates them lazily when terms or decisions actually get resolved.

## File structure

Single-context repo:

```
/
├── CONTEXT.md
├── adrs/
│   └── NNNN-kebab-case-title.md
└── docs/
```

## Use the glossary's vocabulary

When your output names a domain concept (in an issue title, a refactor proposal, a hypothesis, a test name), use the term exactly as `CONTEXT.md` defines it, even where a synonym reads more naturally.

If the concept you need isn't in the glossary yet, that's a signal — either you're inventing language the project doesn't use (reconsider) or there's a real gap (note it for `/domain-modeling`).

## Accepted ADRs are immutable

A new ADR's Status is `Proposed`. It changes to `Accepted` when the pull request merges, and from then on the ADR is _immutable_.

When a decision changes, write a new ADR, then link the pair in their Status sections — the only lines an accepted ADR ever gains:

- **Replaces** the old decision: the old ADR gets `Superseded by [ADR-NNNN](...)`, the new one `Supersedes [ADR-NNNN](...)`.
- **Changes part of** a decision that still stands: the old ADR keeps `Accepted` and gains `Amended by [ADR-NNNN](...)`, the new one `Amends [ADR-NNNN](...)`.

## Flag ADR conflicts

If your output contradicts an existing ADR, surface it explicitly rather than silently overriding:

> _Contradicts ADR-0002 (knowledge base and living documentation) — but worth reopening because…_
