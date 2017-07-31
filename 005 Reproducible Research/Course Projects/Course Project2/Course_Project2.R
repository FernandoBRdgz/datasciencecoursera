###########################################################################################
###                                     IMPORTANT:                                      ###
###                  Document created by Fernando Barranco Rodríguez                    ###
###                Data Science Specialization (Reproducible Research)                  ###
###                        Coursera - Johns Hopkins University                          ###
###########################################################################################

# Course Project 2

# Title: The most severe weather events across the US from 1950 to 2011

# Synopsis: Severe weather events can cause both public health (fatalities, injuries) and
#       economic problems (property damage) for communities, and preventing such outcomes
#       is a key concern; this project involves exploring the U.S. National Oceanic and
#       Atmospheric Administration's (NOAA) storm database wich tracks characteristics of
#       major storms and weather events in the United States, including when and where they
#       occur, as well as estimates of any fatalities, injuries, and property damage.
#       The events in the database start in the year 1950 and end in November 2011.
#       The goal of the proyect is to answer two questions; across the United States:
#       - Which types of events are most harmful with respect to population health?
#       - Which types of events have the greatest economic consequences?


# Set working directory
setwd("C:/Users/FernandoBarranco/Desktop")

# Data Processing

# Download the data from the following url (if necessary)
url <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
download.file(url, "C:/Users/FernandoBarranco/Desktop/StormData.csv.bz2")

# Unzip the .csv file
# install.packages("R.utils")
library(R.utils)
bunzip2("StormData.csv.bz2", "StormData.csv", remove = FALSE, skip = TRUE)

# Read the data into R

# install.packages("data.table")
library(data.table)
storm_data <- fread("StormData.csv")

# Subset, transform and clean the data

# install.packages("dplyr")
library(dplyr)
# install.packages("lubridate")
library(lubridate)

# Rename variables
variables <- names(storm_data)
names(storm_data) <- tolower(variables)

# Keep variables to analyze 
storm_data_sub <- storm_data %>% select(bgn_date, state, evtype, fatalities,
                      injuries, propdmg, propdmgexp, cropdmg, cropdmgexp)

# Change to date format
storm_data_sub$bgn_date <- as.Date(storm_data_sub$bgn_date, format = "%m/%d/%Y %H:%M:%S")

# Removing observations with no fatalities nor injuries
storm_data_sub <- storm_data_sub %>%
        mutate(year = year(bgn_date), evtype = tolower(evtype)) %>%
        select(-bgn_date, state, evtype, fatalities, injuries, year) %>%
        filter(fatalities != 0 | injuries != 0)

# Data wrangling and feature engineering

# Sum up fatalities and injuries by event type
fatalities <- aggregate(fatalities ~ evtype, storm_data_sub, sum)
injuries <- aggregate(injuries ~ evtype, storm_data_sub, sum)

# Keep extreme values that causes the highest damages
storm_data_health <- inner_join(fatalities, injuries, by = "evtype") %>%
        filter(fatalities > quantile(fatalities, probs = .97) &
                injuries > quantile(injuries, probs = .97))

# Property damages counts
table(storm_data_sub$propdmgexp)
table(storm_data_sub$cropdmgexp)

# Map property damage alphanumeric exponents to numeric values.
propdmgkey_level <- c("-", "0", "5", "7", "H", "K", "M", "B")
propdmgkey_label <- c( 10^0+1 , 10^0, 10^5, 10^7, 10^2, 10^3, 10^6, 10^9 )

# Map crop damage alphanumeric exponents to numeric values
cropdmgkey_level <- c("0", "K", "M", "B")
cropdmgkey_label <- c( 10^0, 10^3, 10^6, 10^9 )

# Create new variables that contain the total property damage
storm_data_eco <- storm_data_sub %>%
        select(-(c(state, fatalities, injuries, year))) %>%
        mutate(propdmgexp = toupper(propdmgexp),
               cropdmgkey = factor(cropdmgexp, cropdmgkey_level, cropdmgkey_label),
               propdmgkey = factor(propdmgexp, propdmgkey_level, propdmgkey_label),
               cropdmgkey = as.numeric(as.character(cropdmgkey)),
               propdmgkey = as.numeric(as.character(propdmgkey)),
               propdmgtot = propdmg * propdmgkey,
               cropdmgtot = cropdmg * cropdmgkey )

# Sum up property damage by event type
propdmgtotal <- aggregate(propdmgtot ~ evtype, storm_data_eco, sum)
cropdmgtotal <- aggregate(cropdmgtot ~ evtype, storm_data_eco, sum)

# Keep extreme values that causes the highest damages
storm_data_economy <- full_join(propdmgtotal, cropdmgtotal, by = "evtype") %>%
        filter( propdmgtot > quantile(propdmgtot, probs = .90, na.rm = T) &
                cropdmgtot > quantile(cropdmgtot, probs = .90, na.rm = T))

# Results

# install.packages("ggplot2")
library(ggplot2)

# - Which types of events are most harmful with respect to population health?
ggplot(storm_data_health, aes(injuries, fatalities, color = evtype, shape = evtype)) +
        geom_point(size = 8, alpha = 1) +
        guides(color = guide_legend("Event")) +
        theme_set(theme_bw()) + 
        labs(x = "Injuries", y = "Fatalities",
             title = "The most harmful Events with respect to population Health") +
        scale_shape_manual(name = "Event",
                           values = c(15, 16, 17, 20, 19, 18))

# Notice that tornado has the highest values for both injuries and fatalities, this event
# is the most harmful to population health.

# - Which types of events have the greatest economic consequences?
ggplot(storm_data_economy, aes(propdmgtot/10^9, cropdmgtot/10^9, shape = evtype)) +
        geom_point(size = 8, alpha = 1, aes(color = evtype)) +
        guides(color = guide_legend("Event")) +
        theme_set(theme_bw()) + 
        labs(x = "Property Damage (Billions $)", y = "Crop Damage (Billions $)",
             title = "Events with the greatest Economic consequences") +
        scale_shape_manual(name = "Event",
                           values = c(15, 16, 17, 20, 19, 18))

# Notice that hurricane/typhoon has the highest values for property damage, this event
# causes the greatest economic losses.

