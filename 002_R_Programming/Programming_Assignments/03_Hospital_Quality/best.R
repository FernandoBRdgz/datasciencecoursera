###########################################################################################
###                                     IMPORTANT:                                      ###
###                  Document created by Fernando Barranco Rodríguez                    ###
###                    Data Science Specialization (R Programming)                      ###
###                        Coursera - Johns Hopkins University                          ###
###########################################################################################

best <- function(state, outcome) {
        
        # Read outcome data
        out.mesure <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        
        # Check that state and outcome are valid
        if( sum(unique(out.mesure$State) == state) ){
                invisible()
        } else {
                stop("invalid state")
                message( paste("Error in best(", state, ",", outcome, ")") )
        }
        ill <- c("heart attack", "heart failure", "pneumonia")
        if( sum(outcome == ill) ){
                invisible()
        } else {
                stop("invalid outcome")
                message( paste("Error in best(", state, ",", outcome, ")") )
        }
        
        # Return hospital name in that state with lowest 30-day death rate
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
        out.mesure <- out.mesure[out.mesure[ , 2] == state, ]
        out.mesure <- out.mesure[order(out.mesure[, 1]), ]
        out.mesure <- out.mesure[order(out.mesure[, 3]), ]
        out.mesure[1,1]
        
}
