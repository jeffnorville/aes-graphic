library(readxl)
library(dplyr)
library(networkD3) #simpleNetwork(), forceNetwork()
library(igraph)    #graph_from_data_frame()

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

rm(aes_links)
rm(aes_nodes)

library(igraph)
net <- graph_from_data_frame(d=aes_links, vertices=aes_nodes, directed=T) 
class(net)
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









library("visNetwork") 
head(aes_links)
head(aes_nodes)

class(aes_nodes)
class(nodes)

visNetwork(aes_nodes, aes_links)



pesticide %>% filter(.data = d11, com_solution == "Pesticide use")



yed_test <- read_excel("C:/Users/Norville/OneDrive/Documents/INRA-2020/17_sept_2020/yed_test.xlsx", 
                       sheet = "Feuil2", skip = 1)
yed_test <- read_excel("C:/Users/Jeff Norville/OneDrive/Documents/INRA-2020/17_sept_2020/yed_test.xlsx", 
                       sheet = "Feuil2", skip = 1)



class(d11)
d11$retain


rm(links, nodes)

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



# rm(db)

### archive old DT. datbase entries

### load to DT in package DTedit

### plot the relationships


# forceNetwork 
data(MisLinks)
data(MisNodes)

# Create graph
forceNetwork(Links = MisLinks, Nodes = MisNodes, Source = "source",
             Target = "target", Value = "value", NodeID = "name",
             Group = "group", opacity = 1, zoom = F, bounded = T)


#Nodes

#Links


### render to Shiny 

### republish

# readxl




