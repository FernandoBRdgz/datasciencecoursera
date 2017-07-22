###########################################################################################
###                                     IMPORTANT:                                      ###
###                  Document created by Fernando Barranco Rodríguez                    ###
###              Data Science Specialization (Getting and Cleaning Data)                ###
###                        Coursera - Johns Hopkins University                          ###
###########################################################################################

# QUIZ 2

lib <- "/home/fernando_barranco/R/x86_64-pc-linux-gnu-library/3.4"

# 1st Q.

library("jsonlite", lib = lib)
library("httpuv", lib = lib)
library("httr", lib = lib)

# Can be github, linkedin etc depending on application
oauth_endpoints("github")

# Change based on your appname, key, and secret 
myapp <- oauth_app(appname = "",
                   key = "",
                   secret = "")

# Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)

# Take action on http error
stop_for_status(req)

# Extract content from a request
json1 = content(req)

# Convert to a data.frame
gitDF = jsonlite::fromJSON(jsonlite::toJSON(json1))

# Subset data.frame
gitDF[gitDF$full_name == "jtleek/datasharing", "created_at"] 

# 2nd Q.

library("sqldf", lib = lib)
library("data.table", lib = lib)

url2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(url = url2, destfile = "~/Escritorio/survey.csv")
acs <- fread(file = "~/Escritorio/survey.csv", sep = ',', header = T)
View(acs)
sqldf("select pwgtp1 from acs where AGEP < 50")

# 3rd Q.

sqldf("select distinct AGEP from acs")

# 4th Q.

connection <- url("http://biostat.jhsph.edu/~jleek/contact.html")
html <- readLines(con = connection)
close(con = connection)
nchar(c(html[10], html[20], html[30], html[100]))

# 5th Q.

url5 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
colNames <- c("week", "sstNino12", "sstaNino12", "sstNino3", "sstaNino3", "sstNino34", 
              "sstaNino34", "sstNino4", "sstaNino4")
widths <- c(12, 7, 4, 9, 4, 9, 4, 9, 4)
fwf <- read.fwf(file = url(url5), skip=4, widths = widths, col.names = colNames)
head(fwf)
sum(fwf[, 4])


