###########################################################################################
###                                     IMPORTANT:                                      ###
###                  Document created by Fernando Barranco Rodríguez                    ###
###              Data Science Specialization (Exploratory Data Analysis)                ###
###                        Coursera - Johns Hopkins University                          ###
###########################################################################################

# Course Project 1

# Plot 3

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

png("plot3.png", width = 480, height = 480, bg = "transparent")
par(mar = c(3,4,1,1))
plot(HPC$Date_time, HPC$Sub_metering_1, ylab = "Energy sub metering",
     xlab = "", type = "l", xaxt = "n")
lines(HPC$Date_time, HPC$Sub_metering_2, col = "red")
lines(HPC$Date_time, HPC$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, 
       col = c("black", "red", "blue"), cex = 0.9, y.intersp = 0.9)
axis(1, at = c(HPC$Date_time[1], HPC$Date_time[1440], HPC$Date_time[2880]), labels = c("Thu", "Fri", "Sat"))
dev.off()
