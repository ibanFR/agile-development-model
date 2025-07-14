## Strategic Architecture and Domain Driven Design

Explore models in a creative collaboration of domain experts and software engineers.

We decompose a large problem domain into sub-domains so that we can reason about parts of the domain independently,

Strategically map out our sub-domains to identify the parts of the domain which have the greatest potential for business
differentiation or strategic significance.

Connect the sub-domains into a loosely-coupled architecture which fulfills end-to-end business use-cases.

![](embed:DomainDrivenDesign)

### Domain Decomposition

How to decompose software systems into cohesive modules (or components and services) that are loosely coupled is one of
the classic questions and challenges in software engineering.

We decompose a large problem domain into sub-domains for a few key reasons:

- reduced cognitive load, so that we can reason about parts of the domain independently,
- give development teams autonomy, so that they can work on separate parts of the solution,
- identifying loose-coupling and high-cohesion in the domain which carries over to our software architecture and team structure.

Achieving high cohesion within the services and loose coupling between them is crucial to keep the application scalable
and maintainable.

### Strategic Architecture

Strategically map out your sub-domains to identify core domains: the parts of the domain which have the greatest
potential for business differentiation or strategic significance.

Time and resources are limited, so understanding which parts of the domain to focus on is critical to delivering optimal
business impact.

By analysing what your core domains are, you will have a better idea of how much quality and rigour is required to build
each part of your system, and you'll be able to make highly-educated build vs buy vs outsource decisions.


### Software Design

It is imperative to not only decompose a large domain into parts but to also carefully design the interactions between
those parts to minimise unwanted coupling and complexity. It is necessary to challenge the initial design by applying
concrete use-cases to uncover hidden complexity.

Identify each model in play on the project and define its bounded context (A bounded context is a sub-system in a
software architecture aligned to a part of the domain).

Bounded Context is one of the central and essential patterns to rescue architecture from the Big Ball Of Mud by
segregating the whole application domain into multiple semantically-consistent parts.

The Bounded Context Canvas is a collaborative tool for designing and documenting the design of a single bounded context.

The canvas guides you through the process of designing a bounded context by requiring you to consider and make choices
about the key elements of its design, from naming to responsibilities, to its public interface and dependencies.

Name each bounded context, and make the names part of the ubiquitous language.

In an ideal world we want to align Subdomains and Bounded Contexts.

Code the Domain Model applying Tactical Patterns - A set of building blocks to structure the implementation of a model
according to best practices: Entity, Aggregate, Value Object, Service, Domain Event, Repository, Factory, Module

Aligning the code to the domain makes it easier to change the code when the domain changes.