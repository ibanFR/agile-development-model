workspace {

    model {

        user = person "User"
        softwareSystem = softwareSystem "Software System"{
            !docs docs
            !adrs adrs
        }

        user -> softwareSystem "Uses"
    }

    views {
        systemContext softwareSystem "SystemContext" {
            include *
//            autolayout lr
        }
    }

}
