# Course Project - Gettting and cleanning data
# Course Project - Gettting and cleanning data

# run_analysis.R
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Raw data source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# For description of data see: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

# required libraries: 
library(plyr)
# Code

# download raw data, unzip and store locally
# Set working directory to current source file directory
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)

# Raw data URI
rawdataURI <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
rawdataZipFile <- "./getdata-projectfiles-UCI-HAR-Dataset.zip"

# Download zip file (if it isn't present in root) and unzip
if (file.exists(rawdataZipFile) == FALSE) {
  download.file(rawdataURI, destfile = rawdataZipFile)
  unzip(rawdataZipFile)
}
# Time to do the work
# read the data into data frames...with consistent camelcase names despite their convention (...why cap X and lower y?)

xTrain <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
xTest <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
yTrain <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
yTest <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
sTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
sTest <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)


# Generate activity labels 
activities<-read.table("./UCI HAR Dataset/activity_labels.txt",col.names = c("Id", "Activity"))

# Generate features labels
features<-read.table("./UCI HAR Dataset/features.txt",colClasses = c("character"))

# Stack all the data
traindf<-cbind(cbind(xTrain, sTrain), yTrain)
testdf<-cbind(cbind(xTest, sTest), yTest)
mergeddf<-rbind(traindf, testdf)

colLabels<-rbind(rbind(features, c(562, "Subject")), c(563, "Id"))[,2]
names(mergeddf)<-colLabels

# Only the measurements on the mean and standard deviation for each measurement.
subMergeddf <- mergeddf[,grepl("mean\\(\\)|std\\(\\)|Subject|Id", names(mergeddf))]

# Descriptive names
subMergeddf <- join(subMergeddf, activities, by = "Id", match = "first")
subMergeddf <- subMergeddf[,-1]
names(subMergeddf) <- gsub("([()])","",names(subMergeddf))
names(subMergeddf) <- make.names(names(subMergeddf))

# Tidy data
tidydf<-ddply(subMergeddf, c("Subject","Activity"), numcolwise(mean))

# Output data
write.table(tidydf, file = "./UCI HAR Dataset/tidydata.txt", row.name=FALSE)
