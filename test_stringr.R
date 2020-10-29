## cleanup
rm(list = ls()) 

aeslinks <- read.csv("aeslinks5.csv", sep=";", header=TRUE, stringsAsFactors = FALSE)
aesnodes <- read.csv("aesnodes5.csv", sep=";", header=TRUE, stringsAsFactors = FALSE)
# aesnodes <- unique(aesnodes, incomparables = FALSE) # false issue

## igraph method
 library(igraph)
 net <- graph_from_data_frame(d=aeslinks, vertices=aesnodes, directed=T) 
 plot(net)
# 

library(networkD3)
 net_aes <- data.frame(aeslinks)
 sankeyNetwork(
         aeslinks,
         aesnodes,
         Value = "weight"
 ) 
 
 
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
vis.aeslinks$smooth <- TRUE    # should the edges be curved?
vis.aeslinks$shadow <- FALSE    # edge shadow
vis.aeslinks$labelHighlightBold <- TRUE

visNetwork(vis.aesnodes, vis.aeslinks) %>% 
        visHierarchicalLayout(direction = "RL") %>%
        visInteraction(dragNodes = TRUE,
                       dragView = FALSE,
                       zoomView = TRUE)


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
                                           "Soil fertility"))



totolinks <- subset(aeslinks, group == c("Biodiversity", 
                                          "Targeted biodiversity", 
                                          "Crop protection", 
                                          "GHG Emissions", 
                                          "Pollution", 
                                          "Soil fertility"))



library(dplyr)
distinct(aesnodes, com_solution)
distinct(aesnodes, id)



##simplified


simplinks <- read.csv("../simplifylinks2.csv", sep=";", header=TRUE, stringsAsFactors = FALSE)
simpnodes <- read.csv("../simplifynodes.csv", sep=";", header=TRUE, stringsAsFactors = FALSE)
# net <- graph_from_data_frame(d=simplinks, vertices=simpnodes, directed=TRUE)
# plot(net, layout = layout_with_lgl, label = simpnodes$short.definition)
# plot(net)

# library(networkD3)
# simpNetwork <- data.frame(simplinks$from, simplinks$to)
# simpleNetwork(simpNetwork, fontFamily = "fantasy", zoom=T)



library("visNetwork") 
library(stringr)
vis.simpnodes <- simpnodes
vis.simplinks <- simplinks
vis.simpnodes$shape <- simpnodes$node.type
vis.simpnodes$shape <- str_replace(vis.simpnodes$shape, "challenge", "box")
vis.simpnodes$shape <- str_replace(vis.simpnodes$shape, "solution", "ellipse")
vis.simpnodes$color <- simpnodes$node.type
vis.simpnodes$color <- str_replace(vis.simpnodes$color, "challenge", "lightgrey")
vis.simpnodes$color <- str_replace(vis.simpnodes$color, "solution", "gold")

vis.simpnodes$shadow <- TRUE # Nodes will drop shadow
#vis.simpnodes$label  <- simpnodes$id
vis.simpnodes$label  <- simpnodes$short.definition
vis.simpnodes$title  <- simpnodes$long.definition
vis.simpnodes$borderWidth <- 1 

# vis.simpnodes$color.border <- "black"
# vis.simpnodes$color.highlight.background <- "lightgreen"
# vis.simpnodes$color.highlight.border <- "red"

vis.simplinks$width <- simplinks$weight*3 # line width
vis.simplinks$dashes <- c(FALSE, FALSE, TRUE)[simplinks$color] 
vis.simplinks$color <- c("green", "red", "slategrey")[simplinks$color]  
#vis.simplinks$arrows <- "middle"
vis.simplinks$smooth <- TRUE    # should the edges be curved?
vis.simplinks$shadow <- FALSE    # edge shadow
vis.simplinks$labelHighlightBold <- TRUE

visNetwork(vis.simpnodes, vis.simplinks) %>% 
        visPhysics(solver = "forceAtlas2Based", 
                   forceAtlas2Based = list(gravitationalConstant = -10))
