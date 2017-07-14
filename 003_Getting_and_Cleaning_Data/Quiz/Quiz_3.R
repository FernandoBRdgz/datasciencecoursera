###########################################################################################
###                                     IMPORTANT:                                      ###
###                  Document created by Fernando Barranco Rodríguez                    ###
###              Data Science Specialization (Getting and Cleaning Data)                ###
###                        Coursera - Johns Hopkins University                          ###
###########################################################################################

# QUIZ 3

lib <- "/home/fernando_barranco/R/x86_64-pc-linux-gnu-library/3.4"

# 1st Q.

library("data.table", lib = lib)

url1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url = url1, destfile = "~/Escritorio/communities.csv")
data.house <- fread(input = "~/Escritorio/communities.csv", sep = ',', header = T)
agricultureLogical <- data.house$ACR == 3 & data.house$AGS == 6
head(which(agricultureLogical), 3)

# 2nd Q.

library("jpeg", lib = lib)

url2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(url = url2, destfile = "~/Escritorio/jeff.jpg")
jeff <- readJPEG(source = "~/Escritorio/jeff.jpg", native = TRUE)
quantile(jeff, probs = c(0.30, 0.80))

# 3rd Q.

library("data.table", lib = lib)
library("dplyr", lib = lib)

url3.1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(url = url3.1, destfile = "~/Escritorio/domestic.csv")
colnames <- c("CountryCode", "Ranking", "Economy", "M_Dollars")
domestic <- fread("~/Escritorio/domestic.csv", skip = 4, 
                  select = c(1,2,4,5), col.names = colnames, nrows = 190)
url3.2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(url = url3.2, destfile = "~/Escritorio/educational.csv")
educational <- fread("~/Escritorio/educational.csv", sep = ',', header = T)
data.join <- merge(x = domestic, y = educational, by = "CountryCode")
data.join.sorted <- arrange(data.join, desc(Ranking))
nrow(data.join.sorted); data.join.sorted[13, 1:3]

# 4th Q.

data.income <- data.join.sorted[, c(1,2,3,6)]
colnames(data.income) <- c("CountryCode", "Ranking", "Economy", "IncomeGroup")
Ranked.mean <- data.income %>%
        filter(IncomeGroup=="High income: nonOECD" | IncomeGroup=="High income: OECD") %>%
        group_by(IncomeGroup) %>%
        summarize(RankedMean = mean(Ranking)) %>%
        print

# 5th Q.

library("Hmisc", lib = lib)

data.bin <- data.join.sorted[, c(1,2,3,6)]
colnames(data.bin) <- c("CountryCode", "Ranking", "Economy", "IncomeGroup")
data.bin$Ranking <- cut2(x = data.bin$Ranking, g = 5)
table(data.bin$Ranking, data.bin$IncomeGroup)

