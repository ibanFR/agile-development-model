# Software Development Model for efficient Product Feature Delivery

This repository serves as a blueprint for an Agile Software Development Model, focused on efficient and scalable product
feature delivery. The model is built around five key Practices — Align and Understand, BDD, DDD, XP, and Lean
Product Development — that together enable rapid, iterative, and high-quality software development.
See [CONTEXT.md](CONTEXT.md) for the vocabulary this repository uses.

![Agile Development Model Containers](site/images/agile-containers.png)

The [C4 model](https://c4model.com/) is used in this repository to visualize the architecture of the Agile Software Development Model at
different levels of abstraction:

- **System Context Diagram**: Provides a high-level overview of the model, highlighting the main stakeholders and their
  interactions between them.
- **Container Diagram**: The Container Diagram dives deeper, illustrating the five Practices that compose the model and
  how they communicate with each other. Each Practice is modelled as a C4 container.
- **Component Diagram**: Further decomposes each Practice into individual components, each representing a specific task
  or process within the Practice, and illustrates how these components are structured and interact internally.

This repository also advocates for adopting a "diagrams and documentation as code" approach to software architecture and
design. This practice involves managing and versioning system diagrams and documentation in the same way as code. By
applying software development principles, this approach streamlines the creation, maintenance, and collaboration
processes, ensuring that architecture documentation remains agile, consistent, and aligned with modern development
practices.

By adopting this approach, teams can better integrate architecture documentation into their development workflows,
resulting in improved collaboration and a more cohesive understanding of the system architecture throughout the
development lifecycle.

## Tools and Technologies
This repository leverages the following tools and technologies:
 - Docker: Used to run the local Structurizr viewer in a containerized environment.
 - [Structurizr](https://docs.structurizr.com/local): The consolidated Structurizr tooling. Its `local` command serves the model for authoring and review, using the [Structurizr DSL](https://docs.structurizr.com/dsl).
 - [Structurizr Site Generatr](https://github.com/avisi-cloud/structurizr-site-generatr): A tool for generating a HTML microsite with diagrams, documentation, and a UI to explore the model.
 - Github Actions: Used to automate the generation of the HTML microsite and deploy it to Github Pages.


## Folder structure

```
├── compose.yaml           # Docker Compose file that starts the local Structurizr viewer
├── workspace.dsl          # Primary Structurizr DSL script defining the system architecture
├── site/                  # Structurizr documentation (Markdown/AsciiDoc rendered by the local viewer)
├── CONTEXT.md             # Glossary of the modelled domain (Practice, Domain Expert, ...)
├── docs/                  # Agent-authored documentation (see docs/agents/)
├── adrs/                  # Directory to store Markdown/AsciiDoc Architecture Decision Records (ADRs)
├── README.md              # Project documentation
├── .gitignore             # Git ignore file
└── ...
```
## Getting started
Install Docker:
- See [Get Docker](https://docs.docker.com/get-docker/) for installation instructions.

Start the local Structurizr viewer:

```shell
docker compose up
```

This serves the model at http://localhost:8080. Diagrams refresh on their own while you edit
`workspace.dsl`, so there is no need to reload the page. Stop the viewer with `docker compose down`.

The image version and the auto-refresh interval live in `compose.yaml`. See
[Structurizr - local](https://docs.structurizr.com/local) for the full set of options.

To generate the HTML microsite, run the following command:

```shell
structurizr-site-generatr generate-site -w workspace.dsl
```
Start a development web server around the generated website:

```shell 
structurizr-site-generatr serve -w workspace.dsl -p 8081
```
## Contributing
We welcome contributions from the community. If you have suggestions or improvements, please open an issue or submit a
pull request. Ensure that your changes align with the overall vision and structure of the repository.
