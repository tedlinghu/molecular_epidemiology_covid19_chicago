library(dplyr)
library(lubridate)
library(ggplot2)
library(plyr)
library(tidyr)
library(ggsci)
library(ggpubr)
library(outbreakinfo)


Metadata<-read.csv("../ChicagoMetadata.csv", header = T, stringsAsFactors = T)
Metadata$date <- mdy(Metadata$date)
Metadata<-Metadata%>%filter(name!="NC_045512.2")

Metadata$Week<-cut(ymd(Metadata$date),breaks ="month")
Metadata_Lineages<-Metadata
Metadata_Lineages<-Metadata_Lineages %>% dplyr::count(nextclade.clade, Week)%>%group_by(Week)%>%as.data.frame()
Metadata_Lineages <- Metadata_Lineages %>%
  tidyr::spread(key = nextclade.clade, value = n, fill = 0) %>%
  tidyr::gather(key = nextclade.clade, value = n, - Week) %>%
  arrange(Week, nextclade.clade) %>%group_by(Week)%>%
  mutate(freq = n / sum(n))%>%as.data.frame()
Metadata_Lineages$Week<-ymd(Metadata_Lineages$Week)

FreqMetadata_Lineages<-aggregate(n~nextclade.clade,Metadata_Lineages,sum)
MostFreqMetadata_Lineages<-FreqMetadata_Lineages  #%>%filter(n>(sum(n)*0.01)&nextclade.clade!="None")

FreqMetadata_LineagesMostFrq<-Metadata_Lineages%>%filter(nextclade.clade%in%MostFreqMetadata_Lineages$nextclade.clade)

library(RColorBrewer)
colourCount = length(unique(Metadata_Lineages$nextclade.clade))
getPalette = colorRampPalette(brewer.pal(12, "Paired"))


#Figure 2B clade graph
FreqMetadata_LineagesMostFrq%>%
  ggplot(aes(fill=nextclade.clade, y=n, x=Week,order = dplyr::desc(n))) + 
  geom_bar(position="stack", stat="identity")+theme_pubr(legend = "right")+
  scale_fill_manual(values = getPalette(colourCount))+
  scale_x_date(date_labels = "%b-%Y",date_breaks = "month")+
  ylab("Number of Sequences")+
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))+ ggtitle("NM Clades")+xlab("Week")


#Figure 2B epi graph

df=getEpiData(location_id="USA_US-IL_17031") #can be changed to just cook epi data. I extracted this from outbreak, but uses CDC

df$Week<-cut(ymd(df$date),breaks ="week")
df$Week<-ymd(df$Week)

cook_epi_7dayavg<-aggregate(confirmed_rolling~Week, df, mean)

cook_epi_7dayavg%>%filter(Week<ymd("2022-04-01"))%>%droplevels()%>%
  ggplot(aes(x=Week)) +
  geom_line( aes(y=confirmed_rolling/1000),color="blue")+
  theme_pubr()+
  scale_x_date(date_labels = "%b-%Y",date_breaks = "month")+rotate_x_text(45)+
  ylab("Daily case count (thousands)")+xlab("")


#Figure 2C
FreqMetadata_LineagesMostFrq%>%
  ggplot(aes(fill=nextclade.clade, y=n, x=Week,order = dplyr::desc(n))) + 
  geom_area(position = "fill")+theme_pubr(legend = "right")+
  scale_fill_manual(values = getPalette(colourCount))+
  scale_x_date(date_labels = "%b-%Y",date_breaks = "3 months")+
  ylab("Frequency")+
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))+ ggtitle("NM Clades")

