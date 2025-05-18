workspace "Agile Software Development Model for efficient Product feature delivery"{

    !docs docs

    model {

        product = person "Product stakeholder" "Product Team member who owns and drives the product vision"{
            tags "product"
        }
        developer = person "Software Engineer" "Engineering Team member who follows the software development model to become more efficient"

        process = softwareSystem "Software Development Model for Product feature delivery" "Dynamic and iterative approach to delivering product features in a rapid and flexible manner" "Software Development Model"{

            !adrs adrs

            allComponents = container "All Components" "All Components and relationships" "All Components"{

            }

            alignAndUnderstand = container "Align and Understand Product Requirements" "Align our focus with the organisation's business model, the needs of its users, and its short, medium, and long-term goals." "Align & Understand"{
                tags "product"
                productBrief = component "Product Brief" "Short product or feature brief to frame and constrain the project" "Opportunity Canvas, Slideck, etc"{
                    tags "product"
                }

                storyMap = component "Domain Discovery" "Map the Big Picture by describing the User journey through the Product telling a story from the perspective of the end user" "User Story Map, Event Storming, etc"{
                    tags "product"
                }
            }

            bdd = container "Behavior Driven Development" "Define and understand the desired system behavior before writting any code. It encourages collaboration and a shared understanding of the project's objectives" "BDD"{
                discovery = component "Specification Workshop" "Concrete rules and examples help us explore the problem domain and makes a great basis for our acceptance tests" "Example Mapping sessions to clarify and confirm the acceptance criteria"{
                    tags "product"
                }
                formulation = component "Acceptance" "Once we have identified our rules and examples, we can now formulate each example as structured documentation." "Executable specifications of the system behavior"{

                }
                automation = component "Automated Features" "Group(s) related scenarios that demostrates how a feature works " "Cucumber, Selenium etc"{

                }
            }

            ddd = container "Strategic Architecture and Domain Driven Design" "Explore models in a creative collaboration of domain experts and software engineers." "DDD"{

                decompose = component "Domain Decomposition" "Decompose a large problem domain into cohesive modules, so that we can identify stragically significant key focus areas" "Core Domain Charts"{
                    tags "product"
                }

                strategize = component "Strategic Architecture" "Document Bounded Contexts, from naming to responsibilities alongside its public interface and dependencies" "Bounded Context Canvas"{

                }

                design = component "Software Design" "Create models using a common set of abstractions to describe the static structure of a software system" "C4 model"{

                }

            }

            agile = container "Agile Product Management" "Agile projects are broken down into two-week iterations which result in a potentially shippable product increment" "Agile"{

                tags "product"


                backlog = component "Product Backlog" "Prioritised list of User Stories that need to be completed or addressed during the project" "Jira, Trello, etc" {
                    tags "product"
                }

                informationRadiators = component "Information Radiators" "Project progress and potential issues are visible to all team members with information radiators" "Scrum and Kanban boards, Metric Dashboards etc"{

                }

                ceremonies = component "Agile Iterations" "Agile iterations, metrics and feedback loops to help the team make informed decisions" "Miro, etc"{

                }

                knowledgeBase = component "Knowledge Base" "Centralized repository of information and best practices that the team can refer to for guidance, problem-solving, and knowledge sharing." "Google Drive, Confluence, etc"{

                }

                customerSupport = component "Customer Support" "The process of providing assistance to the end users of the product" "Jira"{
                    tags "product"
                }
            }

            xp = container "Extreme Programming " "Engineers working together in pairs and as a group, with simple design and obsessively tested code, improving the design continually to keep it always just right for the current needs. " "XP"{

                pairProgramming = component "Pair Programming" "Developers work together in pairs and as a group, reviewing the code in real-time and improving the design continuously" "Pair Programming, Ensemble, Mob Programming"{

                }

                development = component "Test Driven Development" "Lower-level examples of the behavior of internal system components" "JUnit, etc"{

                }

                continuousIntegration = component "Continuous Integration" "Automated build scripts are used to run tests and provide immediate feedback to developers about the status of their code changes" "Jenkins, Github Actions, etc"{

                }
            }

        }

        product -> process "contributes to"
        developer -> process "follows"
        product -> productBrief "presents Product Feature"
        developer -> productBrief "obtains domain knowledge"

        // container relationships
        alignAndUnderstand -> ddd "collaborative domain modelling"
        bdd -> agile "creates shared understanding"
        ddd -> agile "enhances agility"

        //align and understand
        productBrief -> storyMap "spread domain knowledge"
        storyMap -> discovery "collaborative requirement specification"
        storyMap -> decompose "problem decomposition"

        //bdd
        product -> discovery "presents rules and examples"
        developer -> discovery "identifies functional gaps or inconsistencies"
        discovery -> formulation "formulate acceptance criteria" "Gherkin, Natural language"
        formulation -> automation "automate acceptance tests" "Cucumber, JUnit"
        automation -> pairProgramming "guides code implementation"

        //ddd
        decompose -> strategize "collaborative modelling" "Miro"
        strategize -> design "visualize software architecture" "structurizr, draw.io, miro"
//        The relationship below is inferred in continuousIntegration -> knowledgeBase
//        design -> knowledgeBase "document the software design" "Google Drive"
        developer -> decompose "identifies strategic focus areas"
        product -> decompose "validates and categorizes subdomains"
        design -> pairProgramming "guides code implementation"

        //xp
        developer -> pairProgramming "implements high-quality software"
        pairProgramming -> development "write just enough code"
        development -> continuousIntegration "push code to version control"
        continuousIntegration -> backlog "deliver product increment"
        continuousIntegration -> knowledgeBase "updates living documentation" "structurizr, serenity, javadoc"

        //agile
//        product -> backlog "validates product increments"
        product -> ceremonies "validates product increments"
        developer -> ceremonies "continuous improvement"
        backlog -> informationRadiators "visualize progress on"
        knowledgeBase -> customerSupport "is referenced by"


    }

    views {
        properties {
            "generatr.site.exporter" "structurizr"
        }
        systemContext process "Context" "The system context diagram for the Software Development Process" {
            include *
        }

        container process "Containers" {
            include *
            autoLayout tb
            exclude allComponents
            exclude product->ddd product->agile product->bdd
            exclude developer->agile developer->ddd developer->bdd developer->xp
            exclude agile->xp
        }

        component allComponents "Components" "All Components and relationships" {
            include product developer productBrief storyMap discovery formulation automation
            include decompose strategize design
            include pairProgramming development continuousIntegration
            include backlog ceremonies informationRadiators customerSupport knowledgeBase
            exclude product->discovery product->ceremonies product->decompose product->backlog
            exclude developer->decompose developer->pairProgramming developer->ceremonies developer->discovery
//            autolayout lr
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
            exclude product->agile
            exclude developer->agile
            autoLayout lr
        }

        component ddd "DomainDrivenDesign" "" {
            include *
            exclude *->alignAndUnderstand
            exclude product->agile
            exclude developer->agile developer->xp
            exclude xp->*
            autolayout lr
        }

        component xp "TestDrivenDevelopment" {
            include *
            exclude developer->agile bdd->agile ddd->agile
            exclude *->bdd
            exclude *->ddd
            autoLayout lr
        }

        component agile "AgileProductManagement" "Agile projects are broken down into two-week iterations which result in a potentially shippable product increment" {
            include *
            exclude *->xp
//            autoLayout lr
        }



        theme default

        styles {
            element "product" {
                background grey
                color #ffffff
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
