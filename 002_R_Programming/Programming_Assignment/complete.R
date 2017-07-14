###########################################################################################
###                                     IMPORTANT:                                      ###
###                  Document created by Fernando Barranco Rodríguez                    ###
###                    Data Science Specialization (R Programming)                      ###
###                        Coursera - Johns Hopkins University                          ###
###########################################################################################

# 'directory' is a character vector of length 1 indicating the location of the .csv files.
# 'id'        is an integer vector indicating the monitor ID numbers to be used.

complete <- function(directory, id = 1:332){
        
        files <- dir(directory)  # Extract files
        data <- data.frame()  # Create an empty dataframe 
        for(i in id){
                df <- read.csv( files[i] )  # Read file
                df <- df[complete.cases(df), ]  # Remove NA's
                obs <- nrow(df)  # Count observations
                id <- i
                vect <- c(i, obs)
                data <- rbind(data, vect)  # Stack vector(i, obs)
        }
        colnames(data) <- c("id", "nobs")  # Rename columns
        data
}