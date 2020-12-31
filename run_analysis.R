## Assignment for Cleaning Data
## Phil Renner

#install.packages("dplyr")
library(dplyr)

# get the source file, download as wearables.zip
if (!file.exists("wearables.zip")){
       fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
       download.file(fileURL, "wearables.zip", method="curl")
}

#unzip into wearable_dataset
if (!file.exists("UCI HAR Dataset")) { 
  unzip("wearables.zip") 
}


#which subject for each row in test/train
testsubject <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = c("subject"))
trainsubject <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = c("subject"))

#variable names in test/train, and activity names
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("num", "feature"))
activity <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

#which activity for each row in test/train data
testactivity <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = c("activity_code"))
trainactivity <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = c("activity_code"))

#read the test data set, and add variable names(features)
xtest <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$feature)
xtrain <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$feature)

#merge test and training data sets
allx <- rbind(xtest, xtrain)
allactivity <- rbind(testactivity, trainactivity)
allsubject <- rbind(testsubject, trainsubject)


#merge subject numbers, activity codes, and wearable data
all_data <- cbind(allsubject, allactivity, allx)

#create data frame mean_sd with only mean and stdev columns
mean_sd <- all_data %>% select(subject, activity_code, contains("mean"), contains("std"))

#recode activity code numbers with descriptive activity name
mean_sd$activity_code <- activity[mean_sd$activity_code, 2]
names(mean_sd)[2] = "activity"

#make the variable names more readable/meaningful
names(mean_sd) <- gsub("^t","time",names(mean_sd))
names(mean_sd) <- gsub("Acc","accelerometer",names(mean_sd))
names(mean_sd) <- gsub("Gyro","gyroscope",names(mean_sd))
names(mean_sd) <- gsub("Mag","magnitude",names(mean_sd))
names(mean_sd) <- gsub("^f","frequency",names(mean_sd))
names(mean_sd) <- gsub("BodyBody","Body",names(mean_sd))
names(mean_sd) <- gsub("tBody","timeBody",names(mean_sd))
names(mean_sd) <- gsub("std","StDev",names(mean_sd))

#create a summary table with mean of each variable, grouped by subject and activity
summarydata <- mean_sd %>% group_by(subject, activity) %>% summarise_all(funs(mean))

#write the final summary data table to a txt file
write.table(summarydata, "summarydata.txt", row.names = FALSE)

