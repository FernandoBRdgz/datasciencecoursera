###########################################################################################
###                                     IMPORTANT:                                      ###
###                  Document created by Fernando Barranco Rodríguez                    ###
###                    Data Science Specialization (R Programming)                      ###
###                        Coursera - Johns Hopkins University                          ###
###########################################################################################

# 'directory' is a character vector of length 1 indicating the location of the .csv files.
# 'threshold' is a numeric vector of length 1 indicating the number of completely observed
#             observations required to compute the correlation between nitrate and sulfate.

corr <- function(directory, threshold = 0){
        
        files <- dir(directory)  # Extract files
        vect.cor <- numeric()  # Empty numeric vector
        for(i in 1:length(files)){
                df <- read.csv(files[i])  # Read file
                complete.obs <- sum(complete.cases(df))  # Count complete cases
                if(threshold < complete.obs){  # Condition requirement
                        corr <- cor(df[ , 2], df[ ,3], use = "pairwise.complete.obs") 
                        vect.cor <- c(vect.cor, corr)  # Correlation vector
                }
        }
        vect.cor
}