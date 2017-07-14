###########################################################################################
###                                     IMPORTANT:                                      ###
###                  Document created by Fernando Barranco Rodríguez                    ###
###                    Data Science Specialization (R Programming)                      ###
###                        Coursera - Johns Hopkins University                          ###
###########################################################################################

# 'directory' is a character vector of length 1 indicating the location of the .csv files.
# 'pollutant' is a character vector of length 1 indicating the name of the pollutant... 
#             for wich we'll calculate the mean; either 'sulfate' or 'nitrate'.
# 'id'        is an integer vector indicating the monitor ID numbers to be used.

pollutantmean <- function(directory, pollutant, id = 1:332){

        files <- dir(directory)  # Extract files  
        df <- data.frame()  # Create an empty dataframe 
        for(i in id){
                df <- rbind(df, read.csv( files[i] ))  # Stack files
        }
        temp <- df[pollutant]   # Subset "pollutant"
        poll <- temp[!is.na(temp)]  # Remove NA's
        mean(poll, na.rm = T)  # Calculate the mean

}