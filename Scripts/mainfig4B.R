library(dplyr)
library(emmeans)
df <- read.csv('~/Desktop/for_r.csv',stringsAsFactors = T)
df <- read.csv('~/Desktop/riskscoresforr.csv', stringsAsFactors = T)
#df<-df%>%filter(Clade!="")
#df<-df%>%filter(Number_of_vaccination_doses_before_infection!=".")
df <- df[!df$Number_of_vaccination_doses_before_infection == 4, ]
df <- df[!df$Number_of_vaccination_doses_before_infection == 5, ]

colnames(df)
df$Number_of_vaccination_doses_before_infection <-as.factor(df$Number_of_vaccination_doses_before_infection)
#filtered_df <- df[(df$Clade=='21M/K/L (Omicron)' | df$Clade=='21J/I/A (Delta)'), ] 
model1 <- lm(median~Clade+ICU+Number_of_vaccination_doses_before_infection, df)
summary(model1)


a <- pairs(lsmeans(model1, ~Clade), adjust = 'FDR')

#write.csv(a, '~/Desktop/r_pval.csv')