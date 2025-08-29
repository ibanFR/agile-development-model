## Software Architecture and Domain-Driven Design

How to decompose software systems into cohesive modules (or components and services) that are loosely coupled is one of
the classic questions and challenges in software engineering.

We decompose a large problem domain into sub-domains for a few key reasons:

- Reduced cognitive load, so that we can reason about parts of the domain independently,
- Give development teams autonomy, so that they can work on separate parts of the solution,
- Identifying loose-coupling and high-cohesion in the domain which carries over to our software architecture and 
  team structure.

Time and resources are limited, so understanding which parts of the domain to focus on is critical to delivering optimal
business impact.

![](embed:DomainDrivenDesign)

### Strategic Architecture

Decompose a large problem domain into sub-domains so that we can reason about parts of the domain independently.

Strategically map out your sub-domains to identify core domains: the parts of the domain which have the greatest
potential for business differentiation or strategic significance.

By analysing what your core domains are, you will have a better idea of how much quality and rigour is required to build
each part of your system, and you'll be able to make highly-educated build vs buy vs outsource decisions.

### Bounded Contexts

Identify each model in play on the project and define its Bounded Context (A Bounded Context is a sub-system in a
software architecture aligned to a part of the domain).

Bounded Context is one of the central and essential patterns to rescue architecture from the Big Ball Of Mud by
segregating the whole application domain into multiple semantically-consistent parts.

The Bounded Context Canvas guides you through the process of designing a Bounded Context by requiring you to consider and make choices
about the key elements of its design, from naming to responsibilities, to its public interface and dependencies.

Name each Bounded Context, and make the names part of the ubiquitous language.

### Software Design

It is imperative to not only decompose a large domain into parts but to also carefully design the interactions between
those parts to minimise unwanted coupling and complexity.

Connect the sub-domains into a loosely-coupled architecture which fulfills end-to-end business use-cases. 

Achieving high cohesion within the services and loose coupling between them is crucial to keep the application scalable
and maintainable.

It is
necessary to challenge the initial design by applying concrete use-cases to uncover hidden complexity.

Code the Domain Model applying Tactical Patterns - A set of building blocks to structure the implementation of a model
according to best practices: Entity, Aggregate, Value Object, Service, Domain Event, Repository, Factory, Module.

Aligning the code to the domain makes it easier to change the code when the domain changes.
