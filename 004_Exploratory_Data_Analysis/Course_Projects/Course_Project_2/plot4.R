###########################################################################################
###                                     IMPORTANT:                                      ###
###                  Document created by Fernando Barranco Rodríguez                    ###
###              Data Science Specialization (Exploratory Data Analysis)                ###
###                        Coursera - Johns Hopkins University                          ###
###########################################################################################

# Course Project 2

# Plot 4

# Across the United States, how have emissions from coal combustion-related sources
# changed from 1999–2008?

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
SCC.comb <- grepl("Comb", SCC$SCC.Level.One)
SCC.sub <- SCC %>% filter(SCC.comb) 
SCC.coal <- grepl("Coal", SCC.sub$SCC.Level.Four)
SCC.sub <- SCC.sub %>% filter(SCC.coal)
SCC.scc <- SCC.sub %>% select(SCC)

# Match the data
NEI.sub <- inner_join(NEI, SCC.scc, by = "SCC")

# Plot the data
png("plot4.png", width = 480, height = 480, bg = "transparent")
ggplot(data = NEI.sub, mapping = aes(x = factor(year), y = Emissions)) +
        geom_bar(stat = "identity", width=0.7, fill = "#00CCFF") +
        labs(x = "Year", y = expression("Total Emissions of PM"[2.5]), 
             title = "Emissions from coal combustion sources in US") +
        theme(
        panel.background = element_rect(fill = "transparent"),
        plot.background = element_rect(fill = "transparent")
        #panel.grid.major = element_blank(),
        #panel.grid.minor = element_blank(),
        #legend.background = element_rect(fill = "transparent"),
        #legend.box.background = element_rect(fill = "transparent")
        )
dev.off()
