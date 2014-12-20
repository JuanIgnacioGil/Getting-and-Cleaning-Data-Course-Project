#Download and unzip the data if neccessary
if (!file.exists("UCI HAR Dataset")){
  library(downloader)
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download(url, "dataset.zip", mode="wb")
  unzip("dataset.zip")
  unlink(url)
}

#Reading features.txt and creating a col.names vector for the X data
feature_raw<-read.table("UCI HAR Dataset/features.txt")
feature_names<-make.names(feature_raw$V2,unique = TRUE)

#Loading train set
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt",col.names="subject")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt",col.names=feature_names)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt",col.names="activity")

#Loading test set
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt",col.names="subject")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt",col.names=feature_names)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt",col.names="activity")

#Merge test and train sets into a unique dataframe
subject<-rbind(subject_test,subject_train)
X<-rbind(X_test,X_train)
y<-rbind(y_test,y_train)

#Extracts only the measurements on the mean and standard deviation 
#for each measurement. 
X2<-X[,grep("\\.mean\\.|\\.std\\.", names(X), value=TRUE)]

#Create a unique dataset
data_raw<-cbind(subject,y,X2)

#Uses descriptive activity names to name the activities in the data set
#Read file activity_labels.txt
activities<-read.table("UCI HAR Dataset/activity_labels.txt")
data_tidy<-merge(data_raw, activities, by.x="activity", by.y="V1")
data_tidy$activity <- NULL
names(data_tidy)[names(data_tidy) == "V2"] <- "activity"

#Appropriately labels the data set with descriptive variable names. 

#Delete points at the end of the name
names(data_tidy)<-gsub("\\.+$","",names(data_tidy))

#Replace points by spaces
names(data_tidy)<-gsub("\\.+"," ",names(data_tidy))

#From the data set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.
library(dplyr)
data_tidy %>% 
  group_by(subject,activity) %>%
  summarise_each(funs(mean)) %>%
  as.data.frame(t()) -> VariableMeans

write.table(VariableMeans,file="VariableMeans.txt",row.name=FALSE) 

#Remove unnecessary variables
rm(activities,feature_raw,subject,subject_test,X,X_test)
rm(X_train,X2,y,y_test,y_train,subject_train,feature_names)

