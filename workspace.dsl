workspace "Agile Software Development Model for efficient Product Feature delivery"{

    model {

        product = person "Product stakeholder" "Product Team member who owns and drives the product vision"{
            tags "product"
        }
        developer = person "Engineering stakeholder" "Engineering Team member who follows the software development process to become more efficient"

        process = softwareSystem "Agile Software Development Model for efficient Product Feature delivery" "The process used to develop and deliver product features" "Software Development Process"{
            !docs docs
            !adrs adrs


            alignAndUnderstand = container "Align and Understand Product Requirements" "Align our focus with the organisation's business model, the needs of its users, and its short, medium, and long-term goals." "Align & Understand"{
                tags "product"
                productBrief = component "Product Brief" "Short product or feature brief to frame and constrain the project. Identifies key capabilities and high level goals and objectives of the project" "Opportunity Canvas, slideck, etc"{
                    tags "product"
                }
                storyMap = component "User Story Map" "Describe the User journey through the Product telling a story from the perspective of the end user" "Spreading domain knowledge through the whole team will create a shared understanding of the system to build."{
                    tags "product"
                }
                backlog = component "Product Backlog" "Prioritised list of User Stories that need to be completed or addressed during the project" "They typically follow the template: As a [user type/role], I want [a capability] so that [benefit or goal]"{
                    tags "product"
                }
            }

            bdd = container "Behavior Driven Development" "Define and understand the desired system behavior before writting any code. It encourages collaboration and a shared understanding of the project's objectives" "BDD"{
                discovery = component "Specification Workshop" "Concrete rules and examples help us explore the problem domain and makes a great basis for our acceptance tests" "Example Mapping sessions to clarify and confirm the acceptance criteria"{
                    tags "product"
                }
                formulation = component "Acceptance Tests" "Once we have identified our rules and examples from our discovery sessions, we can now formulate each example as structured documentation." "Executable specifications of the system behavior"{

                }
                automation = component "Feature files" "Automate the acceptance criteria to ensure that the system behaves as expected" "Cucumber, etc"{

                }
            }

            ddd = container "Strategic Architecture and Domain Driven Design" "Decompose software systems into cohesive modules and achieve loose coupling between them to keep the application scalable and maintainable" "Sotware Architecture and Design"{
                decompose = component "Domain Decomposition" "Decompose a large problem domain into sub-domains, so that we can identify stragically significant key focus areas" "Core Domain Charts"{
                    tags "product"
                }

                strategize = component "Strategic Architecture" "Explore models in a creative collaboration of domain experts and software engineers" "Document Bounded Contexts, from naming to responsibilities alongside its public interface and dependencies"{

                }

                design = component "Software Design" "Create models using a common set of abstractions to describe the static structure of a software system" "C4 model"{

                }

            }

            tdd = container "Test Driven Development " "Acceptance Tests guide our code implementation using lower-level examples of the behavior of internal system components. " ""{

                development = component "Test Driven Development" "Lower-level examples of the behavior of internal system components" "JUnit, etc"{

                }

                continuousIntegration = component "Continuous Integration" "Automated build scripts are used to run tests and provide immediate feedback to developers about the status of their code changes" "Jenkins, etc"{

                }
            }

            documentation = container "Knowledge Base" "Centralized repository of information and best practices that the team can refer to for guidance, problem-solving, and knowledge sharing." "Confluence, etc"{

                knowledgeBase = component "Knowledge Base" "A centralised repository for all the project documentation" "Confluence, etc"{

                }

                livingDocumentation = component "Living Documentation" "Documentation that is co-located with the code and is updated as the code changes" "Confluence, etc"{

                }

            }

            agile = container "Agile Product Management" "Agile projects are broken down into two-week iterations which result in a potentially shippable product increment" "Agile Manifesto"{

                tags "agile"
                informationRadiators = component "Information Radiators" "Project progress and potential issues are visible to all team members with information radiators" "Scrum and Kanban boards Jira, Miro, etc"{

                }

                ceremonies = component "Agile Ceremonies" "Agile ceremonies, metrics and feedback loops to help the team make informed decisions" "Jira, Knowledge Base, etc"{

                }

                customerSupport = component "Customer Support" "The process of providing assistance to the end users of the product" "Jira"{

                }
            }

        }

        product -> process "contributes to"
        developer -> process "follows"
        product -> productBrief "presents"
        developer -> storyMap "collaborates on"

        alignAndUnderstand -> bdd "requirement specification
        alignAndUnderstand -> ddd "Collaborative domain modelling"

        // container relationships
        bdd -> tdd "guides code implementation"
        ddd -> documentation "generate documentation"
//        tdd -> documentation "updates"
        bdd -> agile "supports"
        tdd -> agile "updates progress"
        ddd -> agile "enhances agility"
//        documentation -> agile "supports"

        //align and understand
        productBrief -> storyMap "collaborative domain discovery" "Miro"
        storyMap -> backlog "formulate user stories and create the project backlog" "Jira"
        storyMap -> discovery "identify rules and examples" "Miro"
        storyMap -> decompose "problem decomposition" "Core Domain Charts"


        //bdd
        automation -> development "guides development" "Cucumber"
        discovery -> formulation "formulate acceptance criteria" "Gherkin"
        formulation -> automation "automate acceptance tests" "Cucumber"

        //ddd
        decompose -> strategize "collaborative modelling" "Miro"
        strategize -> design "visualize software architecture" "draw.io, structurizr"
        design -> knowledgeBase "document the software design" "Google "

        //tdd
        development -> ceremonies "updates progress on"
        development -> continuousIntegration "push code to version control"
        continuousIntegration -> livingDocumentation "updates"


        //agile
        ceremonies -> informationRadiators "visualize progress on"
        ceremonies -> backlog "delivers on"

        //knowledge base
        knowledgeBase -> customerSupport "referenced by"
        knowledgeBase -> development "reference for"
    }

    views {
        systemContext process "Context" "The system context diagram for the Software Development Process" {
            include *
        }

        container process "Containers" {
            include *
            exclude documentation->tdd agile->alignAndUnderstand
        }

        component alignAndUnderstand "Components" "All Components and relationships" {
            include productBrief storyMap discovery formulation automation decompose strategize design backlog ceremonies informationRadiators customerSupport knowledgeBase development continuousIntegration livingDocumentation
       }

        component alignAndUnderstand "AlignAndUnderstand" {
            include product developer productBrief storyMap backlog bdd ddd
        }

        component bdd "BehaviorDrivenDevelopment" {
            include *
        }

        component agile "AgileProjectManagement" "Agile projects are broken down into two-week iterations which result in a potentially shippable product increment" {
            include *
            autoLayout lr
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
