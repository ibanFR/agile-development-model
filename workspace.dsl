workspace "Software Development Process fo agile Product Feature delivery"{

    model {

        product = person "Product stakeholder" "Product Team member who owns and drives the product vision"{
            tags "product"
        }
        developer = person "Engineering stakeholder" "Engineering Team member who follows the software development process to become more efficient"

        process = softwareSystem "Software Development Process" "The process used to develop and deliver product features" "Software Development Process"{
            !docs docs
            !adrs adrs

            productBrief = container "Product Brief" "Short product or feature brief to frame and constrain the project. Identifies key capabilities and high level goals and objectives of the project" "Opportunity Canvas, slideck, etc"{
                tags "product"
            }
            storyMap = container "User Story Map" "Describe the User journey through the Product telling a story from the perspective of the end user" "Spreading domain knowledge through the whole team will create a shared understanding of the system to build."{
                tags "product"
            }
            backlog = container "Product Backlog" "Prioritised list of User Stories that need to be completed or addressed during the project" "They typically follow the template: As a [user type/role], I want [a capability] so that [benefit or goal]"{
                tags "product"
            }
        }

        product -> process "contributes to"
        developer -> process "follows"
        product -> productBrief "presents"
        productBrief -> storyMap "collaborative domain discovery" "Miro"
        storyMap -> backlog "formulate user stories and create the project backlog" "Jira"
    }

    views {
        systemContext process "Context" "The system context diagram for the Software Development Process" {
            include *
//            autolayout lr
        }

        container process "Containers" {
            include *
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
