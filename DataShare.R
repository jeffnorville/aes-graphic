library(readxl)
library(dplyr)
library(networkD3) #simpleNetwork(), forceNetwork()
library(igraph)    #graph_from_data_frame()

### grab changes to D1.1 Table database tab

#db <- read_xlsx('C:/Users/Norville/Documents/QuickStart/D1.1_List_of_AES_English.xlsm')


yed_test <- read_excel("C:/Users/Norville/OneDrive/Documents/INRA-2020/17_sept_2020/yed_test.xlsx", 
                       sheet = "Feuil2", skip = 1)

yed_test <- read_excel("C:/Users/Jeff Norville/OneDrive/Documents/INRA-2020/17_sept_2020/yed_test.xlsx", 
                       sheet = "Feuil2", skip = 1)

summary(yed_test)
class(yed_test)
links <- data.frame(source =  yed_test$`Solution in common...1`,
                    target=    yed_test$`Common challenge impacted...4`,
                    importance=yed_test$BQ)
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




