workspace "Software Development Model for Product feature delivery"{

    !docs site

    model {

        product = person "Domain Expert" "Product Team member who owns and drives the product vision"{
            tags "product"
        }
        developer = person "Software Engineer" "Development Team member delivering high-quality software efficiently and iteratively"

        process = softwareSystem "Software Development Model for Product feature delivery" "Dynamic and iterative approach to delivering product features in a rapid and flexible manner" "Software Development Model"{

            !adrs adrs

            // Notation, not a focus area. Structurizr scopes a component view to a single
            // container, so this empty container exists purely to carry the cross-container
            // "Components" overview view defined below. Tagged "notation" so it is styled
            // and read as part of the diagram notation rather than part of the model.
            allComponents = container "All Components" "Notation, not a focus area: the scope that carries the all-up Components view" "" {
                tags "notation"
            }

            alignAndUnderstand = container "Align and Understand Product Requirements" "Focus area that aligns our focus with the organisation's business model, the needs of its users, and its short, medium, and long-term goals" "Align & Understand"{
                tags "product"
                productBrief = component "Product Brief" "Short product or feature brief to frame and constrain the project" "Opportunity Canvas, Slideck, etc"{
                    tags "product"
                }

                storyMap = component "Domain Discovery" "Map the Big Picture by describing the User journey through the Product telling a story from the perspective of the end user" "User Story Map, Event Storming, etc"{
                    tags "product"
                }

                backlog = component "Product Backlog" "Prioritised list of User Stories that need to be completed or addressed during the project" "Jira, Trello, etc" {
                    tags "product"
                }
            }

            bdd = container "Behavior-Driven Development" "Focus area that defines and builds a shared understanding of the desired system behavior before any code is written. It encourages collaboration and a shared understanding of the project's objectives" "BDD"{
                discovery = component "Specification Workshop" "Concrete rules and examples help us explore the problem domain to clarify and confirm the acceptance criteria" "Example Mapping"{
                    tags "product"
                }
                formulation = component "Features" "Group of related scenarios that demostrates how a feature works" "Gherkin"{

                }
                automation = component "Acceptance Tests" "Executable specifications that verify the behavior of the system against its requirements" "Cucumber"{

                }
            }

            ddd = container "Software Architecture and Domain-Driven Design" "Focus area that explores models in a creative collaboration of domain experts and software engineers" "DDD"{

                strategize = component "Strategic Architecture" "Decompose a large problem domain into cohesive modules, so that we can identify strategically significant subdomains" "Core Domain Charts, Context Maps, etc"{
                    tags "product"
                }

                design = component "Software Design" "Document Bounded Contexts, from naming to responsibilities alongside its public interface and dependencies" "Bounded Context Canvas, Aggregate Design Canvas, C4 model, etc"{

                }

                code = component "Code the Domain Model" "Code the Domain Model applying Tactical Patterns - a set of building blocks to structure the implementation of the model" "Services, Repositories, Events, etc"{

                }

            }

            xp = container "Extreme Programming " "Focus area in which developers work together in pairs and as a group, improving the design continually to keep it always just right for the current needs" "XP"{

                pairProgramming = component "Pair Programming" "Developers work together in pairs and as a group, reviewing the code in real-time and improving the design continuously" "Ensemble, Mob Programming"{

                }

                tdd = component "Test-Driven Development" "Lower-level examples of the behavior of internal system components" "JUnit, etc"{

                }

                continuousIntegration = component "Continuous Integration" "Automated build scripts are used to run tests and provide immediate feedback to developers about the status of their code changes" "Jenkins, Github Actions, etc"{

                }
            }

            lean = container "Lean Product Development" "Focus area that breaks projects down into two-week iterations, each of which results in a potentially shippable Product Increment" "Lean"{

                tags "product"


                informationRadiators = component "Informative Workspaces" "Project progress and potential issues are visible to all team members with informative workspaces" "Scrum and Kanban boards, DORA/SAFE metrics etc"{

                }

                iterations = component "Short Iterations" "Short development cycles deliver incremental value and enable continuous learning about the product" "one to two week development cycles"{
                    tags "product"

                }

                knowledgeBase = component "Knowledge Base" "Centralized repository of information and best practices that the team can refer to for guidance, problem-solving, and knowledge sharing" "Google Drive, Confluence, Javadoc"{

                }

                customerFeedback = component "Customer Feedback" "Continuously collect customer feedback and use it to refine and enhance the design of products and features" "customer satisfaction surveys, gather customer insights, etc"{
                    tags "product"
                }
            }

        }

        product -> process "contributes to"
        developer -> process "follows"
        product -> productBrief "presents Product Feature"
        developer -> productBrief "obtains domain knowledge"

        // container relationships
        alignAndUnderstand -> ddd "collaborative domain modelling"
        bdd -> lean "creates shared understanding"
        ddd -> lean "enhances agility"

        //align and understand
        productBrief -> storyMap "spread domain knowledge"
        storyMap -> backlog "creates"
        backlog -> discovery "collaborative requirement specification"
        backlog -> strategize "problem decomposition"

        //bdd
        product -> discovery "presents rules and examples"
        developer -> discovery "identifies functional gaps or inconsistencies"
        discovery -> formulation "formulate"
        formulation -> automation "automate"
        automation -> pairProgramming "guides code implementation"

        //ddd
        strategize -> design "collaborative modelling"
        design -> code "apply tactical patterns"
//        The relationship below is inferred in continuousIntegration -> knowledgeBase
//        design -> knowledgeBase "document the software design" "Google Drive"
        developer -> strategize "identifies strategically significant subdomains"
        product -> strategize "validates and categorizes subdomains"
        code -> pairProgramming "guides code implementation"

        //xp
        developer -> pairProgramming "implements high-quality software"
        pairProgramming -> tdd "write just enough code"
        tdd -> continuousIntegration "push code to version control"
        continuousIntegration -> iterations "deliver product increment"

        //lean
        developer -> iterations "works in small steps"
        product -> iterations "validates product increments"
        iterations -> informationRadiators "visualize progress on"
        iterations -> knowledgeBase "updates"
        iterations -> customerFeedback "gathers"


    }

    views {
        properties {
            "generatr.site.exporter" "structurizr"
            "structurizr.sort" "created"
        }
        systemContext process "Context" "The system context diagram for the Software Development Process" {
            include *
            autoLayout tb
        }

        container process "Containers" {
            include *
            autoLayout tb
            exclude allComponents
            exclude product->ddd product->lean product->bdd
            exclude developer->lean developer->ddd developer->bdd developer->xp
            exclude lean->xp
        }

        component alignAndUnderstand "AlignAndUnderstand" {
            include *
            exclude product->bdd developer->bdd
            exclude product->ddd developer->ddd
            autoLayout lr
        }

        component bdd "BehaviorDrivenDevelopment" {
            include *
            exclude *->alignAndUnderstand
            exclude developer->xp
            exclude product->lean
            exclude developer->lean
            autoLayout lr
        }

        component ddd "DomainDrivenDesign" "" {
            include *
            exclude *->alignAndUnderstand
            exclude product->lean
            exclude developer->lean developer->xp
            exclude xp->*
            autolayout lr
        }

        component xp "TestDrivenDevelopment" {
            include *
            exclude developer->lean bdd->lean ddd->lean
            exclude *->bdd
            exclude *->ddd
            autoLayout lr
        }

        component lean "LeanProductDevelopment" "Focus area that breaks projects down into two-week iterations, each of which results in a potentially shippable Product Increment" {
            include *
            exclude *->xp
            autoLayout tb
        }

        component allComponents "Components" "All Components and relationships across the five focus areas" {
            include product developer productBrief storyMap discovery formulation automation
            include strategize design code
            include pairProgramming tdd continuousIntegration
            include backlog iterations informationRadiators customerFeedback knowledgeBase
            exclude product->discovery product->iterations product->strategize
            exclude developer->strategize developer->pairProgramming developer->iterations developer->discovery
            // No autoLayout on purpose. Omitting it makes the PlantUML exporter used by
            // structurizr-site-generatr emit "top to bottom direction", while the local
            // viewer falls back to the manual layout saved in workspace.json.
            // See adrs/0003-omit-autolayout-on-the-components-view.md.
        }


        // Vendored copy of the Structurizr default theme. The cloud-hosted original is no
        // longer fetchable (cloud service EOL 2026-09-30), which fails the site build.
        theme theme.json

        styles {
            element "product" {
                background grey
                color #ffffff
            }

            // Notation, not a focus area: drawn washed out and dashed so it never reads as
            // part of the modelled domain. See CONTEXT.md.
            element "notation" {
                background #ffffff
                color #808080
                stroke #808080
                border dashed
            }


            //            element <tag> {
//                shape <Box|RoundedBox|Circle|Ellipse|Hexagon|Cylinder|Pipe|Person|Robot|Folder|WebBrowser|MobileDevicePortrait|MobileDeviceLandscape|Component>
//                icon <file|url>
//                width <integer>
//                height <integer>
//                background <#rrggbb|color name>
//                color <#rrggbb|color name>
//                colour <#rrggbb|color name>
//                stroke <#rrggbb|color name>
//                strokeWidth <integer: 1-10>
//                fontSize <integer>
//                border <solid|dashed|dotted>
//                opacity <integer: 0-100>
//                metadata <true|false>
//                description <true|false>
//                properties {
//                    name value
//                }
//            }
//            relationship <tag> {
//                thickness <integer>
//                color <#rrggbb|color name>
//                colour <#rrggbb|color name>
//                style <solid|dashed|dotted>
//                routing <Direct|Orthogonal|Curved>
//                fontSize <integer>
//                width <integer>
//                position <integer: 0-100>
//                opacity <integer: 0-100>
//                properties {
//                    name value
//                }
//            }
        }
    }

}
