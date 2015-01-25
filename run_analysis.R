#############################################################################################
# Zulinette Rodriguez Colon
# Getting and Cleaning Data Course Project
#
# You should create one R script called run_analysis.R that does the following. 
#  1- Merges the training and the test sets to create one data set.
#  2- Extracts only the measurements on the mean and standard deviation for each measurement. 
#  3- Uses descriptive activity names to name the activities in the data set
#  4- Appropriately labels the data set with descriptive variable names. 
# From the data set in step 4, creates a second, independent tidy data set with the average 
# of each variable for each activity and each subject.
#############################################################################################
#setwd("~/R/")
require(data.table)

if(!file.exists("./Project_Data")){dir.create("./Project_Data")}

#Download, save and unzip dataset
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./Project_Data/dataset.zip")
unzip(zipfile="./Project_Data/dataset.zip", exdir="./Project_Data")

#Loading dataset
activityData<-read.table("./Project_Data/UCI HAR Dataset/activity_labels.txt")
featuresData<-read.table("./Project_Data/UCI HAR Dataset/features.txt", stringsAsFactors=FALSE)

xTrainData<-read.table("./Project_Data/UCI HAR Dataset/train/X_train.txt")
yTrainData<-read.table("./Project_Data/UCI HAR Dataset/train/Y_train.txt", col.names="Activity_ID")
subjectTrainData<-read.table("./Project_Data/UCI HAR Dataset/train/subject_train.txt", col.names="Subject_ID")

xTestData<-read.table("./Project_Data/UCI HAR Dataset/test/X_test.txt")
yTestData<-read.table("./Project_Data/UCI HAR Dataset/test/Y_test.txt", col.names="Activity_ID")
subjectTestData<-read.table("./Project_Data/UCI HAR Dataset/test/subject_test.txt", col.names="Subject_ID")

#############################################################################################
# Step 1
# Merges the training and the test sets to create one data set.

#Merging train data in trainDF df
names(xTrainData)<-featuresData$V2
trainDF<-cbind(xTrainData, yTrainData, subjectTrainData)

#Merging test data testDF df
names(xTestData)<-featuresData$V2
testDF<-cbind(xTestData, yTestData, subjectTestData)

#Merging train data with test data
mergeTrainTestData<-rbind(trainDF, testDF)


#############################################################################################
# Step 2
# Extracts only the measurements on the mean and standard deviation for each measurement. 

#Selecting columns and creating new DF
columns<-grep("mean\\(\\)|std\\(\\)", names(mergeTrainTestData), ignore.case =TRUE, value=TRUE)
finalDF<-mergeTrainTestData[c(columns, "Subject_ID", "Activity_ID")]

#############################################################################################
# Step 3
# Uses descriptive activity names to name the activities in the data set
finalDF$Activity_Name<-activityData[finalDF[,"Activity_ID"], 2]

#############################################################################################
# Step 4
# Appropriately labels the data set with descriptive variable names. 
names(finalDF)<-gsub("^t", "time", names(finalDF))
names(finalDF)<-gsub("^f", "frequency", names(finalDF))
names(finalDF)<-gsub("Acc", "Accelerometer", names(finalDF))
names(finalDF)<-gsub("Gyro", "Gyroscope", names(finalDF))
names(finalDF)<-gsub("Mag", "Magnitude", names(finalDF))
names(finalDF)<-gsub("BodyBody", "Body", names(finalDF))

#############################################################################################
# Step 5
# From the data set in step 4, creates a second, independent tidy data set with the average 
# of each variable for each activity and each subject.

tidyData = aggregate(finalDF[,1:66], by=list(Subject_ID=finalDF$Subject_ID, 
                                         Activity_Name=finalDF$Activity_Name), mean)
# Created an externat file with the tidyData set 
write.table(tidyData, "./Project_Data/tidyData.txt",row.names=FALSE)
