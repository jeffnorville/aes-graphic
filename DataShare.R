#library(readxl)
library(dplyr)
library(networkD3) #simpleNetwork(), forceNetwork()
library(igraph)    #graph_from_data_frame()

## cleanup
rm(list = ls()) 


### grab changes to D1.1 Table database tab

#db <- read_xlsx('C:/Users/Norville/Documents/QuickStart/D1.1_List_of_AES_English.xlsm')
rm(d11)
d11 <- read_excel("C:/Users/Norville/Dropbox/API-SMAL_Partage_Animation/Livrables/D1.1_List_of_AES_English.xlsm",
                  sheet = "database", skip = 1)
d11$com_solution

aes_links <- read_excel("C:/Users/Norville/Dropbox/API-SMAL_Partage_Animation/Livrables/D1.1_List_of_AES_English.xlsm",
                  sheet = "links", skip = 1)
aes_nodes <- read_excel("C:/Users/Norville/Dropbox/API-SMAL_Partage_Animation/Livrables/D1.1_List_of_AES_English.xlsm",
                        sheet = "nodes", skip = 1)
### simpler to do by csv for now
aeslinks <- read.csv("aeslinks.csv", sep=";", header=TRUE, stringsAsFactors = FALSE)
aesnodes <- read.csv("aesnodes.csv", sep=";", header=TRUE, stringsAsFactors = FALSE)
# aesnodes <- unique(aesnodes, incomparables = FALSE) # false issue

## igraph method
library(igraph)
net <- graph_from_data_frame(d=aeslinks, vertices=aesnodes, directed=T) 
plot(net)

## visNetwork prettier and has more edge options
library("visNetwork") 
# play with nodes
vis.aesnodes <- aesnodes
vis.aeslinks <- aeslinks

visNetwork(vis.aesnodes, vis.aeslinks)

#distinct(aesnodes, node.type)
distinct(vis.aesnodes, shape)

#clean up nodes

vis.aesnodes$shape
vis.aesnodes$shape <- aesnodes$node.type
#gsub("solution", "ellipse", vis.aesnodes$shape)
#gsub("challenge", "box", vis.aesnodes$shape)
vis.aesnodes["shape"]

vis.aesnodes$shape[c()]

vis.aesnodes$shape[c(1, 2)] <- c("ellipse", "box")
#vis.aesnodes$shape  <- c("ellipse", "box")[aesnodes$node.type]
vis.aesnodes$shadow <- TRUE # Nodes will drop shadow
vis.aesnodes$title  <- aesnodes$short.definition
vis.aesnodes$label  <- aesnodes$long.definition
vis.aesnodes$borderWidth <- 2 # Node border width
vis.aesnodes$color.background <- c("lightgrey", "gold")[aesnodes$node.type]
vis.aesnodes$color.border <- "black"
vis.aesnodes$color.highlight.background <- "lightgreen"
vis.aesnodes$color.highlight.border <- "red"

#clean up links
vis.aeslinks$width <- aeslinks$weight*3 # line width
vis.aeslinks$dashes <- aeslinks$type #c(TRUE, FALSE)[aeslinks$type]
vis.aeslinks$color <- c("green", "red", "black")[aeslinks$color] # line color  
vis.aeslinks$arrows <- "middle" # arrows: 'from', 'to', or 'middle'

vis.aeslinks$smooth <- FALSE    # should the edges be curved?
vis.aeslinks$shadow <- FALSE    # edge shadow
vis.aeslinks$labelHighlightBold <- TRUE

visNetwork(vis.aesnodes, vis.aeslinks)


?visNetwork
?visNodes
?visEdges



### FOREST ONLY
### simpler to do by csv 
forestnodes <- read.csv("forestnodes.csv", sep=";", header=TRUE, as.is = TRUE) # stringsAsFactors = FALSE
forestlinks <- read.csv("forestlinks.csv", sep=";", header=TRUE, as.is = TRUE)
library(igraph)
net <- graph_from_data_frame(d=forestlinks, vertices=forestnodes, directed=T) 
plot(net)

library("visNetwork") 
vis.forestnodes <- forestnodes
vis.forestlinks <- forestlinks

vis.forestnodes$shape  <- c("ellipse", "box")[forestnodes$node.type]
vis.forestnodes$shadow <- FALSE # Nodes will drop shadow
vis.forestnodes$title  <- forestnodes$short.definition
vis.forestnodes$label  <- forestnodes$long.definition
vis.forestnodes$borderWidth <- 1 # Node border width
vis.forestnodes$color.background <- c("gold", "grey")[forestnodes$node.type]
vis.forestnodes$color.border <- "black"
vis.forestnodes$color.highlight.background <- "lightgreen"
vis.forestnodes$color.highlight.border <- "red"

#clean up links
vis.forestlinks$width <- forestlinks$weight*4 # line width
vis.forestlinks$color <- c("green", "red")[forestlinks$color] #"green"    # line color  
vis.forestlinks$arrows <- "middle" # arrows: 'from', 'to', or 'middle'
vis.forestlinks$smooth <- TRUE    # should the edges be curved?
vis.forestlinks$shadow <- FALSE    # edge shadow

visNetwork(vis.forestnodes, vis.forestlinks)

### FOREST ONLY



library(networkD3)

forceNetwork(Links = aeslinks, Nodes = aesnodes, Source = "source",
             Target = "target", Value = "value", NodeID = "name",
             Group = "group", opacity = 0.4)


library(igraph)
net <- graph_from_data_frame(d=aes_links, vertices=aes_nodes, directed=T) 
E(net)
V(net)

