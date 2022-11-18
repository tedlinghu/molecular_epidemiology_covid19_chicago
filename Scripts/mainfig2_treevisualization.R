#Tree Visualization

library("treeio")
library("ggtree")
library("ape")
library(ggtreeExtra)
library(ggplot2)
library(RColorBrewer)

time_tree <- read.nexus("annotated_tree.nexus")
TreeData<-as.data.frame(as_tibble(time_tree))
names(TreeData)[4]<-"name"

Global_Metadata_Tree<-merge(TreeData,Global_Metadata,by="name",sort = F)

rownames(Global_Metadata_Tree) <- Global_Metadata_Tree$name
Global_Metadata_Tree_Clades<-as.data.frame(Global_Metadata_Tree%>%dplyr::select(clade))

ggtree(time_tree,mrsd = "2022-04-1",as.Date = T)
p<-ggtree(time_tree,layout = "circular")%<+% Global_Metadata_Tree +
  geom_tippoint(aes(color=country))
p 

colourCount = length(unique(Global_Metadata_Tree$clade))
getPalette = colorRampPalette(brewer.pal(12, "Paired"))

p + geom_fruit(
  geom=geom_tile,
  mapping=aes(fill=Global_Metadata_Tree$clade),
  width=0.5,offset = 0.2,show.legend=T)+scale_fill_manual(values = getPalette(colourCount))+rremove("legend")

