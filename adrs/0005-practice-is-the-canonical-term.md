# 5. Practice is the canonical term for the model's top-level units

Date: 2026-09-20

## Status

Accepted

## Context

Three names competed for the five top-level units of the model. The README called them
"building blocks", the model calls them containers because that is the C4 name for the
notation, and the documentation chapters called them focus areas. A reader met a different
word depending on where they entered.

"Building block" was the worst of the three, because it also names Evans' tactical
Domain-Driven Design patterns — entities, value objects, aggregates, repositories — one level
further down, inside the Code the Domain Model component. The same term meant two different
things at two altitudes of the same model.

There is also an element that is not one of the units at all. A component view must be scoped
to a single container, and scoping one to the software system is rejected by the parser, so
the all-up view of every component hangs off an empty container named "All Components". It is
part of the notation, not part of the modelled domain, and a reader counting top-level units
has no way to know that from the model alone.

## Decision

**Practice** is the canonical term for the five top-level units: Align and Understand, BDD,
DDD, XP, and Lean Product Development. Prose in the README, the documentation chapters, and
the model's container descriptions says Practice. "Building block" is left to mean only what
Evans meant by it.

Names are not changed. Element names, DSL variable names, and chapter filenames stay as they
are: renaming chapters would break published URLs, and renaming elements would churn the
model for no vocabulary gain. The vocabulary lives in prose and in descriptions.

The scope anchor is tagged `notation` and styled washed out and dashed, so that wherever it
is drawn it reads as notation rather than as a sixth Practice. It stays excluded from the
Containers view, which is the diagram readers meet first and which should show exactly the
five Practices.

`CONTEXT.md` at the repository root is the glossary of record. It covers the modelled domain
and the documentation vocabulary, and deliberately leaves out the names of whichever tools
render the model, so that it survives the next change of tooling.

## Consequences

A reader meets one word for one concept, and "building block" points at exactly one thing.

C4 vocabulary does not disappear: the model is still written in containers and components,
and the C4 words remain correct when talking about the notation. The mapping — one Practice
is modelled as one container — is stated in the README where the C4 levels are introduced.

Contributors have somewhere to check the vocabulary before inventing a synonym, and the
glossary is short enough to keep current.

The scope anchor is honest but still slightly awkward: it is a modelling workaround, and it
remains visible in tooling that lists containers. Removing it would mean giving up the all-up
component view.
