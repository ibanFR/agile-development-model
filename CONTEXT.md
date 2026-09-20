# Context

Glossary for this repository. Terms only — no implementation detail, and no names that
belong to the tooling, so that this glossary survives the next change of tooling.

The vocabulary is split by layer. The **Model** terms below name what is being described;
the **Notation** terms name how it is drawn. Prose uses the model terms; the notation terms
are for talking about the diagrams.

## Model

**Software Development Model** — the subject of this repository: the agile approach to
product feature delivery that the whole workspace describes.

**Focus area** — one of the five top-level units the model is divided into: Align and
Understand, BDD, DDD, XP, and Lean Product Development. A focus area groups the components
that belong to it, and is modelled as exactly one container. This is the canonical term for
the top-level units: prose calls them focus areas, not "building blocks".

**Subdomain** — a strategically significant part of a problem domain, identified by the
Strategic Architecture component. This is a different concept one level down, and it is the
term to use when writing new text. The Strategic Architecture descriptions in the model still
say "key focus areas" for it; read those as subdomains.

**Component** — a single activity, artefact or ceremony within a focus area, such as a
Product Brief, Pair Programming or a Product Backlog. Components are what a team actually
does; focus areas are how those components are grouped.

**Domain Expert** — the Product Team member who owns and drives the product vision, and who
brings domain knowledge into the model.

**Software Engineer** — the Development Team member who delivers high-quality software
efficiently and iteratively.

**Product Increment** — the potentially shippable result of one short iteration of the Lean
Product Development focus area.

**Building block** — reserved for its tactical Domain-Driven Design sense only: the patterns
used to structure the implementation of a domain model, such as entities, value objects,
aggregates, services, repositories and events. It never names a focus area.

## Notation

**Container** — the C4 name for a top-level unit of the model as drawn. Each focus area is
modelled as one container, so the two line up one to one; container is the word for the
notation, focus area the word for the thing.

**View** — one named diagram of the model, at a chosen level of detail: the system context,
the focus areas, the components of one focus area, or the components of all of them.

**All Components** — notation, not a focus area. It exists only to scope the all-up view of
every component, and nothing in the modelled domain corresponds to it.

**ADR** — a record of a decision that is hard to reverse, surprising without its reasoning,
and the result of a real trade-off.
