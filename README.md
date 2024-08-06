# Software Architecture and Design repository
Repository for adopting a “diagrams and documentation as code” approach to software architecture and design.

A "diagrams and documentation as code" approach refers to the practice of treating system diagrams and documentation in 
the same way that code is managed and versioned. This approach leverages principles from the world of software 
development to streamline the creation, maintenance, and collaboration around system architecture diagrams and 
documentation.

By adopting a "diagrams and documentation as code" approach, teams can enhance the agility, consistency, 
and collaboration around system architecture documentation, aligning it more closely with the principles and practices 
used in modern software development.

## Pre-requisites
1 Install docker on your machine.
2 Pull the structurizr-lite image from docker hub.

See [Structurizr Lite - Quickstart](https://docs.structurizr.com/lite/quickstart/) for more information.

## Folder structure

```
├── workspace.dsl          # Primary Structurizr DSL script defining the system architecture
├── views/                 # Additional Structurizr DSL scripts for specific views or perspectives
│   ├── context_view.dsl   # DSL script for the system context view
│   ├── container_view.dsl # DSL script for the container view
│   ├── component_view.dsl # DSL script for the component view
│   └── ...
├── docs/                  # Directory to store Markdown/AsciiDoc documentation files
├── adrs/                  # Directory to store Markdown/AsciiDoc Architecture Decision Records (ADRs)
├── README.md              # Project documentation
├── .gitignore             # Git ignore file
└── ...
```
## Getting started
To start structurizr-lite run the following command:

```shell 

docker run -it --rm -p 8080:8080 -v $(pwd):/usr/local/structurizr structurizr/lite
```
Access the Structurizr Lite web application at http://localhost:8080

## Rendering tools

This projects uses [Structurizr Site Generatr]() to Generates a HTML microsite with diagrams, documentation, and a UI to
explore the model.

To generate the HTML microsite, run the following command:

```shell
structurizr-site-generatr generate-site -w workspace.dsl
```
Start a development web server around the generated website:

```shell 
structurizr-site-generatr serve -w workspace.dsl
```



## Resources
- [The C4 model for visualising software architecture](https://c4model.com/)
- [Structurizr DSL](https://docs.structurizr.com/dsl)
- [Structurizr examples](https://github.com/structurizr/examples/tree/main)
