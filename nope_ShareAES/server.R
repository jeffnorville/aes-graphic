
#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
#library(readxl)
#library(networkD3)
library(visNetwork)

# D1_1_List_AES <- read_excel("~/QuickStart/D1.1_List_of_AES_English.xlsm", 
#                             sheet = "database", col_types = c("skip","numeric", 
#                                                               "text", "text", "text", "text", "text", 
#                                                               "text", "text", "text", "text", "text", 
#                                                               "text", "text", "text", "skip", "numeric", 
#                                                               "text", "text", "text", "skip"))
# 
# src <- D1_1_List_AES$`Solution in common`
# tgt <- D1_1_List_AES$`Common challenge impacted`
# networkAES <- data.frame(src, tgt)
# networkAES <- na.omit(networkAES)




# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    

    output$net <- renderVisNetwork({
        # Load data
        aeslinks <- read.csv("aeslinks.csv", sep=";", header=TRUE, stringsAsFactors = FALSE)
        aesnodes <- read.csv("aesnodes.csv", sep=";", header=TRUE, stringsAsFactors = FALSE)
        vis.aesnodes <- aesnodes
        vis.aeslinks <- aeslinks
        
        visNetwork(vis.aesnodes, vis.aeslinks)
        
                
    })

    
    # output$distPlot <- renderPlot({
    # 
    #     # generate bins based on input$bins from ui.R
    #     x    <- faithful[, 2]
    #     bins <- seq(min(x), max(x), length.out = input$bins + 1)
    # 
    #     # draw the histogram with the specified number of bins
    #     hist(x, breaks = bins, col = 'darkgray', border = 'white')
    # 
    # })

})
