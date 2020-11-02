require(shiny)
require(visNetwork)
require(stringr)

links <- read.csv("simplifylinks3.csv", sep=";", header=TRUE, stringsAsFactors = FALSE)
nodes <- read.csv("simplifynodes5.csv", sep=";", header=TRUE, stringsAsFactors = FALSE)
vis.nodes <- nodes
vis.links <- links #edges


server <- function(input, output) {
    output$aes_network <- renderVisNetwork({
        #setwd(dir = "C:/Users/Norville/Documents/R/aes-graphic/aesNetSimple")
        # rm(list=ls())
        
        # aeslinks <- read.csv("../aeslinks5.csv", sep=";", header=TRUE, stringsAsFactors = FALSE)
        # aesnodes <- read.csv("../aesnodes5.csv", sep=";", header=TRUE, stringsAsFactors = FALSE)
        # vis.aesnodes <- aesnodes
        # vis.aeslinks <- aeslinks #edges
        
        #customization
        vis.aesnodes$shape <- nodes$node.type
        vis.aesnodes$shape <- str_replace(vis.aesnodes$shape, "challenge", "box")
        vis.aesnodes$shape <- str_replace(vis.aesnodes$shape, "solution", "ellipse")
        vis.aesnodes$color <- nodes$node.type
        vis.aesnodes$color <- str_replace(vis.aesnodes$color, "challenge", "lightgrey")
        vis.aesnodes$color <- str_replace(vis.aesnodes$color, "solution", "gold")
        
        vis.aesnodes$shadow <- TRUE # Nodes will drop shadow
        vis.aesnodes$label  <- nodes$short.definition
        vis.aesnodes$title  <- nodes$long.definition
        vis.aesnodes$borderWidth <- 2 # Node border width
        vis.aesnodes$color.border <- "black"

        #clean up links
        vis.aeslinks$width <- links$weight*3 # line width
        vis.aeslinks$dashes <- c(FALSE, FALSE, TRUE)[aeslinks$color] 
        vis.aeslinks$color <- c("green", "red", "slategrey")[aeslinks$color] 
        
        vis.aeslinks$smooth <- TRUE    # should the edges be curved?
        vis.aeslinks$shadow <- FALSE    # edge shadow
        vis.aeslinks$labelHighlightBold <- TRUE

        visNetwork(vis.aesnodes, vis.aeslinks, height="1200px", width="99%") %>%
            visOptions(highlightNearest = list(enabled =TRUE, degree = 2, hover = T)) %>%
            visPhysics(enabled = FALSE) %>% 
            addFontAwesome()
    })

    observe({
        visNetworkProxy("aes_network") %>%
            visFocus(id = input$Focus, scale = 2)
    })
    
    observe({
        visNetworkProxy("aes_network") %>%
            visPhysics(enabled = input$physics) %>%
            visNodes(color = input$color)
    })
    
}

ui <- fluidPage(
    fluidRow(
        column(
            width = 2,
            selectInput("Focus", "Go to node :",
                        list(`By challenge` = list(
                                              "Biodiversity"="n900", 
                                              "Targeted biodiversity"="n906",
                                              "Crop protection"="n902",
                                              "Reduce GHG Emissions"="n903",
                                              "Reduce soil, water pollution"="n904",
                                              "Production"="n901",
                                              "Soil fertility"="n905"),
                            `By Challenge or Node` = c(unique(vis.aesnodes$id)) #nb this is buggy, cant make proper list of nodes with manual list
                        )
                    ),
            checkboxInput("physics",
                          "Unconstrained",
                          value = TRUE)
            

        ),
        column(
            width = 10,
            
    visNetworkOutput("aes_network")
        )
      )
    )

shinyApp(ui = ui, server = server)