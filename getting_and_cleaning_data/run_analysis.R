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
# read the data into data frames...with consistent lowercase names despite their convention (...why cap X and lower y?)

x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)

# Read the labels into data frame
features <- read.table("./UCI HAR Dataset/features.txt")

# Per instructions we are only concerned with the mean and standard deviation for each measurement.
extractedfeatures <- grepl("mean|std", features)



# Stack the data with rbind
xData <- rbind(x_train, X_test)
yData <- rbind(y_train, y_test)
subjectData <- rbind(subject_train, subject_test)








