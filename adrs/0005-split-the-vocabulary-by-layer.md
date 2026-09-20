# 5. Split the vocabulary by layer: focus area in prose, container in notation

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

Collapsing all three into a single new word was considered and rejected. A new word would
have to be taught, and it would hide a distinction that is real: the model describes a way of
working, and C4 describes how that way of working is drawn. Container is the right word for
the drawing and the wrong word for the thing — it is a notation noun, and it collides with
Docker containers, which the README also mentions.

"Focus area" carries its own overload. The Strategic Architecture component and its incoming
relationship use it for strategically significant parts of a problem domain, which is a
different concept one level down.

There is also an element that is not one of the units at all. A component view must be scoped
to a single container, and scoping one to the software system is rejected by the parser, so
the all-up view of every component hangs off an empty container named "All Components". It is
part of the notation, not part of the modelled domain, and a reader counting top-level units
has no way to know that from the model alone.

## Decision

The vocabulary is split by layer rather than collapsed into one word.

**Focus area** is the domain term for the five top-level units: Align and Understand, BDD,
DDD, XP, and Lean Product Development. Prose in the README and the documentation chapters
says focus area. **Container** stays the notation term, used when talking about C4 and the
diagrams, with each focus area modelled as exactly one container. `CONTEXT.md` states the
mapping and separates the two sets of terms under Model and Notation headings.

"Building block" is left to mean only what Evans meant by it.

The model's own element descriptions are left as they are. Vocabulary is carried by the
prose and by the glossary, and `workspace.dsl` changes only where the model is wrong about
itself rather than merely worded differently. Two places qualify. The scope anchor, which
presents itself as a unit of the model when it is notation. And the Strategic Architecture
descriptions, which said "key focus areas" for what Evans calls subdomains — the second sense
of the term this decision exists to remove, sitting inside the model itself.

Those descriptions now say "strategically significant parts of the domain", both on the
component and on the relationship that reaches it, so focus area has one meaning repo-wide.
`CONTEXT.md` defines **subdomain** as the short name for the same concept, which the sibling
relationship on Strategic Architecture already used. No other description is touched.

Names are not changed. Element names, DSL variable names, and chapter filenames stay as they
are: renaming chapters would break published URLs, and renaming elements would churn the
model for no vocabulary gain.

The scope anchor is tagged `notation` and styled washed out and dashed, so that wherever it
is drawn it reads as notation rather than as a sixth focus area. It stays excluded from the
Containers view, which is the diagram readers meet first and which should show exactly the
five focus areas.

`CONTEXT.md` at the repository root is the glossary of record. It leaves out the names of
whichever tools render the model, so that it survives the next change of tooling.

## Consequences

A reader meets one word per concept per layer, and knows which layer they are in. "Building
block" points at exactly one thing, and so does focus area.

The cost of the split is that both words stay in circulation, and a contributor has to know
which one the sentence calls for. The mapping is one to one, so the rule is short: the thing
is a focus area, the box that draws it is a container.

C4 vocabulary does not disappear, which keeps the model readable to anyone who arrives
through C4 rather than through this repository.

The scope anchor is honest but still slightly awkward: it is a modelling workaround, and it
remains visible in tooling that lists containers. Removing it would mean giving up the all-up
component view.
