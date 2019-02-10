## Third assigment "Best Function"

best <- function(state, outcome) {
  ## Read outcome data
  keep <- c(rep("NULL", 46)); keepVar <- c(2,7,11,17,23); keep[keepVar] <- "character"
  hospitaldt <- read.csv("outcome-of-care-measures.csv", colClasses = keep)
  colnames(hospitaldt) <- c("Hospital Name", "State", "heart attack", "heart failure", "pneumonia")
  for (i in 3:5) {hospitaldt[,i] <- suppressWarnings(as.numeric(hospitaldt[,i]))}
  ## Check that state and outcome are valid
  if (!any(unique(hospitaldt$State) == state)) {stop('invalid state')}
  if (!any(colnames(hospitaldt) == outcome)) {stop('invalid outcome')}
  ## Return hospital name in that state with lowest 30-day death rate
  hospitaldt[which(hospitaldt$State == state),][which.min(hospitaldt[hospitaldt$State == state,outcome]),][[1]]
}

## Examplea
best("TX", "heart attack")
## [1] "CYPRESS FAIRBANKS MEDICAL CENTER"
best("TX", "heart failure")
## [1] "FORT DUNCAN MEDICAL CENTER"
best("MD", "heart attack")
## [1] "JOHNS HOPKINS HOSPITAL, THE"
best("MD", "pneumonia")
## [1] "GREATER BALTIMORE MEDICAL CENTER"
best("BB", "heart attack")
## Error in best("BB", "heart attack") : invalid state
best("NY", "hert attack")
##Error in best("NY", "hert attack") : invalid outcome
