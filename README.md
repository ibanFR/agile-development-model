# Software Development Model for efficient Product Feature Delivery

This repository serves as a blueprint for an Agile Software Development Model, focused on efficient and scalable product
feature delivery. The model is built around key building blocks that enable rapid, iterative, and high-quality software
development.

The [C4 model](https://c4model.com/) is used in this repository to visualize the architecture of the Agile Software Development Model at
different levels of abstraction:

- **System Context Diagram**: Provides a high-level overview of the model, highlighting the main stakeholders and their
  interactions between them.
- **Container Diagram**: The Container Diagram dives deeper, illustrating the major containers that compose the model
  and how they communicate with each other.
- **Component Diagram**: Further decomposes the containers into individual components, each representing specific task
  or process within the container, and illustrates how these components are structured and interact internally.

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
 - Docker: Used to run Structurizr Lite in a containerized environment.
 - Structurizr Lite: A lightweight tool for creating system architecture diagrams using the [Structurizr DSL](https://docs.structurizr.com/dsl).
 - [Structurizr Site Generatr](https://github.com/avisi-cloud/structurizr-site-generatr): A tool for generating a HTML microsite with diagrams, documentation, and a UI to explore the model.
 - Github Actions: Used to automate the generation of the HTML microsite and deploy it to Github Pages.


## Folder structure

```
├── workspace.dsl          # Primary Structurizr DSL script defining the system architecture
├── docs/                  # Directory to store Markdown/AsciiDoc documentation files
├── adrs/                  # Directory to store Markdown/AsciiDoc Architecture Decision Records (ADRs)
├── README.md              # Project documentation
├── .gitignore             # Git ignore file
└── ...
```
## Getting started
Install Docker:
- See [Get Docker](https://docs.docker.com/get-docker/) for installation instructions.

Pull the Structurizr Lite Docker image:
```shell
docker pull structurizr/lite
```

See [Structurizr Lite - Quickstart](https://docs.structurizr.com/lite/quickstart/) for more information.

To start structurizr-lite run the following command:

```shell 

docker run -it --rm -p 8080:8080 -v $(pwd):/usr/local/structurizr structurizr/lite
```
Access the Structurizr Lite web application at http://localhost:8080

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
