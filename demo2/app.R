# demoing group support in the `choices` arg
shinyApp(
    ui = fluidPage(
        selectInput("state", "Choose a state:",
                    list(`East Coast` = list("New York" = "NY", "New Jersey" = "NJ", "Conn" = "CT"),
                         `West Coast` = list("WA", "OR", "CA"),
                         `Midwest` = list("MN", "WI", "IA"))
        ),
        textOutput("result")
    ),
    server = function(input, output) {
        output$result <- renderText({
            paste("You chose", input$state)
        })
    }
)
