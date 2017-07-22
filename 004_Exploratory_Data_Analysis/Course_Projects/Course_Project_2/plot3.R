###########################################################################################
###                                     IMPORTANT:                                      ###
###                  Document created by Fernando Barranco Rodríguez                    ###
###              Data Science Specialization (Exploratory Data Analysis)                ###
###                        Coursera - Johns Hopkins University                          ###
###########################################################################################

# Course Project 2

# Plot 3

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad)
# variable, which of these four sources have seen decreases in emissions from 1999–2008
# for Baltimore City? Which have seen increases in emissions from 1999–2008?
# Use the ggplot2 plotting system to make a plot answer this question.

# Set working directory (in my case will be the Desktop)
setwd("~/Escritorio")
lib <- "/home/fernando_barranco/R/x86_64-pc-linux-gnu-library/3.4"

# Libraries requiered
library("ggplot2", lib = lib)
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
png("plot3.png", width = 480, height = 480, bg = "transparent")
ggplot(data = NEI.sub, mapping = aes(x = factor(year), y = Emissions)) +
        geom_bar(aes(fill = type), stat = "identity") +
        facet_grid(. ~ type) +
        guides(fill = FALSE) +
        labs(x = "Year", y = expression("Total Emissions of PM"[2.5]), 
             title = "Emissions over years in Baltimore City by source Type") +
        theme(
        panel.background = element_rect(fill = "transparent"),
        plot.background = element_rect(fill = "transparent")
        #panel.grid.major = element_blank(),
        #panel.grid.minor = element_blank(),
        #legend.background = element_rect(fill = "transparent"),
        #legend.box.background = element_rect(fill = "transparent")
        )
dev.off()





