# 005 Reproducible Research

## Author: Fernando Barranco Rodríguez

#### Reproducible Research Course Project 1

Introduction

It is now possible to collect a large amount of data about personal movement using activity monitoring devices such as a 'Fitbit', 'Nike Fuelband', or 'Jawbone Up'. These type of devices are part of the “quantified self” movement – a group of enthusiasts who take measurements about themselves regularly to improve their health, to find patterns in their behavior, or because they are tech geeks. But these data remain under-utilized both because the raw data are hard to obtain and there is a lack of statistical methods and software for processing and interpreting the data.

This assignment makes use of data from a personal activity monitoring device. This device collects data at 5 minute intervals through out the day. The data consists of two months of data from an anonymous individual collected during the months of October and November, 2012 and include the number of steps taken in 5 minute intervals each day.

The data for this assignment can be downloaded from the course web site:

* Dataset: [Activity monitoring data](https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip) (52K)

The variables included in this dataset are:

* **steps**: Number of steps taking in a 5-minute interval (missing values are coded as NA)

* **date**: The date on which the measurement was taken in YYYY-MM-DD format

* **interval**: Identifier for the 5-minute interval in which measurement was taken

The dataset is stored in a comma-separated-value (CSV) file and there are a total of 17,568 observations in this dataset.

**Commit containing full submission**

1. Code for reading in the dataset and/or processing the data

```
library("data.table")
activity <- fread("~/Escritorio/activity.csv", na.strings = "NA")
```

2. Histogram of the total number of steps taken each day

```
x <- aggregate(steps ~ date, activity, sum)
hist(x$steps, xlab = "Number of Steps", main = "Total number of steps taken each day",
     col = "steelblue", breaks = 10)
```

![plot of plot1](figures/plot1.png)

3. Mean and median number of steps taken each day

```
mean.unimputed <- mean(x$steps, na.rm = T)
median.unimputed <- median(x$steps, na.rm = T)
```

4. Time series plot of the average number of steps taken

```
t <- aggregate(steps ~ interval, activity, mean)
with(t, plot(interval, steps, type = "l", xlab = "Interval", ylab = "Steps", 
             main = "Average number of steps taken across all days", col = "steelblue", lwd = 2))
```

![plot of plot2](figures/plot2.png)

5. The 5-minute interval that, on average, contains the maximum number of steps

```
t[which(t$steps == max(t$steps)), "interval"]
```

6. Code to describe and show a strategy for imputing missing data

```
library("impute", lib = lib)
lapply(lapply(activity, is.na), sum)
```

```
activity.imputed <- copy(activity)
activity.imputed <- as.data.frame(impute.knn(as.matrix(activity.imputed[ , .(steps, interval)]))$data)
activity.imputed <- cbind(activity.imputed, date = activity$date)
```

```
h <- aggregate(steps ~ date, activity.imputed, sum)
mean.imputed <- mean(h$steps)
median.imputed <- median(h$steps)
```

```
mean.unimputed - mean.imputed
median.unimputed - median.imputed
```

7. Histogram of the total number of steps taken each day after missing values are imputed

```
hist(h$steps, xlab = "Number of Steps", main = "Total number of steps taken each day (after imputation)",
     col = "steelblue", breaks = 10)
```

![plot of plot3](figures/plot3.png)

8. Panel plot comparing the average number of steps taken per 5-minute interval across weekdays and weekends

```
library("lubridate")
dates <- as.Date(activity.imputed$date)
weekdays <- wday(dates, label = T)
activity.imputed <- cbind(activity.imputed, weekdays)
weekday <- subset(activity.imputed, weekdays != "Sat" & weekdays != "Sun")
weekend <- subset(activity.imputed, weekdays == "Sat" | weekdays == "Sun")
wdy <- aggregate(steps ~ interval, weekday, mean)
wnd <- aggregate(steps ~ interval, weekend, mean)
```

```
par(mfrow = c(1,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(wdy, plot(interval, steps, type = "l", xlab = "Interval", ylab = "Steps", 
             main = "Weekday", col = "steelblue", lwd = 2))
with(wnd, plot(interval, steps, type = "l", xlab = "Interval", ylab = "Steps", 
             main = "Weekend", col = "steelblue", lwd = 2))
mtext("Average number of steps taken per 5-minute interval", outer = T)
```

![plot of plot4](figures/plot4.png) 

9. All of the R code needed to reproduce the results (numbers, plots, etc.) in the report

*Please see the PA1_template.Rmd file*

