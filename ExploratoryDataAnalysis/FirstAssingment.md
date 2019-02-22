
---
title: "1stAssignment EDA"
author: "OscarAMtz"
date: "21 de febrero de 2019"
output: html_document
---


## Getting and loading data
```{R}
library(dplyr)
library(tidyr)
library(readr)
library(lubridate)

## Getting data form ./data directory
filepath <- "./data/household_power_consumption.txt"
## 
install.packages("sqldf")
library(sqldf)
library(lubridate)

keptvar <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
hPowerCons_subset <- read.csv.sql(filepath, keptvar, sep=";")
hPowerCons_subset$Date <- dmy(hPowerCons_subset$Date)
hPowerCons_subset$DateTime <- as.POSIXct(paste(hPowerCons_subset$Date, hPowerCons_subset$Time), format="%Y-%m-%d %H:%M:%S")

## Plot 1
with(hPowerCons_subset,
     hist(Global_active_power, 
          col = "red", 
          main = "Global Active Power", 
          xlab = "Global Active Power (Kilowatts)"))
dev.copy(device = png,"plot1.png")


## Plot 2
with(hPowerCons_subset, 
     plot(
       DateTime ,
       Global_active_power, 
       ylab = "Global Active Power (Kilowatts)", 
       xlab = "",  
       type = "l"))
dev.copy(device = png,"plot2.png")

## plot 3
with(hPowerCons_subset, 
     plot(
       DateTime ,
       Sub_metering_1,
       ylab = "Energy sub metering", 
       xlab = "",  
       type = "l")
     )
with(hPowerCons_subset, 
  lines(
         DateTime ,
         Sub_metering_2,
         col = "red"
       )
)
with(hPowerCons_subset,  
       lines(
         DateTime ,
         Sub_metering_3,
         col = "blue"
       )
)
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), 
       lty = 1
       )

dev.copy(device = png,"plot3.png")

## Plot 4
#layout (1,1)
par(mfrow = c(2, 2))
with(hPowerCons_subset, 
     plot(
       DateTime ,
       Global_active_power, 
       ylab = "Global Active Power (Kilowatts)", 
       xlab = "",  
       type = "l")
     )
#layout (1,2)
with(hPowerCons_subset, 
     plot(
       DateTime ,
       Voltage, 
       ylab = "Voltage", 
       xlab = "datetime",  
       type = "l")
     )
#layout (2,1)
with(hPowerCons_subset, 
     plot(
       DateTime ,
       Sub_metering_1,
       ylab = "Energy sub metering", 
       xlab = "",  
       type = "l")
     )
with(hPowerCons_subset, 
  lines(
         DateTime ,
         Sub_metering_2,
         col = "red"
       )
)
with(hPowerCons_subset,  
       lines(
         DateTime ,
         Sub_metering_3,
         col = "blue"
       )
)
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), 
       lty = 1
       )
# Layout (2,2)
with(hPowerCons_subset, 
     plot(
       DateTime ,
       Global_reactive_power, 
       ylab = "Global_reactive_power", 
       xlab = "datetime",  
       type = "l")
     )
dev.copy(device = png,"plot4.png")
```

## Best example for subseting rows

```{R}
######Step1 getting and cleaning the data######
start <- grep("1/2/2007", readLines("household_power_consumption.txt"))[1]   ##getting first occurence of our date as character
end1 <- grep("^2/2/2007", readLines("household_power_consumption.txt"))  ##getting the last occurence of our second date as character, the "^" is there as metachacter to avoid to have 22/02/2007

rowtoprint <- end1[length(end1)]-start ##Computing total number of row to print


datatitle <- read.csv(file="household_power_consumption.txt",sep = ";", stringsAsFactors=FALSE,
                      header = FALSE,na.strings = "?",
                      nrows = 1)  ##getting the colonames from the txt file
dataset <- read.csv(file="household_power_consumption.txt",sep = ";", skip=start-1, stringsAsFactors=FALSE,
                      header = FALSE,na.strings = "?",
                      nrows = rowtoprint+1)  ## Getting the data the "-1" in skip and the "+1" in in nrows comes from the fact that we put the header at false so we have to slide from one position our selection
colnames(dataset) <- datatitle ## assigning the name of the variable


dataset$dateNtime <- strptime(paste(dataset$Date,dataset$Time,sep=" "), format = "%d/%m/%Y %H:%M:%S")##having one column with good formal date and time
Finaldataset <- data.frame(dataset$dateNtime,dataset[,c(3:9)])  ##keeping only the relevant columns


###Step 2 getting the plot #####
png("plot1.png", width=480, height=480)  ##choosing the good device here png with 480x480
par(mfrow = c(1,1)) ##determining the number of graph to show, here 1
hist(Finaldataset$Global_active_power,col="red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")  ##histo graph with appropriate x label and title
dev.off()  ###exiting the device and come back to the screen one
```
