# Context

Glossary for this repository. Terms only — no implementation detail, and no names that
belong to the tooling, so that this glossary survives the next change of tooling.

## Model

**Software Development Model** — the subject of this repository: the agile approach to
product feature delivery that the whole workspace describes. Modelled as a single software
system.

**Practice** — one of the five top-level units the model is divided into: Align and
Understand, BDD, DDD, XP, and Lean Product Development. A Practice groups the components
that belong to it. This is the canonical term for the top-level units: prose calls them
Practices, not "building blocks". ("Focus area" keeps its DDD sense of a strategically
significant part of a problem domain, and never names a Practice.)

**Component** — a single activity, artefact or ceremony within a Practice, such as a Product
Brief, Pair Programming or a Product Backlog. Components are what a team actually does;
Practices are how those components are grouped.

**Domain Expert** — the Product Team member who owns and drives the product vision, and who
brings domain knowledge into the model.

**Software Engineer** — the Development Team member who delivers high-quality software
efficiently and iteratively.

**Product Increment** — the potentially shippable result of one short iteration of the Lean
Product Development Practice.

**Building block** — reserved for its tactical Domain-Driven Design sense only: the patterns
used to structure the implementation of a domain model, such as entities, value objects,
aggregates, services, repositories and events. It never means a Practice.

**All Components** — notation, not a Practice. It exists only to scope the all-up view of
every component, and nothing in the modelled domain corresponds to it.

## Documentation

**View** — one named diagram of the model, at a chosen level of detail: the system context,
the Practices, the components of one Practice, or the components of all of them.

**ADR** — a record of a decision that is hard to reverse, surprising without its reasoning,
and the result of a real trade-off.
