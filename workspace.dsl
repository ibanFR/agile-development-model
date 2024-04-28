workspace "Agile Software Development Model for efficient Product feature delivery"{

    model {

        product = person "Product stakeholder" "Product Team member who owns and drives the product vision"{
            tags "product"
        }
        developer = person "Engineering stakeholder" "Engineering Team member who follows the software development process to become more efficient"

        process = softwareSystem "Agile Software Development Model for Product feature delivery" "The process used to develop and deliver product features" "Software Development Process"{
            !docs docs
            !adrs adrs


            allComponents = container "All Components" "All Components and relationships" "All Components"{

            }

            alignAndUnderstand = container "Align and Understand Product Requirements" "Align our focus with the organisation's business model, the needs of its users, and its short, medium, and long-term goals." "Align & Understand"{
                tags "product"
                productBrief = component "Product Brief" "Short product or feature brief to frame and constrain the project. Identifies key capabilities and high level goals and objectives of the project" "Opportunity Canvas, slideck, etc"{
                    tags "product"
                }

                storyMap = component "Domain Discovery" "Map the Big Picture by describing the User journey through the Product telling a story from the perspective of the end user" "User Story Map, Event Storming, etc"{
                    tags "product"
                }

                backlog = component "Product Backlog" "Prioritised list of User Stories that need to be completed or addressed during the project" "They typically follow the template: As a [user type/role], I want [a capability] so that [benefit or goal]"{
                    tags "product"
                }
            }

            bdd = container "Behavior Driven Development" "Define and understand the desired system behavior before writting any code. It encourages collaboration and a shared understanding of the project's objectives" "BDD"{
                discovery = component "Requirement Workshop" "Concrete rules and examples help us explore the problem domain and makes a great basis for our acceptance tests" "Example Mapping sessions to clarify and confirm the acceptance criteria"{
                    tags "product"
                }
                formulation = component "Acceptance Test" "Once we have identified our rules and examples, we can now formulate each example as structured documentation." "Executable specifications of the system behavior"{

                }
                automation = component "Features" "Groups related scenarios that demostrates how a feature works " "Cucumber, Selenium etc"{

                }
            }

            ddd = container "Strategic Architecture and Domain Driven Design" "Explore models in a creative collaboration of domain experts and software engineers." "Sotware Architecture and Design"{

                decompose = component "Domain Decomposition" "Decompose a large problem domain into cohesive modules, so that we can identify stragically significant key focus areas" "Core Domain Charts"{
                    tags "product"
                }

                strategize = component "Strategic Architecture" "Document Bounded Contexts, from naming to responsibilities alongside its public interface and dependencies" "Bounded Context Canvas"{

                }

                design = component "Software Design" "Create models using a common set of abstractions to describe the static structure of a software system" "C4 model"{

                }

            }

            agile = container "Agile Product Management" "Agile projects are broken down into two-week iterations which result in a potentially shippable product increment" "Agile Manifesto"{

                tags "product"

                informationRadiators = component "Information Radiators" "Project progress and potential issues are visible to all team members with information radiators" "Scrum and Kanban boards, Metric Dashboards etc"{

                }

                ceremonies = component "Agile Ceremonies" "Agile iterations, metrics and feedback loops to help the team make informed decisions" "Jira, Trello, Miro, etc"{

                }

                knowledgeBase = component "Knowledge Base" "Centralized repository of information and best practices that the team can refer to for guidance, problem-solving, and knowledge sharing." "Google Drive, Confluence, etc"{

                }

                customerSupport = component "Customer Support" "The process of providing assistance to the end users of the product" "Jira"{
                    tags "product"
                }
            }

            tdd = container "Test Driven Development " "Acceptance Tests guide our code implementation using lower-level examples of the behavior of internal system components. " ""{

                development = component "Test Driven Development" "Lower-level examples of the behavior of internal system components" "JUnit, etc"{

                }

                continuousIntegration = component "Continuous Integration" "Automated build scripts are used to run tests and provide immediate feedback to developers about the status of their code changes" "Jenkins, etc"{

                }

                livingDocumentation = component "Living Documentation" "Documentation that is co-located with the code and is updated as the code changes" "Confluence, etc"{

                }
            }

        }

        product -> process "contributes to"
        developer -> process "follows"
        product -> productBrief "presents Product Feature"
        developer -> productBrief "obtains domain knowledge"

        // container relationships
        alignAndUnderstand -> bdd "collaborative requirement specification
        alignAndUnderstand -> ddd "collaborative domain modelling"
        bdd -> agile "creates a shared understanding"
        tdd -> agile "delivers product increment"
        ddd -> agile "enhances agility"
        ddd -> tdd "guides code implementation"

        //align and understand
        productBrief -> storyMap "spread domain knowledge"
        storyMap -> backlog "formulate user stories"
        storyMap -> discovery "identify rules and examples" "Miro"
        storyMap -> decompose "problem decomposition" "Core Domain Charts"

        //bdd
        product -> discovery "presents rules and examples"
        developer -> discovery "identifies functional gaps or inconsistencies"
        discovery -> formulation "formulate acceptance criteria" "Gherkin"
        formulation -> automation "automate acceptance tests" "Cucumber"
        automation -> development "guides code implementation"

        //ddd
        decompose -> strategize "collaborative modelling" "Miro"
        strategize -> design "visualize software architecture" "draw.io, structurizr"
        design -> knowledgeBase "document the software design" "Google Drive"
        developer -> decompose "identifies strategic focus areas"
        product -> decompose "validates and categorizes subdomains"

        //tdd
        developer -> development "implements high-quality software"
        development -> ceremonies "updates progress on"
        development -> continuousIntegration "push code to version control"
        continuousIntegration -> livingDocumentation "generates"

        //agile
        product -> ceremonies "validates product increments"
        developer -> ceremonies "updates work progress"
        ceremonies -> informationRadiators "visualize progress on"
        customerSupport -> informationRadiators "raises issues on"
        customerSupport -> knowledgeBase "references"
        knowledgeBase -> development "reference for"

    }

    views {
        systemContext process "Context" "The system context diagram for the Software Development Process" {
            include *
        }

        container process "Containers" {
            include *
            exclude allComponents
            exclude product->ddd product->agile product->bdd
            exclude developer->agile developer->ddd developer->bdd developer->tdd
            exclude agile->tdd
        }

        component allComponents "Components" "All Components and relationships" {
            include product developer productBrief storyMap discovery formulation automation decompose strategize design backlog ceremonies informationRadiators customerSupport knowledgeBase development continuousIntegration livingDocumentation
//            include *
            exclude product->discovery product->ceremonies
            exclude developer->decompose developer->development developer->ceremonies
       }

        component alignAndUnderstand "AlignAndUnderstand" {
            include product developer productBrief storyMap backlog bdd ddd
            exclude product->bdd developer->bdd
            exclude product->ddd developer->ddd
        }

        component bdd "BehaviorDrivenDevelopment" {
            include *
            exclude *->alignAndUnderstand
            exclude developer->tdd
        }

        component ddd "DomainDrivenDesign" "" {
            include *
            exclude *->alignAndUnderstand
            exclude product->agile developer->agile
        }

        component tdd "TestDrivenDevelopment" {
            include * product developer
            exclude developer->agile bdd->agile *->bdd
            exclude agile->development
        }

        component agile "AgileProductManagement" "Agile projects are broken down into two-week iterations which result in a potentially shippable product increment" {
            include *
            exclude *->ddd
            exclude *->tdd
            exclude developer->tdd developer->alignAndUnderstand
        }



        theme default

        styles {
            element "product" {
                background grey
                color #ffffff
            }
        }
    }

}
