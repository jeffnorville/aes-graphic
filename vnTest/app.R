require(shiny)
require(visNetwork)
require(stringr)


server <- function(input, output) {
    output$aes_network <- renderVisNetwork({
        #setwd(dir = "C:/Users/Norville/Documents/R/aes-graphic/vnTest")
        # rm(list=ls())
        
        aeslinks <- read.csv("../aeslinks.csv", sep=";", header=TRUE, stringsAsFactors = FALSE)
        aesnodes <- read.csv("../aesnodes.csv", sep=";", header=TRUE, stringsAsFactors = FALSE)
        vis.aesnodes <- aesnodes
        vis.aeslinks <- aeslinks #edges
        
        #customization
        vis.aesnodes$shape <- aesnodes$node.type
        vis.aesnodes$shape <- str_replace(vis.aesnodes$shape, "challenge", "box")
        vis.aesnodes$shape <- str_replace(vis.aesnodes$shape, "solution", "ellipse")
        vis.aesnodes$color <- aesnodes$node.type
        vis.aesnodes$color <- str_replace(vis.aesnodes$color, "challenge", "lightgrey")
        vis.aesnodes$color <- str_replace(vis.aesnodes$color, "solution", "gold")
        
        vis.aesnodes$shadow <- TRUE # Nodes will drop shadow
        vis.aesnodes$label  <- aesnodes$short.definition
        vis.aesnodes$title  <- aesnodes$long.definition
        vis.aesnodes$borderWidth <- 2 # Node border width
        vis.aesnodes$color.border <- "black"

        #clean up links
        vis.aeslinks$width <- aeslinks$weight*3 # line width
        vis.aeslinks$dashes <- aeslinks$type #c(TRUE, FALSE)[aeslinks$type]
        vis.aeslinks$color <- c("green", "red", "slategrey")[aeslinks$color]  
        
        vis.aeslinks$smooth <- FALSE    # should the edges be curved?
        vis.aeslinks$shadow <- FALSE    # edge shadow
        vis.aeslinks$labelHighlightBold <- TRUE
        
        
        visNetwork(vis.aesnodes, vis.aeslinks)
    })
    
    observe({
        visNetworkProxy("aes_network") %>%
            visNodes(color = input$color)
    })
    
    
}

ui <- fluidPage(
    visNetworkOutput("aes_network")
)

shinyApp(ui = ui, server = server)