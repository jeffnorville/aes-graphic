## cleanup
rm(list = ls()) 

aeslinks <- read.csv("aeslinks.csv", sep=";", header=TRUE, stringsAsFactors = FALSE)
aesnodes <- read.csv("aesnodes.csv", sep=";", header=TRUE, stringsAsFactors = FALSE)
# aesnodes <- unique(aesnodes, incomparables = FALSE) # false issue

## igraph method
library(igraph)
net <- graph_from_data_frame(d=aeslinks, vertices=aesnodes, directed=T) 
plot(net)

## visNetwork prettier and has more edge options
library("visNetwork") 
library("stringr")

# play with nodes
vis.aesnodes <- aesnodes
vis.aeslinks <- aeslinks
visNetwork(vis.aesnodes, vis.aeslinks)

aeslinks$color <- aeslinks$color + 1 # bump 0_based array to 1 based 

# test this https://www.datasciencemadesimple.com/replace-the-character-column-of-dataframe-in-r-2/
vis.aesnodes <- aesnodes
vis.aeslinks <- aeslinks
#vis.aesnodes$shape  <- c("ellipse", "box")[aesnodes$node.type]
vis.aesnodes$shape <- aesnodes$node.type
vis.aesnodes$shape <- str_replace(vis.aesnodes$shape, "challenge", "box")
vis.aesnodes$shape <- str_replace(vis.aesnodes$shape, "solution", "ellipse")

#vis.aesnodes$color.background <- c("lightgrey", "gold")[aesnodes$node.type]
vis.aesnodes$color <- aesnodes$node.type
vis.aesnodes$color <- str_replace(vis.aesnodes$color, "challenge", "lightgrey")
vis.aesnodes$color <- str_replace(vis.aesnodes$color, "solution", "gold")

vis.aesnodes$shadow <- TRUE # Nodes will drop shadow
vis.aesnodes$title  <- aesnodes$long.definition
vis.aesnodes$label  <- aesnodes$short.definition
vis.aesnodes$borderWidth <- 1 # Node border width

vis.aesnodes$color.border <- "black"
vis.aesnodes$color.highlight.background <- "lightgreen"
vis.aesnodes$color.highlight.border <- "red"

vis.aeslinks$width <- aeslinks$weight*3 # line width
vis.aeslinks$dashes <- aeslinks$type #c(TRUE, FALSE)[aeslinks$type]
vis.aeslinks$color <- c("green", "red", "slategrey")[aeslinks$color]  
vis.aeslinks$arrows <- "middle"
vis.aeslinks$smooth <- FALSE    # should the edges be curved?
vis.aeslinks$shadow <- FALSE    # edge shadow
vis.aeslinks$labelHighlightBold <- TRUE

visNetwork(vis.aesnodes, vis.aeslinks)
