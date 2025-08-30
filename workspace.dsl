workspace "Software Development Model for Product feature delivery"{

    !docs docs

    model {

        product = person "Domain Expert" "Product Team member who owns and drives the product vision"{
            tags "product"
        }
        developer = person "Software Engineer" "Development Team member delivering high-quality software efficiently and iteratively"

        process = softwareSystem "Software Development Model for Product feature delivery" "Dynamic and iterative approach to delivering product features in a rapid and flexible manner" "Software Development Model"{

            !adrs adrs

            allComponents = container "All Components" "All Components and relationships" "All Components"{

            }

            alignAndUnderstand = container "Align and Understand Product Requirements" "Align our focus with the organisation's business model, the needs of its users, and its short, medium, and long-term goals" "Align & Understand"{
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

            bdd = container "Behavior-Driven Development" "Define and understand the desired system behavior before writting any code. It encourages collaboration and a shared understanding of the project's objectives" "BDD"{
                discovery = component "Specification Workshop" "Concrete rules and examples help us explore the problem domain to clarify and confirm the acceptance criteria" "Example Mapping"{
                    tags "product"
                }
                formulation = component "Features" "Group of related scenarios that demostrates how a feature works" "Gherkin"{

                }
                automation = component "Acceptance Tests" "Executable specifications that verify the behavior of the system against its requirements" "Cucumber"{

                }
            }

            ddd = container "Software Architecture and Domain-Driven Design" "Explore models in a creative collaboration of domain experts and software engineers" "DDD"{

                strategize = component "Strategic Architecture" "Decompose a large problem domain into cohesive modules, so that we can identify stragically significant key focus areas" "Core Domain Charts"{
                    tags "product"
                }

                define = component "Define roles and responsibilities" "Document Bounded Contexts, from naming to responsibilities alongside its public interface and dependencies" "Bounded Context Canvas"{

                }

                design = component "Software Design" "Create models using a common set of abstractions to describe the static structure of a software system" "C4 model, UML, etc"{

                }

            }

            xp = container "Extreme Programming " "Developers work together in pairs and as a group, improving the design continually to keep it always just right for the current needs" "XP"{

                pairProgramming = component "Pair Programming" "Developers work together in pairs and as a group, reviewing the code in real-time and improving the design continuously" "Ensemble, Mob Programming"{

                }

                tdd = component "Test-Driven Development" "Lower-level examples of the behavior of internal system components" "JUnit, etc"{

                }

                continuousIntegration = component "Continuous Integration" "Automated build scripts are used to run tests and provide immediate feedback to developers about the status of their code changes" "Jenkins, Github Actions, etc"{

                }
            }

            agile = container "Lean Product Management" "Projects are broken down into two-week iterations which result in a potentially shippable product increment" "Agile"{

                tags "product"


                informationRadiators = component "Information Radiators" "Project progress and potential issues are visible to all team members with information radiators" "Scrum and Kanban boards, Metric Dashboards etc"{

                }

                iterations = component "Short Iterations" "Short iterations and feedback loops to help the team make informed decisions" "two to four week development cycles"{
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
        bdd -> agile "creates shared understanding"
        ddd -> agile "enhances agility"

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
        strategize -> define "collaborative modelling"
        define -> design "visualize software architecture"
//        The relationship below is inferred in continuousIntegration -> knowledgeBase
//        design -> knowledgeBase "document the software design" "Google Drive"
        developer -> strategize "identifies strategic focus areas"
        product -> strategize "validates and categorizes subdomains"
        design -> pairProgramming "guides code implementation"

        //xp
        developer -> pairProgramming "implements high-quality software"
        pairProgramming -> tdd "write just enough code"
        tdd -> continuousIntegration "push code to version control"
        continuousIntegration -> iterations "deliver product increment"

        //agile
        product -> iterations "validates product increments"
        developer -> iterations "continuously improves"
        iterations -> informationRadiators "visualize progress on"
        iterations -> knowledgeBase "updates"
        iterations -> customerFeedback "gathers"
        customerFeedback -> backlog "improves the design of products"


    }

    views {
        properties {
            "generatr.site.exporter" "structurizr"
        }
        systemContext process "Context" "The system context diagram for the Software Development Process" {
            include *
            autoLayout tb
        }

        container process "Containers" {
            include *
            autoLayout tb
            exclude allComponents
            exclude product->ddd product->agile product->bdd
            exclude developer->agile developer->ddd developer->bdd developer->xp
            exclude agile->alignAndUnderstand
        }

        component allComponents "Components" "All Components and relationships" {
            include product developer productBrief storyMap discovery formulation automation
            include strategize define design
            include pairProgramming tdd continuousIntegration
            include backlog iterations informationRadiators customerFeedback knowledgeBase
            exclude product->discovery product->iterations product->strategize
            exclude developer->strategize developer->pairProgramming developer->iterations developer->discovery
            exclude customerFeedback->backlog
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
            exclude product->alignAndUnderstand developer->alignAndUnderstand
            autoLayout lr
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
