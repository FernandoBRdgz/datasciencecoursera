###########################################################################################
###                                     IMPORTANT:                                      ###
###                  Document created by Fernando Barranco Rodríguez                    ###
###              Data Science Specialization (Getting and Cleaning Data)                ###
###                        Coursera - Johns Hopkins University                          ###
###########################################################################################

# QUIZ 4

lib <- "/home/fernando_barranco/R/x86_64-pc-linux-gnu-library/3.4"

# 1st Q.

library("data.table", lib = lib)

url1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url = url1, destfile = "~/Escritorio/community.csv")
community <- fread("~/Escritorio/community.csv")
strsplit(names(community), "wgtp")[[123]]

# 2nd Q.

url2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(url = url2, destfile = "~/Escritorio/GDP.csv")
col.names <- c("id", "ranking", "economy", "dollars")
GDP <- fread("~/Escritorio/GDP.csv", select = c(1,2,4,5), skip = 4,
             col.names = col.names, nrows = 190)
GDP$dollars <- gsub(",", "", GDP$dollars)
GDP$dollars <- as.numeric(GDP$dollars)
mean(GDP$dollars)

# 3rd Q.

sum(grepl("^United", GDP$economy))

# 4th Q.

url4 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(url = url4, destfile = "~/Escritorio/Edu.csv")
Educational <- fread("~/Escritorio/Edu.csv", select = c(1,10), 
                     col.names = c("id", "notes"))
GDP.Edu <- merge(GDP, Educational, by = "id")
sum(grepl("^Fiscal year end: June", GDP.Edu$notes))

# 5th Q.

library("quantmod", lib = lib)
library("data.table", lib = lib)
library("lubridate", lib = lib)

amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
time <- data.table(sampleTimes)
time.2012 <- time[year(time$sampleTimes) == 2012, ]; nrow(time.2012)
time.2012.mon <- time.2012[wday(time.2012$sampleTimes) == 2, ]; nrow(time.2012.mon)
