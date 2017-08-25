# Getting and cleaning data
# Programming assignment week 4

The assignment is:

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

I followed the steps as described here. The only exception was that I integrated step 4 in an earlier step.

# Getting the data

The first step was to download the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The data was downloaded on August, 22, 2017.

Unzipping the file was done manually (not from R).

# Reading and merging the data

I read the files from the test and train directory (x, y and subject). I also read the files features and activitylabels from the root directory. 

The next step was to add the column names (step 4) from the activitylabel file to the x files and the y and subject file I added manually a column name. 

Then I merged the files within train and test. Then I merged 2 resulting files (Total_train and Total_test to Total_data).

# Extracting mean and standard deviation data
First I builded a vector with booleans to see which columns had a mean and a SD variable. When searching for the mean, I had to exclude the meanFreq variables.

Based on the vector I could select the columns I needed and saved them in Total_mean_SD_data.

# Independent dataset with the average of each variable for each activity and each subject

In this step I builded a new dataset Tidyset with the meand of the individual column values grouped by the activity and within the activity grouped by the subject (the individual). 
