###############################################################################################################
#####                                                   IMPORTANT:                                        #####
#####                                Document created by Fernando Barranco Rodríguez                      #####
#####                            Data Science Specialization (Getting and Cleaning Data)                  #####
#####                                        Coursera - Johns Hopkins University                          #####
#####                                                 Course Project                                      #####
###############################################################################################################

# Note: The code was written on Linux Ubuntu 16.04 x64bits, R version 3.4.1 -- "Single Candle"

# Personal directory where libraries are located
lib <- "/home/fernando_barranco/R/x86_64-pc-linux-gnu-library/3.4"  # Change if necessary

# Load the following packages 
library("data.table", lib = lib)
library("reshape2", lib = lib)

# Set working directory and download data
setwd("~/Escritorio")  # Change if necessary
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url = url, destfile = "~/Escritorio/samsung.zip")  # Change if necessary
unzip("~/Escritorio/samsung.zip")  # Change if necessary

# Paths where data is stored
path.UCI <- "~/Escritorio/UCI HAR Dataset/"  # Change if necessary
path.train <- "~/Escritorio/UCI HAR Dataset/train/"  # Change if necessary
path.test <- "~/Escritorio/UCI HAR Dataset/test/"  # Change if necessary

# Reading data into R 
activity.labels <- fread(paste0(path.UCI, "activity_labels.txt"), col.names = c("id_activity", "activity"))
features <- fread(paste0(path.UCI, "features.txt"), col.names = c("id", "feature"))

x.train <- fread(paste0(path.train, "X_train.txt"), col.names = features$feature)
y.train <- fread(paste0(path.train, "y_train.txt"), col.names = "id_activity")
subject.train <- fread(paste0(path.train, "subject_train.txt"), col.names = "id_subject")
data.train <- cbind(x.train, y.train, subject.train)

x.test <- fread(paste0(path.test, "X_test.txt"), col.names = features$feature)
y.test <- fread(paste0(path.test, "y_test.txt"), col.names = "id_activity")
subject.test <- fread(paste0(path.test, "subject_test.txt"), col.names = "id_subject")
data.test <- cbind(x.test, y.test, subject.test)

# Merge the training and the test sets to create one data set
data.merged <- rbind(data.train, data.test)

# Extracts only the measurements on the mean and standard deviation for each measurement
index <- c(grep("(mean|std)\\(\\)", features$feature), 562, 563)
data.measure <- data.merged[ , index, with = F]

# Uses descriptive activity names to name the activities in the data set
data.measure$id_activity <- factor(x = data.measure$id_activity, levels = activity.labels$id_activity,
                                   labels = tolower(activity.labels$activity))
data.measure$id_subject <- as.factor(x = data.measure$id_subject)

# Appropriately labels the data set with descriptive variable names
colnames(data.measure) <- gsub("[()]", "", colnames(data.measure))
colnames(data.measure) <- gsub("-", "_", colnames(data.measure))

# Creates an independent tidy data set with the average of each variable for each activity and each subject
tidy.data <- reshape2::melt(data = data.measure, id = c("id_subject", "id_activity"))
tidy.data <- reshape2::dcast(data = tidy.data, id_subject + id_activity ~ variable, fun.aggregate = mean)
View(tidy.data)

# Creates text file containing the tidy data set
write.table(tidy.data, file = "tidydata.txt", row.names = F)

