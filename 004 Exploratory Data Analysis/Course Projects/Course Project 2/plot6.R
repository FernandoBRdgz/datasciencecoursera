###########################################################################################
###                                     IMPORTANT:                                      ###
###                  Document created by Fernando Barranco Rodríguez                    ###
###              Data Science Specialization (Exploratory Data Analysis)                ###
###                        Coursera - Johns Hopkins University                          ###
###########################################################################################

# Course Project 2

# Plot 6

# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor
# vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen
# greater changes over time in motor vehicle emissions?

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

# Filter by 'Baltimore City' and 'Los Angeles' County, California
NEI.sub.city <- NEI.sub %>% filter(fips == "24510" | fips == "06037")

# Plot the data
png("plot6.png", width = 480, height = 480, bg = "transparent")
ggplot(data = NEI.sub.city, mapping = aes(x = factor(year), y = Emissions, fill = fips)) +
        geom_bar(stat = "identity", width = 0.7) +
        facet_grid(. ~ factor(fips, labels = c("Los Angeles", "Baltimore"))) +
        guides(fill = FALSE) +
        labs(x = "Year", y = expression("Total Emissions of PM"[2.5]), 
             title = "Emissions from motor vehicle sources. LA vs Baltimore") +
        theme(
                panel.background = element_rect(fill = "transparent"),
                plot.background = element_rect(fill = "transparent")
                #panel.grid.major = element_blank(),
                #panel.grid.minor = element_blank(),
                #legend.background = element_rect(fill = "transparent"),
                #legend.box.background = element_rect(fill = "transparent")
        )
dev.off()

