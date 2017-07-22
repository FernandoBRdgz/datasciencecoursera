###########################################################################################
###                                     IMPORTANT:                                      ###
###                  Document created by Fernando Barranco Rodríguez                    ###
###              Data Science Specialization (Exploratory Data Analysis)                ###
###                        Coursera - Johns Hopkins University                          ###
###########################################################################################

# Course Project 2

# Plot 5

# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

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
SCC.vehicle <- grepl("Vehicle", SCC$SCC.Level.Two)
SCC.sub <- SCC %>% filter(SCC.vehicle) 
SCC.scc <- SCC.sub %>% select(SCC)

# Match the data
NEI.sub <- inner_join(NEI, SCC.scc, by = "SCC")

# Filter by 'Baltimore City'
NEI.sub.balt <- NEI.sub %>% filter(fips == "24510")

# Plot the data
png("plot5.png", width = 480, height = 480, bg = "transparent")
ggplot(data = NEI.sub.balt, mapping = aes(x = factor(year), y = Emissions)) +
        geom_bar(stat = "identity", width = 0.7, fill = "#00CCFF") +
        labs(x = "Year", y = expression("Total Emissions of PM"[2.5]), 
             title = "Emissions from motor vehicle sources in Baltimore City") +
        theme(
                panel.background = element_rect(fill = "transparent"),
                plot.background = element_rect(fill = "transparent")
                #panel.grid.major = element_blank(),
                #panel.grid.minor = element_blank(),
                #legend.background = element_rect(fill = "transparent"),
                #legend.box.background = element_rect(fill = "transparent")
        )
dev.off()


