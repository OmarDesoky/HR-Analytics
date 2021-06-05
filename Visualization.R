rm(list=ls())
Mydata <- read.csv("data.csv",header=TRUE,sep=",")

# getting first 10 rows of data
head(Mydata)
# getting summary statistics of data
summary(Mydata)
#-------------------------------------------------------------------------------------------------
# showing levels of gender
# checking if there is a missing data in gender field
fct<-factor(Mydata$gender)
levels(fct)
nlevels(fct)
anyNA(Mydata$gender)
#-------------------------------------------------------------------------------------------------
# showing levels of education
# checking if there is a missing data in education field
fct<-factor(Mydata$education)
levels(fct)
nlevels(fct)
anyNA(Mydata$education)
#-------------------------------------------------------------------------------------------------
# showing levels of recruitment_channel
# checking if there is a missing data in recruitment_channel field
fct<-factor(Mydata$recruitment_channel)
levels(fct)
nlevels(fct)
anyNA(Mydata$recruitment_channel)
#-------------------------------------------------------------------------------------------------
# showing levels of region
# checking if there is a missing data in region field
fct<-factor(Mydata$region)
levels(fct)
nlevels(fct)
anyNA(Mydata$region)
#-------------------------------------------------------------------------------------------------  
# showing levels of department
# checking if there is a missing data in department field
fct<-factor(Mydata$department)
levels(fct)
nlevels(fct)
anyNA(Mydata$department)
#-------------------------------------------------------------------------------------------------
# showing percentage of how many employees are males and how many are females
table_gender<- table(Mydata$gender)
table_gender
lbls <- c("female","male")
colors <- c("red","blue")
precentage <- round(table_gender/sum(table_gender)*100)
precentage
lbls <- paste(lbls, precentage)
lbls <- paste(lbls,"%",sep="")
pie(table_gender,labels=lbls,col=colors)
#-------------------------------------------------------------------------------------------------
# showing percentage of how many employees from different education level
table_education<- table(Mydata$education)
table_education
lbls <- c("None","Bachelor's","Below Secondary","Master's & above")
colors <- c("grey","red","blue","green")
precentage <- round(table_education/sum(table_education)*100,1)
precentage
lbls <- paste(lbls, precentage)
lbls <- paste(lbls,"%",sep="")
pie(table_education,labels=lbls,col=colors)
#-------------------------------------------------------------------------------------------------
# showing percentage of how many employees from different department
table_department<- table(Mydata$department)
table_department
lbls <- c("Analytics","Finance","HR","Legal","Operations","Procurement","R&D","Sales & Marketing","Technology ")
precentage <- round(table_department/sum(table_department)*100,1)
precentage
lbls <- paste(lbls, precentage)
lbls <- paste(lbls,"%",sep="")
pie(table_department,labels=lbls)
#-------------------------------------------------------------------------------------------------
# showing percentage of how many employees came from different recruitment channels
table_recruitment_channel<- table(Mydata$recruitment_channel)
table_recruitment_channel
lbls <- c("other","referred","sourcing")
colors <- c("red","blue","green")
precentage <- round(table_recruitment_channel/sum(table_recruitment_channel)*100,1)
precentage
lbls <- paste(lbls, precentage)
lbls <- paste(lbls,"%",sep="")
pie(table_recruitment_channel,labels=lbls,col=colors)
#-------------------------------------------------------------------------------------------------
# showing how many males/females were (NOT)promoted
table_gender_isprom<- table(Mydata$is_promoted,Mydata$gender)
table_gender_isprom
barplot(table_gender_isprom,ylab="number of employees", col=c("red","green") )
legend("topleft", legend = c("NOT promoted", "promoted"), fill = c("red", "Green"))
#-------------------------------------------------------------------------------------------------
# showing how many employees from different education level were (NOT)promoted
table_edu_isprom<- table(Mydata$is_promoted,Mydata$education)
table_edu_isprom
barplot(table_edu_isprom,ylab="number of employees", col=c("red","green") )
legend("topright", legend = c("NOT promoted", "promoted"), fill = c("red", "Green"))
#-------------------------------------------------------------------------------------------------
# checking if there is a missing data in no_of_training field (if so we should add 0 in NA)
anyNA(Mydata$no_of_trainings)
# showing how many employees with different no of training were (NOT)promoted.
table_train_isprom<- table(Mydata$is_promoted,Mydata$no_of_trainings)
table_train_isprom
barplot(table_train_isprom,ylab="number of employees", col=c("red","green") )
legend("topright", legend = c("NOT promoted", "promoted"), fill = c("red", "Green"))
#-------------------------------------------------------------------------------------------------
# showing age histogram
hist(Mydata$age)

# showing how many employees from different ages level were (NOT)promoted
table_age_isprom<- table(Mydata$is_promoted,Mydata$age)
table_age_isprom
barplot(table_age_isprom,ylab="number of employees", col=c("red","green") )
legend("topright", legend = c("NOT promoted", "promoted"), fill = c("red", "Green"))

#-------------------------------------------------------------------------------------------------
# checking if there is a missing data in awards_won field (if so we should add 0 in NA)
anyNA(Mydata$awards_won)

# showing how many employees with awards won were (NOT)promoted.
table_award_isprom<- table(Mydata$is_promoted,Mydata$awards_won)
table_award_isprom
barplot(table_award_isprom,ylab="number of employees", col=c("red","green") )
legend("topright", legend = c("NOT promoted", "promoted"), fill = c("red", "Green"))
#-------------------------------------------------------------------------------------------------
# checking if there is a missing data in avg_training_score field (if so we should add 0 in NA)
anyNA(Mydata$avg_training_score)

# showing how many employees with different avg_training_score were (NOT)promoted.
table_tr_scr_isprom<- table(Mydata$is_promoted,Mydata$avg_training_score)
table_tr_scr_isprom
barplot(table_tr_scr_isprom,ylab="number of employees", col=c("red","green") )
legend("topright", legend = c("NOT promoted", "promoted"), fill = c("red", "Green"))
#-------------------------------------------------------------------------------------------------
# checking if there is a missing data in length_of_service field (if so we should add 0 in NA)
anyNA(Mydata$length_of_service)

# showing how many employees with different length_of_service were (NOT)promoted.
table_len_serv_isprom<- table(Mydata$is_promoted,Mydata$length_of_service)
table_len_serv_isprom
barplot(table_len_serv_isprom,ylab="number of employees", col=c("red","green") )
legend("topright", legend = c("NOT promoted", "promoted"), fill = c("red", "Green"))

#-------------------------------------------------------------------------------------------------
# checking if there is a missing data in length_of_service field (if so we should add 0 in NA)
anyNA(Mydata$length_of_service)

# showing how many employees with different no of training were (NOT)promoted.
table_len_serv_isprom<- table(Mydata$is_promoted,Mydata$length_of_service)
table_len_serv_isprom
barplot(table_len_serv_isprom,ylab="number of employees", col=c("red","green") )
legend("topright", legend = c("NOT promoted", "promoted"), fill = c("red", "Green"))
#-------------------------------------------------------------------------------------------------

##!!!!!!!!!
# showing how many employees with different no of training were (NOT)promoted.
table_region_isprom<- table(Mydata$is_promoted,Mydata$region)
table_region_isprom
barplot(table_region_isprom,ylab="number of employees", col=c("red","green") )
legend("topright", legend = c("NOT promoted", "promoted"), fill = c("red", "Green"))
#-------------------------------------------------------------------------------------------------

