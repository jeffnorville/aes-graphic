require(shiny)
require(visNetwork)

server <- function(input, output) {
    output$network <- renderVisNetwork({
        # setwd(dir = "C:/Users/Norville/Documents/R/aes-graphic/vnTest")
        # rm(list=ls())
        
        aeslinks <- read.csv("../aeslinks.csv", sep=";", header=TRUE, stringsAsFactors = FALSE)
        aesnodes <- read.csv("../aesnodes.csv", sep=";", header=TRUE, stringsAsFactors = FALSE)
        vis.aesnodes <- aesnodes
        vis.aeslinks <- aeslinks #edges
        
        #customization
        vis.aesnodes$shape <- aesnodes$node.type
        #vis.aesnodes$shape  <- c("ellipse", "box")[vis.aesnodes$shape]
        vis.aesnodes$shadow <- TRUE # Nodes will drop shadow
        vis.aesnodes$label  <- aesnodes$short.definition
        vis.aesnodes$title  <- aesnodes$long.definition
        vis.aesnodes$borderWidth <- 2 # Node border width
        #vis.aesnodes$color.background <- c("lightgrey", "gold")[aesnodes$node.type]
        vis.aesnodes$color.border <- "black"
        vis.aesnodes$color.highlight.background <- "lightgreen"
        vis.aesnodes$color.highlight.border <- "red"
        
        #clean up links
        vis.aeslinks$width <- aeslinks$weight*3 # line width
        vis.aeslinks$dashes <- aeslinks$type #c(TRUE, FALSE)[aeslinks$type]
        #vis.aeslinks$color <- c("green", "red", "black")[aeslinks$color] # line color  
        vis.aeslinks$arrows <- "middle" # arrows: 'from', 'to', or 'middle'
        
        vis.aeslinks$smooth <- FALSE    # should the edges be curved?
        vis.aeslinks$shadow <- FALSE    # edge shadow
        vis.aeslinks$labelHighlightBold <- TRUE
        
        
        visNetwork(vis.aesnodes, vis.aeslinks)
    })
}

ui <- fluidPage(
    visNetworkOutput("network")
)

shinyApp(ui = ui, server = server)