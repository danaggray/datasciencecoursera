# Getting and Cleaning Data #

Files in this repository

README.md : this file

Codebook.md : a brief description of the data set,  variables, and data transformations


run_analysis.R : an r script to download and process raw data in the working directory and return a tidy data set. Per these instructions -

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The run_analysis.R script requires plyr package is installed. The script will pull the necessary zipped raw data set, create the "UCI HAR Dataset" directory with all raw data files inside the working directory and will output the Tidy data set as a txt file "tidydata.txt" into the "UCI HAR Dataset" directory.
