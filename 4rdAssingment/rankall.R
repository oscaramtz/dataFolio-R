## Third assigment "RankHospital Function"

s <- data.frame(1, "b")
row.names(s)<- "AK"

?rbind
rankall <- function(outcome, num = "best") {
  ## Read outcome data
  keep <- c(rep("NULL", 46)); keepVar <- c(2,7,11,17,23); keep[keepVar] <- "character"
  hospitaldt <- read.csv("outcome-of-care-measures.csv", colClasses = keep)
  colnames(hospitaldt) <- c("Hospital Name", "State", "heart attack", "heart failure", "pneumonia")
  for (i in 3:5) {hospitaldt[,i] <- suppressWarnings(as.numeric(hospitaldt[,i]))}
  ## Check that state and outcome are valid
  ##if (!any(unique(hospitaldt$State) == state)) {stop('invalid state')}
  if (!any(colnames(hospitaldt) == outcome)) {stop('invalid outcome')}
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  dfh <- hospitaldt
  dfh <- hospitaldt[order(dfh[,"Hospital Name"]),]
  df <- data.frame()
  if (num == "best") {
    for (i in unique(hospitaldt$State[order(hospitaldt$State)])) {
      temp_df <- dfh[dfh$State == i,]
      nr <- temp_df[order(temp_df[, outcome])[1],]
      row.names(nr) <- i
      df <- rbind(df, nr)
      }
    df[,c("Hospital Name", outcome)]
    }
  if (num == "worst") {
    for (i in unique(hospitaldt$State[order(hospitaldt$State)])) {
      temp_df <- dfh[dfh$State == i,]
      nr <- temp_df[which.max(temp_df[,outcome]),]
      row.names(nr) <- i
      df <- rbind(df, nr)
    }
    df[,c("Hospital Name", outcome)]
  }
  else {
    for (i in unique(hospitaldt$State[order(hospitaldt$State)])) {
      temp_df <- dfh[dfh$State == i,]
      nr <- temp_df[order(temp_df[, outcome])[num],]
      row.names(nr) <- i
      df <- rbind(df, nr)
    }
    df[,c("Hospital Name", outcome)]
  }
}

head(rankall("heart attack", 20), 10)
tail(rankall("pneumonia", "worst"), 3)

