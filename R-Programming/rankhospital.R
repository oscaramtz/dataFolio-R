## Third assigment "RankHospital Function"

state <- "TX"
rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  keep <- c(rep("NULL", 46)); keepVar <- c(2,7,11,17,23); keep[keepVar] <- "character"
  hospitaldt <- read.csv("outcome-of-care-measures.csv", colClasses = keep)
  colnames(hospitaldt) <- c("Hospital Name", "State", "heart attack", "heart failure", "pneumonia")
  for (i in 3:5) {hospitaldt[,i] <- suppressWarnings(as.numeric(hospitaldt[,i]))}
  ## Check that state and outcome are valid
  if (!any(unique(hospitaldt$State) == state)) {stop('invalid state')}
  if (!any(colnames(hospitaldt) == outcome)) {stop('invalid outcome')}
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  dfh <- hospitaldt
  dfh <- hospitaldt[hospitaldt$State == state,]
  dfh <- dfh[order(dfh[, 1]),]
  if (num == "best") { return(dfh[order(dfh[, outcome])[1],1])}
  if (num == "worst") { return(dfh[which.max(dfh[,outcome]),1])}
  else {dfh[order(dfh[, outcome])[num],1]}
}


rankhospital("TX", "heart failure")
rankhospital("TX", "heart failure", "best")
rankhospital("TX", "heart failure", 1)
rankhospital("TX", "heart failure", 2)
rankhospital("TX", "heart failure", 3)
rankhospital("TX", "heart failure", 4)
rankhospital("TX", "heart failure", 5)
rankhospital("TX", "heart failure", 6)
rankhospital("MD", "heart attack", "worst")
rankhospital("MN", "heart attack", "worst")
rankhospital("MN", "heart attack", 5000)
