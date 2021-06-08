rm(list=ls())
getwd()
setwd("~/Desktop/projects/big_data_prj/HR-Analytics/src/visualization")
getwd()

if (!dir.exists("../../figures"))
{
  dir.create("../../figures")
  dir.create("../../figures/pie")
  dir.create("../../figures/barplot")
  dir.create("../../figures/histogram")
  dir.create("../../figures/multiple")
  dir.create("../../figures/boxplot")
  dir.create("../../figures/barplot/portion/")
}
Mydata <- read.csv("../../data/train_data.csv",header=TRUE,sep=",")

show_main_info <- function()
{
  str(Mydata)
  head(Mydata)
  summary(Mydata)
  names(Mydata)
}

factor_feature<- function(feat){
  fct<-factor(feat)
  print(paste("levels: ",levels(fct)))
}

pie_feature <- function(feat, lbls, colors, title, portion=FALSE){
  if (!portion)
    save_fig = paste("../../figures/pie/" , title, ".jpg",sep="")
  else
    save_fig = paste("../../figures/barplot/portion/" , title, ".jpg",sep="")
  
  jpeg(save_fig, width = 720, height = 720)
  table_values<- table(feat)
  print(table_values)
  precentage <- round(table_values/sum(table_values)*100,1)
  print(precentage)
  lbls <- paste(lbls, precentage)
  lbls <- paste(lbls,"%",sep="")
  pie(table_values,labels=lbls,col=colors,main=title )
  dev.off() 
}


barplot_feature <- function(feat, title){
  
  table_promo_feat<- table(Mydata$is_promoted,feat)
  print(colnames(table_promo_feat))
  portions <- table_promo_feat[2,] / table_promo_feat[1,]
  print (portions)
  
  lbls <- c(colnames(table_promo_feat))
  colors <- NULL
  pie_feature(portions, lbls,colors,title, portion=TRUE)
  
  save_fig = paste("../../figures/barplot/" , title, ".jpg",sep="")
  jpeg(save_fig, width = 720, height = 720)
  barplot(table_promo_feat ,ylab="number of employees", col=c("red","green") , main=title)
  legend("topright", legend = c("NOT promoted", "promoted"), fill = c("red", "Green"))
  dev.off() 
}

histogram_feature <- function (feat, title){
  save_fig = paste("../../figures/histogram/" , title, ".jpg",sep="")
  jpeg(save_fig, width = 720, height = 720)
  hist(feat, ylab="No. of Employees", main=title)
  dev.off() 
}
#-------------------------------------------------------------------------------------------------


# getting first 10 rows of data
# getting summary statistics of data
show_main_info()
#-------------------------------------------------------------------------------------------------


#Catigorical features: department, region, education, gender, recruitment_channel
cat_features <- Mydata[, 2:6] 
#Continuous features: age, no_of_trainings, previous_year_rating, length_of_service, KPIs_met >80%,
#                      awards_won?	, avg_training_score
cont_features <- Mydata[, 7:13]
#1: is promoted / 0: not promoted
target <- Mydata[, 14]
#-------------------------------------------------------------------------------------------------


# Show levels and factor for each catiforical feature
for (i in 1:ncol(cat_features)){
  print (paste("Factor feature: ",colnames(cat_features)[i]))
  factor_feature(cat_features[i])
}
#-------------------------------------------------------------------------------------------------



# showing percentage of how many employees are males and how many are females
lbls <- c("female","male")
colors <- c("red","blue")
title <- "male_female_ratio"
pie_feature(Mydata$gender, lbls, colors,title)
#-------------------------------------------------------------------------------------------------
# showing percentage of how many employees from different education level
lbls <- c("None","Bachelor's","Below Secondary","Master's & above")
colors <- c("grey","red","blue","green")
title <- "education_ratio"
pie_feature(Mydata$education, lbls, colors,title)
#-------------------------------------------------------------------------------------------------
# showing percentage of how many employees from different department
lbls <- c("Analytics","Finance","HR","Legal","Operations","Procurement","R&D","Sales & Marketing","Technology ")
colors = NULL
title <- "department_ratio"
pie_feature(Mydata$department, lbls, colors,title)
#-------------------------------------------------------------------------------------------------
# showing percentage of how many employees came from different recruitment channels
lbls <- c("other","referred","sourcing")
colors <- c("red","blue","green")
title <- "recruitment_channels_ratio"
pie_feature(Mydata$recruitment_channel, lbls, colors,title)
#-------------------------------------------------------------------------------------------------
# showing percentage of how many employees have KPI>0.8
lbls <- c("less (0)","greater (1)")
colors <- NULL
title <- "KPIs_met..80."
pie_feature(Mydata$KPIs_met..80., lbls, colors,title)
#-------------------------------------------------------------------------------------------------
# showing percentage of how many employees won awards
lbls <- c("no win(0)","won (1)")
colors <- NULL
title <- "awards_won"
pie_feature(Mydata$awards_won., lbls, colors,title)
#-------------------------------------------------------------------------------------------------
# showing percentage of how many employees are in different regions
lbls <- NULL
colors <- NULL
title <- "regions"
pie_feature(Mydata$region, lbls, colors,title)


#-------------------------------------------------------------------------------------------------
#Show different portions of features against promotion
for (i in 1:ncol(Mydata)){
  title <- colnames(Mydata)[i]
  barplot_feature(Mydata[,i], title)
}


#-------------------------------------------------------------------------------------------------
# show histogram of continous features
for (i in 1:ncol(cont_features)){
  title <- colnames(cont_features)[i]
  histogram_feature(cont_features[,i], title)
}

#-------------------------------------------------------------------------------------------------
#boxplot for outliers
for(i in 7:ncol(Mydata)) {       # for-loop over columns
  print (colnames(Mydata)[i])
  save_fig = paste("../../figures/boxplot/boxplot_" , colnames(Mydata)[i], ".jpg",sep="")
  jpeg(save_fig, width = 720, height = 720)
  boxplot(Mydata[,i], main=names(Mydata)[i])
  dev.off()
}
#-------------------------------------------------------------------------------------------------

# Not useful
for(i in 1:ncol(Mydata)) {       # for-loop over columns
  print (colnames(Mydata)[i])
  save_fig = paste("../../figures/multiple/" , i, ".jpg",sep="")
  jpeg(save_fig, width = 720, height = 720)
  plot(Mydata[,i] , Mydata$is_promoted, type="h", xlab=colnames(Mydata)[i], ylab="is_promoted")
  dev.off()
}
#-------------------------------------------------------------------------------------------------
# Corelation between variables and target
for(i in 7:ncol(Mydata)) {       # for-loop over columns
  print (colnames(Mydata)[i])
  print(cor (Mydata[,i] , Mydata$is_promoted))
}
# KPI and awards won shows good results of Linearity

#-------------------------------------------------------------------------------------------------
# Try linear model with KPI and awards won and avg_traininf_score
model <- lm(Mydata$is_promoted ~ Mydata$KPIs_met..80. + Mydata$awards_won. + Mydata$avg_training_score)
print(model)
summary(model)
#-------------------------------------------------------------------------------------------------
library(corrplot)
correlations <- cor(Mydata[,10:14])
print (correlations)
jpeg("../../figures/multiple/correlations.png", width = 720, height = 720)
corrplot(correlations, method="circle")
dev.off()
#-------------------------------------------------------------------------------------------------


