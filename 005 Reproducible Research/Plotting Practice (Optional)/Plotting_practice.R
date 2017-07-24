###########################################################################################
###                                     IMPORTANT:                                      ###
###                  Document created by Fernando Barranco Rodríguez                    ###
###              Data Science Specialization (Exploratory Data Analysis)                ###
###                        Coursera - Johns Hopkins University                          ###
###########################################################################################

# Set working directory (in my case will be the Desktop)
setwd("~/Escritorio")
lib <- "/home/fernando_barranco/R/x86_64-pc-linux-gnu-library/3.4"

# Download and unzip the dataset (in case you don't have it)
url <- "https://d3c33hcgiwev3.cloudfront.net/_e143dff6e844c7af8da2a4e71d7c054d_payments.csv?Expires=1501027200&Signature=iLCEcmu~VvWigcXIwq7zk1kYQZ9P-b3R8Xes-nPpyVSrDGYAsjODfbRmA4eIHx~0B8j3G7Lencc2qtXjGbyT-PaO~O0G2E57uyA55CWi17R2XYFqK727~BonrvULc9y6CF4T29TU3dNxl2FkjbIWdZCUHr6e0wgtubUIZAMrOZE_&Key-Pair-Id=APKAJLTNE6QMUY6HBC5A"
download.file(url = url, destfile = "~/Escritorio/payments.csv")

# Load required libraries
library("data.table", lib = lib)
library("dplyr", lib = lib)
library("ggplot2", lib = lib)

# Read the data into R
payments <- fread("~/Escritorio/payments.csv")

# Plot 1

# Make a plot that answers the question:
# What is the relationship between mean covered charges (Average.Covered.Charges) and mean
# total payments (Average.Total.Payments) in New York?

# Subset the data
payments.sub1 <- payments %>%
        select(Average.Covered.Charges, Average.Total.Payments, Provider.State) %>%
        filter(Provider.State == 'NY')

# Plot the data
pdf("plot1.pdf")
ggplot(data = payments.sub1, mapping = aes(x = log10(Average.Covered.Charges),
                                           y = log10(Average.Total.Payments))) +
        geom_point(aes(alpha = 0.5)) +
        geom_smooth(method = "lm", se = FALSE, color = "green") + 
        theme(legend.position = "none") +
        labs(x = "Log10 Average covered charges", y = "Log10 Average total payments",
             title = "Mean covered charges vs Mean total payments in New York")
dev.off()

# Plot 2

# Make a plot (possibly multi-panel) that answers the question:
# How does the relationship between mean covered charges (Average.Covered.Charges) and mean
# total payments (Average.Total.Payments) vary by medical condition (DRG.Definition) and the
# state in which care was received (Provider.State)?

# Subset the data
payments.sub2 <- payments %>%
        select(Average.Covered.Charges, Average.Total.Payments, Provider.State, DRG.Definition)

# Plot the data
pdf("plot2.pdf", width = 12, height = 7)
ggplot(data = payments.sub2, mapping = aes(x = log10(Average.Covered.Charges),
                                           y = log10(Average.Total.Payments))) +
        geom_point(aes(alpha = 0.15)) +
        facet_grid(factor(Provider.State) ~ factor(DRG.Definition, labels = c("Simple Pneumonia & Pleurisy",
                "Heart failure & Shock", "Digest Disorders", "Nutritional Disorders",
                "Urinary tract Infections", "Septicemia or severe Sepsis"))) +
        geom_smooth(method = "lm", se = FALSE, color = "green") + 
        theme(legend.position = "none") + 
        labs(x = "Log10 Average covered charges", y = "Log10 Average total payments",
             title = "Mean covered charges vs Mean total payments by Medical condition & State in which care was received")
dev.off()

