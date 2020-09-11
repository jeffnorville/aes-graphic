
#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(readxl)
library(networkD3)


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
    
    # Load data
    data(MisLinks)
    data(MisNodes)      

    yed_test <- read_excel("C:/Users/Norville/OneDrive/Documents/INRA-2020/17_sept_2020/yed_test.xlsx", 
                           sheet = "Feuil2", skip = 1)
    
    # yed_test <- read_excel("C:/Users/Jeff Norville/OneDrive/Documents/INRA-2020/17_sept_2020/yed_test.xlsx", 
    #                        sheet = "Feuil2", skip = 1)

    src <- yed_test$`Common challenge impacted...17`
    tgt <- yed_test$`Solution in common...18`
    val <- yed_test$BQ
    # networkAES <- data.frame(src, tgt, val)
    # networkAES <- na.omit(networkAES)

    output$net <- renderForceNetwork(forceNetwork(
        Links  = tgt, Nodes   = src,
        Source = "source", Target  = "target",
        Value  = "value",  NodeID  = "name", zoom = TRUE, 
        Group  = "group",  opacity = input$opacity))

    
    # output$net <- renderForceNetwork(forceNetwork(
    #     Links  = MisLinks, Nodes   = MisNodes,
    #     Source = "source", Target  = "target",
    #     Value  = "value",  NodeID  = "name", zoom = TRUE, 
    #     Group  = "group",  opacity = input$opacity))
    
    
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
