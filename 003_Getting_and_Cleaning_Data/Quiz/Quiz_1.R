###########################################################################################
###                                     IMPORTANT:                                      ###
###                  Document created by Fernando Barranco Rodríguez                    ###
###              Data Science Specialization (Getting and Cleaning Data)                ###
###                        Coursera - Johns Hopkins University                          ###
###########################################################################################

# QUIZ 1

lib <- "/home/fernando_barranco/R/x86_64-pc-linux-gnu-library/3.4"
library("data.table", lib = lib)
library("readxl", lib = lib)
library("XML", lib = lib)

# 1st Q.
url1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url = url1, destfile = "~/Escritorio/housing.csv")
data <- fread(file = "~/Escritorio/housing.csv", sep = ',', header = T)
str(data)
data[VAL == 24, .N, by = .(VAL)]  

# 2nd Q.
data[ , .(FES)]  

# 3rd Q.
url3 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(url = url3, destfile = "~/Escritorio/gov.xlsx")
dat <- read_excel(path = "~/Escritorio/gov.xlsx", range = "G18:O23")
View(dat)
sum(dat$Zip*dat$Ext,na.rm=T)

# 4th Q.
url4 <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(url4, useInternal=TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
sum(xpathSApply(rootNode,"//zipcode",xmlValue) == 21231)

# 5th Q.
url5 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(url = url5, destfile = "~/Escritorio/communities.csv")
DT <- fread(file = "~/Escritorio/communities.csv", sep = ',', header = T)
summary(DT[ , .(pwgtp15)]); summary(DT[ , .(SEX)])
system.time(DT[,mean(pwgtp15),by=SEX])
