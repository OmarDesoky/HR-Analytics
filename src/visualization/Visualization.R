rm(list=ls())
getwd()
setwd("~/Desktop/projects/big_data_prj/HR-Analytics/src/visualization")
getwd()

if (!dir.exists("../../figures"))
{
  dir.create("../../figures")
  dir.create("../../figures/pie")
  dir.create("../../figures/barplot")
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

pie_feature <- function(feat, lbls, colors, title){
  save_fig = paste("../../figures/pie/" , title, ".jpg",sep="")
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
  save_fig = paste("../../figures/barplot/" , title, ".jpg",sep="")
  jpeg(save_fig, width = 720, height = 720)
  table_promo_feat<- table(Mydata$is_promoted,feat)
  print(table_promo_feat)
  barplot(table_promo_feat ,ylab="number of employees", col=c("red","green") , main=title)
  legend("topright", legend = c("NOT promoted", "promoted"), fill = c("red", "Green"))
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
# showing age histogram
hist(Mydata$age)
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

