###########################################################################################
###                                     IMPORTANT:                                      ###
###                  Document created by Fernando Barranco Rodríguez                    ###
###              Data Science Specialization (Exploratory Data Analysis)                ###
###                        Coursera - Johns Hopkins University                          ###
###########################################################################################

# Course Project 2

# Plot 2

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make
# a plot answering this question.

# Set working directory (in my case will be the Desktop)
setwd("~/Escritorio")
lib <- "/home/fernando_barranco/R/x86_64-pc-linux-gnu-library/3.4"

# Libraries requiered
library("dplyr", lib = lib)

# Download and unzip the dataset (in case you don't have it)
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url = url, destfile = "~/Escritorio/data.zip")
unzip("~/Escritorio/data.zip")

# Read the data into R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset the data
NEI.sub <- NEI %>% filter(fips == "24510")

# Now we're ready to plot
png("plot2.png", width = 480, height = 480, bg = "transparent")
barplot(tapply(NEI.sub$Emissions, NEI.sub$year, sum), col = rgb(0.2, 0.5, 0.6),
        ylab = expression("Total Emissions of PM"[2.5]), xlab = "Years",
        main = "Emissions over Years in Baltimore City, Maryland")
dev.off()

