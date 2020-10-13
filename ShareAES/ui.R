
# rm(list=ls())

#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(visNetwork)

shinyUI(fluidPage( 
    
    titlePanel("Syntesis of AES Workbook"), 
    
    sidebarLayout(
        sidebarPanel(
            sliderInput("opacity",
                        "Opacity",
                        min = 0.1,
                        max = 1,
                        value = 0.4)
        ),
        mainPanel(
            visNetworkOutput("aes network"),
            verbatimTextOutput("shiny_return")
        )
    )))
