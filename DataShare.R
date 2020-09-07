library(readxl)

### grab changes to D1.1 Table database tab

#db <- read_xlsx('C:/Users/Norville/Documents/QuickStart/D1.1_List_of_AES_English.xlsm')

D1_1_List_AES <- read_excel("~/QuickStart/D1.1_List_of_AES_English.xlsm", 
                                       sheet = "database", col_types = c("skip","numeric", 
                                           "text", "text", "text", "text", "text", 
                                           "text", "text", "text", "text", "text", 
                                           "text", "text", "text", "skip", "numeric", 
                                           "text", "text", "text", "skip"))


rm(src)
rm(tgt)

src <- D1_1_List_AES$`Solution in common`
tgt <- D1_1_List_AES$`Common challenge impacted`
networkAES <- data.frame(src, tgt)
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

