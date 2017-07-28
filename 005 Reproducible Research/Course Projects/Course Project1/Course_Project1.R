###########################################################################################
###                                     IMPORTANT:                                      ###
###                  Document created by Fernando Barranco Rodríguez                    ###
###              Data Science Specialization (Exploratory Data Analysis)                ###
###                        Coursera - Johns Hopkins University                          ###
###########################################################################################

# Course Project 1

# Set working directory (in my case will be the Desktop)
setwd("C:/Users/FernandoBarranco/Desktop")

# Download and unzip the dataset (in case you don't have it)
url <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
download.file(url = url, destfile = "C:/Users/FernandoBarranco/Desktop/activity.zip")
unzip("C:/Users/FernandoBarranco/Desktop/activity.zip")

# Load required libraries
library("data.table")
library("impute")
library("lubridate")

# 1. Code for reading in the dataset and/or processing the data
activity <- fread("C:/Users/FernandoBarranco/Desktop/activity.csv", na.strings = "NA")

# 2. Histogram of the total number of steps taken each day
x <- aggregate(steps ~ date, activity, sum)
hist(x$steps, xlab = "Number of Steps", main = "Total number of steps taken each day",
     col = "steelblue", breaks = 10)

# 3. Mean and median number of steps taken each day
mean.unimputed <- mean(x$steps, na.rm = T)
mean.unimputed
median.unimputed <- median(x$steps, na.rm = T)
median.unimputed

# 4. Time series plot of the average number of steps taken
t <- aggregate(steps ~ interval, activity, mean)
with(t, plot(interval, steps, type = "l", xlab = "Interval", ylab = "Steps", 
             main = "Average number of steps taken across all days", col = "steelblue", lwd = 2))

# 5. The 5-minute interval that, on average, contains the maximum number of steps
t[which(t$steps == max(t$steps)), "interval"]

# 6. Code to describe and show a strategy for imputing missing data
lapply(lapply(activity, is.na), sum)

activity.imputed <- copy(activity)
activity.imputed <- as.data.frame(impute.knn(as.matrix(activity.imputed[ , .(steps, interval)]))$data)
activity.imputed <- cbind(activity.imputed, date = activity$date)

h <- aggregate(steps ~ date, activity.imputed, sum)
mean.imputed <- mean(h$steps)
mean.imputed
median.imputed <- median(h$steps)
median.imputed

mean.unimputed - mean.imputed
median.unimputed - median.imputed

# 7. Histogram of the total number of steps taken each day after missing values are imputed
hist(h$steps, xlab = "Number of Steps", main = "Total number of steps taken each day (after imputation)",
     col = "steelblue", breaks = 10)

# 8. Panel plot comparing the average number of steps taken per 5-minute interval across weekdays and weekends
dates <- as.Date(activity.imputed$date)
weekdays <- wday(dates, label = T)
activity.imputed <- cbind(activity.imputed, weekdays)

weekday <- subset(activity.imputed, weekdays != "Sat" & weekdays != "Sun")
weekend <- subset(activity.imputed, weekdays == "Sat" | weekdays == "Sun")

wdy <- aggregate(steps ~ interval, weekday, mean)
wnd <- aggregate(steps ~ interval, weekend, mean)

par(mfrow = c(1,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(wdy, plot(interval, steps, type = "l", xlab = "Interval", ylab = "Steps", 
             main = "Weekday", col = "steelblue", lwd = 2))
with(wnd, plot(interval, steps, type = "l", xlab = "Interval", ylab = "Steps", 
             main = "Weekend", col = "steelblue", lwd = 2))
mtext("Average number of steps taken per 5-minute interval", outer = T)

# 9. All of the R code needed to reproduce the results (numbers, plots, etc.) in the report


