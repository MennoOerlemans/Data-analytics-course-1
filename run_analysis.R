#You should create one R script called run_analysis.R that does the following.

#  1. Merges the training and the test sets to create one data set.
#  2. Extracts only the measurements on the mean and standard deviation for each measurement.
#  3. Uses descriptive activity names to name the activities in the data set
#  4. Appropriately labels the data set with descriptive variable names.
#  5. From the data set in step 4, creates a second, independent tidy data set with the average of 
#     each variable for each activity and each subject.

#Reading the files

getwd()
setwd("~/R")

Get_URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(URL_file, "~/R/Dataset.zip")
list.files("~/R")
DateDownloaded <- date()
DateDownloaded

# Unzipping is done outside of R

#  Step 1. Merges the training and the test sets to create one data set:
#      a. Loading the files into R
#      b. Adding colnames to the files
#      c. Merge the datasets into Total_data

# loading the files into R

x_test <- read.table("file:///C:/Users/menno_000/Documents/R/UCI HAR Dataset/test/x_test.txt", header = FALSE)
y_test <- read.table("file:///C:/Users/menno_000/Documents/R/UCI HAR Dataset/test/y_test.txt", header = FALSE)
subject_test <- read.table("file:///C:/Users/menno_000/Documents/R/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
x_train <- read.table("file:///C:/Users/menno_000/Documents/R/UCI HAR Dataset/train/x_train.txt", header = FALSE)
y_train <- read.table("file:///C:/Users/menno_000/Documents/R/UCI HAR Dataset/train/y_train.txt", header = FALSE)
subject_train <- read.table("file:///C:/Users/menno_000/Documents/R/UCI HAR Dataset/train/subject_train.txt", header = FALSE)


features <- read.table("file:///C:/Users/menno_000/Documents/R/UCI HAR Dataset/features.txt", header = FALSE)
activity_labels <- read.table("file:///C:/Users/menno_000/Documents/R/UCI HAR Dataset/activity_labels.txt", header = FALSE)

# Adding colnames to the tables
features <- features[ , 2]
colnames(x_train) <- features
colnames(x_test) <- features

colnames(y_train) <-"activityId"
colnames(y_test) <-"activityId"
colnames(subject_train) <- "subjectId"
colnames(subject_test) <- "subjectId"

# Merging the files train and test
Total_train <- cbind(y_train, subject_train, x_train)
Total_test <- cbind(y_test, subject_test, x_test)
Total_data <- rbind(Total_test, Total_train)

#  Step 2. Extracts only the measurements on the mean and standard deviation for each measurement:
#          a. find the columns that have to be extracted
#          b. Extract the columns and place them into Total_mean_sd_data

features <- colnames(Total_data)
vector_with_mean_sd <- (grepl("activityId", features) |
                           grepl("subjectId", features) |
                           (grepl("mean()", features) & !grepl("Freq", features)) |
                           grepl("std..", features)
                         )

Total_mean_sd_data <- Total_data[ , vector_with_mean_sd]

#  3. Uses descriptive activity names to name the activities in the data set

# replace numbers in column activityId with names in activity_labels (add names and remove id)


colnames(activity_labels) <- c("activityId", "activityname")

Total_mean_sd_data <- merge(activity_labels, Total_mean_sd_data, by = "activityId")
Total_mean_sd_data <- Total_mean_sd_data[, -1]

#  4. Appropriately labels the data set with descriptive variable names.
#  This was already done in step 1b

#  5. From the data set in step 4, creates a second, independent tidy data set with the average of 
#     each variable for each activity and each subject.


Tidyset <- Total_mean_sd_data  %>%
                  group_by(activityname, subjectId) %>%
                  summarize_each(funs(mean))

write.table(Tidyset, file = "file:///C:/Users/menno_000/Documents/R/UCI HAR Dataset/tidyset.txt", row.names = FALSE, col.names = TRUE)
