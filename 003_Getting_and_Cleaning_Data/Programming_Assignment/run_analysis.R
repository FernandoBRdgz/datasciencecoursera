###########################################################################################
###                                     IMPORTANT:                                      ###
###                  Document created by Fernando Barranco Rodríguez                    ###
###              Data Science Specialization (Getting and Cleaning Data)                ###
###                        Coursera - Johns Hopkins University                          ###
###########################################################################################

lib <- "/home/fernando_barranco/R/x86_64-pc-linux-gnu-library/3.4"
library("data.table", lib = lib)
library("reshape2", lib = lib)

setwd("~/Escritorio")
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url = url, destfile = "~/Escritorio/samsung.zip")
unzip("~/Escritorio/samsung.zip")

path.UCI <- "~/Escritorio/UCI HAR Dataset/"
path.train <- "~/Escritorio/UCI HAR Dataset/train/"
path.test <- "~/Escritorio/UCI HAR Dataset/test/"

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

data.merged <- rbind(data.train, data.test)

index <- c(grep("(mean|std)\\(\\)", features$feature), 562, 563)
data.measure <- data.merged[ , index, with = F]

data.measure$id_activity <- factor(x = data.measure$id_activity, levels = activity.labels$id_activity,
                                   labels = tolower(activity.labels$activity))
data.measure$id_subject <- as.factor(x = data.measure$id_subject)

colnames(data.measure) <- gsub("[()]", "", colnames(data.measure))
colnames(data.measure) <- gsub("-", "_", colnames(data.measure))

tidy.data <- reshape2::melt(data = data.measure, id = c("id_subject", "id_activity"))
tidy.data <- reshape2::dcast(data = tidy.data, id_subject + id_activity ~ variable, fun.aggregate = mean)
View(tidy.data)

fwrite(x = tidy.data, file = "TidyData.txt")

