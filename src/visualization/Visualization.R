rm(list=ls())
getwd()
setwd("~/Desktop/projects/big_data_prj/HR-Analytics/src/visualization")
getwd()

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

pie_feature <- function(feat, lbls, colors){
  table_values<- table(feat)
  print(table_values)
  precentage <- round(table_values/sum(table_values)*100,1)
  print(precentage)
  lbls <- paste(lbls, precentage)
  lbls <- paste(lbls,"%",sep="")
  pie(table_values,labels=lbls,col=colors)
  #save graphs
}

barplot_feature <- function(feat){
  table_gender_isprom<- table(Mydata$is_promoted,feat)
  print(table_gender_isprom)
  barplot(table_len_serv_isprom,ylab="number of employees", col=c("red","green") )
legend("topright", legend = c("NOT promoted", "promoted"), fill = c("red", "Green"))
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
pie_feature(Mydata$gender, lbls, colors)
#-------------------------------------------------------------------------------------------------
# showing percentage of how many employees from different education level
lbls <- c("None","Bachelor's","Below Secondary","Master's & above")
colors <- c("grey","red","blue","green")
pie_feature(Mydata$education, lbls, colors)
#-------------------------------------------------------------------------------------------------
# showing percentage of how many employees from different department
lbls <- c("Analytics","Finance","HR","Legal","Operations","Procurement","R&D","Sales & Marketing","Technology ")
colors = NULL
pie_feature(Mydata$department, lbls, colors)
#-------------------------------------------------------------------------------------------------
# showing percentage of how many employees came from different recruitment channels
lbls <- c("other","referred","sourcing")
colors <- c("red","blue","green")
pie_feature(Mydata$recruitment_channel, lbls, colors)


#-------------------------------------------------------------------------------------------------
# showing how many males/females were (NOT)promoted
barplot_feature(Mydata$gender, ylab, colors)
#-------------------------------------------------------------------------------------------------
# showing how many employees from different education level were (NOT)promoted
barplot_feature(Mydata$education, ylab, colors)
#-------------------------------------------------------------------------------------------------
# checking if there is a missing data in no_of_training field (if so we should add 0 in NA)
anyNA(Mydata$no_of_trainings)
# showing how many employees with different no of training were (NOT)promoted.
barplot_feature(Mydata$no_of_trainings, ylab, colors)
#-------------------------------------------------------------------------------------------------
# showing age histogram
hist(Mydata$age)
# showing how many employees from different ages level were (NOT)promoted
barplot_feature(Mydata$age, ylab, colors)
#-------------------------------------------------------------------------------------------------
# checking if there is a missing data in awards_won field (if so we should add 0 in NA)
anyNA(Mydata$awards_won)
# showing how many employees with awards won were (NOT)promoted.
barplot_feature(Mydata$awards_won, ylab, colors)
#-------------------------------------------------------------------------------------------------
# checking if there is a missing data in avg_training_score field (if so we should add 0 in NA)
anyNA(Mydata$avg_training_score)
# showing how many employees with different avg_training_score were (NOT)promoted.
barplot_feature(Mydata$avg_training_score, ylab, colors)
#-------------------------------------------------------------------------------------------------
# checking if there is a missing data in length_of_service field (if so we should add 0 in NA)
anyNA(Mydata$length_of_service)
# showing how many employees with different no of training were (NOT)promoted.
barplot_feature(Mydata$length_of_service, ylab, colors)
#-------------------------------------------------------------------------------------------------
# showing how many employees with different no of training were (NOT)promoted.
barplot_feature(Mydata$region, ylab, colors)
#-------------------------------------------------------------------------------------------------

