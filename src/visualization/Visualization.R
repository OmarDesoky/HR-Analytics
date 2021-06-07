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
  dir.create("../../figures/barplot/portion/")
}
Mydata <- read.csv("../../data/train_data.csv",header=TRUE,sep=",")

show_main_info <- function()
{
  str(Mydata)
  head(Mydata)
  summary(Mydata)
}

factor_feature<- function(feat){
  fct<-factor(feat)
  print(levels(fct))
  print(nlevels(fct))
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

# getting first 10 rows of data
# getting summary statistics of data
show_main_info()
#-------------------------------------------------------------------------------------------------
# showing levels of gender
# checking if there is a missing data in gender field
factor_feature(Mydata$gender)
#-------------------------------------------------------------------------------------------------
# showing levels of education
# checking if there is a missing data in education field
factor_feature(Mydata$education)
#-------------------------------------------------------------------------------------------------
# showing levels of recruitment_channel
# checking if there is a missing data in recruitment_channel field
factor_feature(Mydata$recruitment_channel)
#-------------------------------------------------------------------------------------------------
# showing levels of region
# checking if there is a missing data in region field
factor_feature(Mydata$region)
#-------------------------------------------------------------------------------------------------  
# showing levels of department
# checking if there is a missing data in department field
factor_feature(Mydata$department)



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
# showing how many males/females were (NOT)promoted
title <- "gender_promotion"
barplot_feature(Mydata$gender, title)
#-------------------------------------------------------------------------------------------------
# showing how many employees from different education level were (NOT)promoted
title <- "education_promotion"
barplot_feature(Mydata$education, title)
#-------------------------------------------------------------------------------------------------
# checking if there is a missing data in no_of_training field (if so we should add 0 in NA)
anyNA(Mydata$no_of_trainings)
# showing how many employees with different no of training were (NOT)promoted.
title <- "training_promotion"
barplot_feature(Mydata$no_of_trainings, title)
#-------------------------------------------------------------------------------------------------
# showing how many employees from different ages level were (NOT)promoted
title <- "age_promotion"
barplot_feature(Mydata$age, title)
#-------------------------------------------------------------------------------------------------
# checking if there is a missing data in awards_won field (if so we should add 0 in NA)
anyNA(Mydata$awards_won)
# showing how many employees with awards won were (NOT)promoted.
title <- "awards_promotion"
barplot_feature(Mydata$awards_won, title)
#-------------------------------------------------------------------------------------------------
# checking if there is a missing data in avg_training_score field (if so we should add 0 in NA)
anyNA(Mydata$avg_training_score)
# showing how many employees with different avg_training_score were (NOT)promoted.
title <- "training_promotion"
barplot_feature(Mydata$avg_training_score, title)
#-------------------------------------------------------------------------------------------------
# checking if there is a missing data in length_of_service field (if so we should add 0 in NA)
anyNA(Mydata$length_of_service)
# showing how many employees with different ours of training were (NOT)promoted.
title <- "service_promotion"
barplot_feature(Mydata$length_of_service, title)
#-------------------------------------------------------------------------------------------------
# showing how many employees at different regions were (NOT)promoted.
title <- "region_promotion"
barplot_feature(Mydata$region, title)
#-------------------------------------------------------------------------------------------------
# showing how many employees at different departments were (NOT)promoted.
title <- "department_promotion"
barplot_feature(Mydata$department, title)
#-------------------------------------------------------------------------------------------------
# showing how many employees at different recruitment channels were (NOT)promoted.
title <- "rec_channels_promotion"
barplot_feature(Mydata$recruitment_channel, title)
#-------------------------------------------------------------------------------------------------
# showing how many employees at different no. of trainings were (NOT)promoted.
title <- "no_trainings_promotion"
barplot_feature(Mydata$no_of_trainings, title)
#-------------------------------------------------------------------------------------------------



#-------------------------------------------------------------------------------------------------
# show histogram of features
title <- "no_of_trainings"
histogram_feature(Mydata$no_of_trainings, title)
#-------------------------------------------------------------------------------------------------
# show histogram of features
title <- "age"
histogram_feature(Mydata$age, title)
#-------------------------------------------------------------------------------------------------
# show histogram of features
title <- "previous_year_rating"
histogram_feature(Mydata$previous_year_rating, title)
#-------------------------------------------------------------------------------------------------
# show histogram of features
title <- "length_of_service"
histogram_feature(Mydata$length_of_service, title)
#-------------------------------------------------------------------------------------------------
# show histogram of features
#title <- "KPIs_met..80."
#histogram_feature(Mydata$KPIs_met..80. , title)
#-------------------------------------------------------------------------------------------------
# show histogram of features
#title <- "awards_won."
#histogram_feature(Mydata$awards_won., title)
#-------------------------------------------------------------------------------------------------
# show histogram of features
title <- "avg_training_score"
histogram_feature(Mydata$avg_training_score, title)
#-------------------------------------------------------------------------------------------------
