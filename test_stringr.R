## cleanup
rm(list = ls()) 

aeslinks <- read.csv("aeslinks.csv", sep=";", header=TRUE, stringsAsFactors = FALSE)
aesnodes <- read.csv("aesnodes.csv", sep=";", header=TRUE, stringsAsFactors = FALSE)
# aesnodes <- unique(aesnodes, incomparables = FALSE) # false issue

## igraph method
 library(igraph)
 net <- graph_from_data_frame(d=aeslinks, vertices=aesnodes, directed=T) 
 plot(net)
# 

## visNetwork prettier and has more edge options
library("visNetwork") 
library("stringr")

# play with nodes
vis.aesnodes <- aesnodes
vis.aeslinks <- aeslinks
visNetwork(vis.aesnodes, vis.aeslinks)

# test this https://www.datasciencemadesimple.com/replace-the-character-column-of-dataframe-in-r-2/
vis.aesnodes <- aesnodes
vis.aeslinks <- aeslinks
vis.aesnodes$shape <- aesnodes$node.type
vis.aesnodes$shape <- str_replace(vis.aesnodes$shape, "challenge", "box")
vis.aesnodes$shape <- str_replace(vis.aesnodes$shape, "solution", "ellipse")
vis.aesnodes$color <- aesnodes$node.type
vis.aesnodes$color <- str_replace(vis.aesnodes$color, "challenge", "lightgrey")
vis.aesnodes$color <- str_replace(vis.aesnodes$color, "solution", "gold")

vis.aesnodes$shadow <- TRUE # Nodes will drop shadow
#vis.aesnodes$label  <- aesnodes$id
vis.aesnodes$label  <- aesnodes$short.definition
vis.aesnodes$title  <- aesnodes$long.definition
vis.aesnodes$borderWidth <- 1 

# vis.aesnodes$color.border <- "black"
# vis.aesnodes$color.highlight.background <- "lightgreen"
# vis.aesnodes$color.highlight.border <- "red"

vis.aeslinks$width <- aeslinks$weight*3 # line width
vis.aeslinks$dashes <- aeslinks$type #c(TRUE, FALSE)[aeslinks$type]
vis.aeslinks$color <- c("green", "red", "slategrey")[aeslinks$color]  
#vis.aeslinks$arrows <- "middle"
vis.aeslinks$smooth <- FALSE    # should the edges be curved?
vis.aeslinks$shadow <- FALSE    # edge shadow
vis.aeslinks$labelHighlightBold <- TRUE

visNetwork(vis.aesnodes, vis.aeslinks)

# subset for "Crop choice"
ed_exp4 <- subset(education, Region == 2, select = c("State","Minor.Population","Education.Expenditures"))

rm(toto)
aesnodes$id

toto <- subset(aesnodes, id == c("n900", "n901", "n902",  "n903", "n904", "n905", "n906"))

head(toto)
tail(toto)

# why 901 not in the dataset?
toto <- subset(aesnodes, com_solution == c("Biodiversity", 
                                           "Targeted biodiversity", 
                                           "Crop protection", 
                                           "GHG Emissions", 
                                           "Pollution", 
                                           "Soil fertility",
                                           "Crop choice"))


head(aeslinks)

totolinks <- subset(aeslinks, group == "Crop choice")

                      
                      c("Biodiversity", 
                                          "Targeted biodiversity", 
                                          "Crop protection", 
                                          "GHG Emissions", 
                                          "Pollution", 
                                          "Soil fertility"))



library(dplyr)
distinct(aesnodes, com_solution)
distinct(aesnodes, id)

, "Crop choice" 

        Production
        Crop protection
        GHG Emissions
        Pollution
        Soil fertility
        Targeted biodiversity
        Crop choice
        
tail(vis.aesnodes)
