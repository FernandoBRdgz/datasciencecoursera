###########################################################################################
###                                     IMPORTANT:                                      ###
###                  Document created by Fernando Barranco Rodríguez                    ###
###              Data Science Specialization (Exploratory Data Analysis)                ###
###                        Coursera - Johns Hopkins University                          ###
###########################################################################################

# Course Project 1

# Plot 1 

lib <- "/home/fernando_barranco/R/x86_64-pc-linux-gnu-library/3.4"

library("data.table", lib = lib)

setwd("~/Escritorio")
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url = url, destfile = "~/Escritorio/Household_power_consumption.zip")
unzip("~/Escritorio/Household_power_consumption.zip")

col.names <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage",
               "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
HPC <- fread("~/Escritorio/household_power_consumption.txt", na.strings = '?', skip = 66637,
             nrows = 2880, col.names = col.names)
HPC$Date_time <- paste(HPC$Date, HPC$Time)
HPC$Date_time <- as.POSIXct(HPC$Date_time, format = "%d/%m/%Y %H:%M:%S")

png("plot1.png", width = 480, height = 480, bg = "transparent")
hist(HPC$Global_active_power, xlab = "Global Active Power (kilowatts)", ylim = c(0,1200),
     main = "Global Active Power", col = "red")
dev.off()
