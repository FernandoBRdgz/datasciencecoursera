###########################################################################################
###                                     IMPORTANT:                                      ###
###                  Document created by Fernando Barranco Rodríguez                    ###
###                    Data Science Specialization (R Programming)                      ###
###                        Coursera - Johns Hopkins University                          ###
###########################################################################################

rankall <- function(outcome, num = "best") {
        
        # Read outcome data
        out.mesure <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        
        # Check that state and outcome are valid
        ill <- c("heart attack", "heart failure", "pneumonia")
        if( sum(outcome == ill) ){
                invisible()
        } else {
                stop("invalid outcome")
                message( paste("Error in best(", state, ",", outcome, ")") )
        }
        
        # For each state, find the hospital of the given rank
        if(outcome == ill[1]){
                out.mesure <- out.mesure[ , c(2,7,11)]
        } else if(outcome == ill[2]){
                out.mesure <- out.mesure[ , c(2,7,17)]
        } else if(outcome == ill[3]){
                out.mesure <- out.mesure[ , c(2,7,23)]
        } else {
                invisible()
        }
        suppressWarnings( out.mesure[, 3] <- as.numeric(out.mesure[, 3]) )
        
        # Helper function
        help.rank <- function(out.mesure){
                out.mesure <- out.mesure[order(out.mesure[, 1]), ]
                out.mesure <- out.mesure[order(out.mesure[, 3]), ]

                if(num == "best"){
                        num <- 1
                        return(out.mesure[num, 1])
                } else if(num == "worst"){
                        num <- which.max(out.mesure[ , 3])
                        return(out.mesure[num, 1])
                } else if(num > nrow(out.mesure)){
                        return(NA)
                } else{
                        return(out.mesure[num, 1])
                }
        }
        
        # Return a data frame with the hospital names and the (abbreviated) state name
        ranking <- sapply(split(out.mesure, out.mesure[ , 2]), help.rank)
        state <- names(ranking)
        hospital <- as.vector(ranking)
        data.frame(hospital, state) 

}