E(net)[weight==0]
V(net)[type=="Challenge"]
V(net)[type=="Solution"]

V(net)[name=="Targeted biodiversity"]

V(net)[name=="Biodiversity"]


as_edgelist(net, names=T)
as_adjacency_matrix(net, attr="weight")

as_data_frame(net, what="edges")
as_data_frame(net, what="vertices")

plot(net)

# Removing loops from the graph:
net <- simplify(net, remove.multiple = F, remove.loops = T) 

# Let's and reduce the arrow size and remove the labels:
plot(net, edge.arrow.size=.4,vertex.label=NA)

plot(net, edge.arrow.size=.4, edge.curved=.1)

# Set node color to orange and the border color to hex #555555
# Replace the vertex label with the node names stored in "media"
plot(net, edge.arrow.size=.2, edge.curved=0,
     vertex.color="orange", vertex.frame.color="#555555",
     vertex.label=V(net)$media, vertex.label.color="black",
     vertex.label.cex=.7) 

# Compute node degrees (#links) and use that to set node size:
deg <- degree(net, mode="all")
V(net)$size <- deg*3

E(net)[]
# Set edge width based on weight:
E(net)$width <- E(net)$weight/6

#change arrow size and edge color:
E(net)$arrow.size <- .2
E(net)$edge.color <- "gray80"

# We can even set the network layout:
graph_attr(net, "layout") <- layout_with_lgl
plot(net) 

# We can also override the attributes explicitly in the plot:
plot(net, edge.color="orange", vertex.color="gray50") 


### SANKEY of FOREST
library(networkD3)

sankeyNetwork(Links = forestlinks, Nodes = forestnodes, Source = "from",
              Target = "to", Value = "weight", NodeID = "id",
              units = "dunno", fontSize = 12, nodeWidth = 30)






pesticide %>% filter(.data = d11, com_solution == "Pesticide use")
# then the trick begins at line 245 of Sunbelt 2019 R Network Visualization Workshop.R
# Read in the data:
# nodes2 <- read.csv("./Data files/Dataset2-Media-User-Example-NODES.csv", header=T, as.is=T)
# links2 <- read.csv("./Data files/Dataset2-Media-User-Example-EDGES.csv", header=T, row.names=1)

# links2 is a matrix for a two-mode network:
links2 <- as.matrix(links2)

yed_test <- read_excel("C:/Users/Norville/OneDrive/Documents/INRA-2020/17_sept_2020/yed_test.xlsx", 
                       sheet = "Feuil2", skip = 1)
yed_test <- read_excel("C:/Users/Jeff Norville/OneDrive/Documents/INRA-2020/17_sept_2020/yed_test.xlsx", 
                       sheet = "Feuil2", skip = 1)
class(d11)
d11$retain
#rm(links, nodes)

links <- distinct(.data = data.frame(source = d11$com_challenge, 
                    target = d11$com_solution,
                    importance = d11$qbalance),
                  .keep_all = FALSE)

nodes <- distinct(
  data.frame(source = d11$com_challenge,
             carac = d11$sol_tag_scenario),
  .keep_all = FALSE
)

network <- graph_from_data_frame(d=links, vertices=nodes, directed=TRUE) 

links <- distinct(.data = data.frame(source =  yed_test$`Solution in common...1`,
                    target=    yed_test$`Common challenge impacted...4`,
                    importance=yed_test$BQ),
                  .keep_all = FALSE)
nodes <- distinct(.data = data.frame(name = yed_test$`Common challenge impacted...4`,
                      carac=yed_test$`Specific issue impacted`),
                  .keep_all = FALSE)


# Turn it into igraph object
network <- graph_from_data_frame(d=links, vertices=nodes, directed=TRUE) 

src <- yed_test$`Common challenge impacted...17`
tgt <- yed_test$`Solution in common...18`
val <- yed_test$BQ
networkAES <- data.frame(src, tgt, val)
networkAES <- na.omit(networkAES)
simpleNetwork(networkAES, zoom=TRUE)


D1_1_List_AES <- read_excel("~/QuickStart/D1.1_List_of_AES_English.xlsm", 
                                       sheet = "database", col_types = c("skip","numeric","text", 
                                           "text", "text", "text", "text", "text", 
                                           "text", "text", "text", "text", "text", 
                                           "text", "text", "text", "skip", "numeric", 
                                           "text", "text", "text", "skip"))

src <- D1_1_List_AES$`Solution in common`
tgt <- D1_1_List_AES$`Common challenge impacted`
bq <- D1_1_List_AES$BQ

networkAES <- data.frame(src, tgt, bq)
networkAES <- na.omit(networkAES)
simpleNetwork(networkAES)

summary(networkAES)
class(networkAES)






## troubleshooting unmatched nodes/edges
library(sqldf)
sqldf('SELECT id FROM aesnodes')
sqldf('SELECT from FROM aeslinks')

missing <- sqldf('SELECT id FROM aesnodes EXCEPT SELECT to FROM aeslinks')

library(dplyr)
anti_join(aesnodes, aeslinks) by (c("id", "from"))
setdiff(aesnodes$id, aeslinks$from)
setdiff(aesnodes$id, aeslinks$to)


missing_nodes %>% 
  anti_join(aesnodes, aeslinks by = "from")


# forceNetwork 
data(MisLinks)
data(MisNodes)

# Create graph
forceNetwork(Links = MisLinks, Nodes = MisNodes, Source = "source",
             Target = "target", Value = "value", NodeID = "name",
             Group = "group", opacity = 1, zoom = F, bounded = T)

