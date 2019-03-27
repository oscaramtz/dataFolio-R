# Title

Economic and Public Health impact of catastrophic weather events in the United States 1950 - 2011
(Assignment 2)

## Synopsis



## Data Processing

if(!file.exists("./repdata_data_StormData.csv.bz2")){
    download.file("https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormDa#ta.csv.bz2",
                  "./data/StormData.csv.bz2")}

```{R}
url <- ("https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2")
download.file(url, "./data/StormData.csv.bz2")
StormData <- read.csv("./data/StormData.csv.bz2")
```

## Recon on the data base
dim(StormData)
names(StormData)

head(StormData)
as.POSIXct.Date(StormData$BGN_DATE)


StormData$month <-  months(as.POSIXct.Date(StormData$BGN_DATE))
match(StormData$month,month.name)
?month.name
Sys.setlocale(locale = "English")
  ## selecting the variables of interest
keep <- c("STATE", "EVTYPE", "FATALITIES", "INJURIES", "PROPDMG", "PROPDMGEXP",  "CROPDMG", "CROPDMGEXP", "month")
StormDataSelected <- StormData[, keep]

### Taking a quick glance of the data.frame object

```{r, echo=FALSE, results='asis'}
knitr::kable(head(StormData,5))

```
str(StormData)

names(StormDataSelected)[1] <- c("state")

as.data.frame(xtabs(PROPDMG~PROPDMGEXP, StormDataSelected))
order(as.data.frame(table(StormDataSelected$PROPDMGEXP)))

## formatting Propety damage exponential values
levels(StormDataSelected$PROPDMGEXP)
StormDataSelected$PROPDMGEXP <- as.vector(StormDataSelected$PROPDMGEXP)
StormDataSelected$PROPDMGEXP[StormDataSelected$PROPDMGEXP %in% c("","+","-","?")] <- "1"
StormDataSelected$PROPDMGEXP[StormDataSelected$PROPDMGEXP == "h" | StormDataSelected$PROPDMGEXP == "H"] <- "2"
StormDataSelected$PROPDMGEXP[StormDataSelected$PROPDMGEXP == "m" | StormDataSelected$PROPDMGEXP == "M"] <- "6"
StormDataSelected$PROPDMGEXP[StormDataSelected$PROPDMGEXP == "K"] <- "3"
StormDataSelected$PROPDMGEXP[StormDataSelected$PROPDMGEXP == "B"] <- "9"

StormDataSelected$PROPDMGEXP <- as.numeric(StormDataSelected$PROPDMGEXP)

unique(StormDataSelected$PROPDMGEXP)
StormDataSelected$PropetyDMG <- StormDataSelected$PROPDMG*10^StormDataSelected$PROPDMGEXP

## formatting Crop damage exponential values
levels(StormDataSelected$CROPDMGEXP)

StormDataSelected$CROPDMGEXP <- as.vector(StormDataSelected$CROPDMGEXP)
StormDataSelected$CROPDMGEXP[StormDataSelected$CROPDMGEXP  %in% c("","+","-","?")] <- "1"
StormDataSelected$CROPDMGEXP[StormDataSelected$CROPDMGEXP == "m" | StormDataSelected$CROPDMGEXP == "M"] <- "6"
StormDataSelected$CROPDMGEXP[StormDataSelected$CROPDMGEXP == "k" | StormDataSelected$CROPDMGEXP == "K"] <- "3"
StormDataSelected$CROPDMGEXP[StormDataSelected$CROPDMGEXP == "B"] <- "9"
StormDataSelected$CROPDMGEXP <- as.numeric(StormDataSelected$CROPDMGEXP)

unique(StormDataSelected$PROPDMGEXP)
StormDataSelected$CropDMG <- StormDataSelected$CROPDMG*10^StormDataSelected$CROPDMGEXP


## summary tables
FatalitiesEvent <- aggregate(FATALITIES~EVTYPE, StormDataSelected[StormDataSelected$FATALITIES > 0,], sum)
InjuriesEvent <- aggregate(INJURIES~EVTYPE, StormDataSelected[StormDataSelected$INJURIES > 0,], sum)
PropCost <- aggregate(PropetyDMG~EVTYPE, StormDataSelected[StormDataSelected$PropetyDMG > 0,], sum)
CropCost <- aggregate(CropDMG~EVTYPE, StormDataSelected[StormDataSelected$CropDMG > 0,], sum)
StatePropCost <- aggregate(PropetyDMG~state, StormDataSelected[StormDataSelected$PropetyDMG > 0,], sum)
StateCropCost <- aggregate(CropDMG~state, StormDataSelected[StormDataSelected$CropDMG > 0,], sum)

StatePropCost$PropetyDMGMillions <- StatePropCost$PropetyDMG/1000000
StateCropCost$CropDMGMillions <- StateCropCost$CropDMG/1000000



StatePropCost <- StatePropCost[order(StatePropCost$PropetyDMG, decreasing = T),]
StateCropCost <- StateCropCost[order(StateCropCost$CropDMG, decreasing = T),]


FatalitiesEvent <- FatalitiesEvent[order(FatalitiesEvent$FATALITIES, decreasing = T),]
InjuriesEvent <- InjuriesEvent[order(InjuriesEvent$INJURIES, decreasing = T),]
PropCost <- PropCost[order(PropCost$PropetyDMG, decreasing = T),]
CropCost <- CropCost[order(CropCost$CropDMG, decreasing = T),]

InjuriesEventMonth <- aggregate(INJURIES~EVTYPE+month, StormDataSelected[StormDataSelected$INJURIES > 0,], sum)

InjuriesEventMonth
str(InjuriesEventMonth)


InjuriesEventMonth$month2 <- as.POSIXct(paste0("2015-", match(InjuriesEventMonth$month,month.name),"-01"),"%Y-%m-%d", tz = "GMT")
as.POSIXct.default(InjuriesEventMonth$month2)
library(ggplot2)
ggplot(InjuriesEventMonth)
## plots

InjuriesEventMonth['month2'].dt.strftime('%b')


ggplot(InjuriesEventMonth, aes(x = as.Date(InjuriesEventMonth$month2, "%Y-%m-%d"), y = INJURIES)) +
  geom_bar(stat = "identity", fill = "darkorchid4") +
  labs(title = "Montly Total injuries, US",
       subtitle = "Data plotted by month",
       y = "Total of injuries",
       x = "Month") + theme_bw(base_size = 15) +
  scale_x_date(date_labels =  "%B")

scale_x

paste0(round(sum(InjuriesEvent[1:10,2])/sum(InjuriesEvent[,2])*100, 2), "%")

### Top ten health damages

ggplot(InjuriesEvent[1:10,], aes(x = reorder(EVTYPE, -INJURIES), y = INJURIES)) +
  geom_bar(stat = "identity", fill = viridis::cividis(10, direction = -1)) +
  geom_text(aes(label=scales::comma(INJURIES)), vjust=-0.3, size=3.5) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(title = "Top 10 weather events with the major injuries causation, 1950-2011",
       subtitle = "NOAA: US data",
       y = "Total of injuries",
       x = "Event type") +
  scale_y_continuous(labels = scales::comma)

ggplot(FatalitiesEvent[1:10,], aes(x = reorder(EVTYPE, -FATALITIES), y = FATALITIES)) +
  geom_bar(stat = "identity", fill = viridis::cividis(10, direction = -1)) +
  geom_text(aes(label=scales::comma(FATALITIES)), vjust=-0.3, size=3.5) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(title = "Top 10 weather events with the fatal outcome causation, 1950-2011",
       subtitle = "NOAA: US data",
       y = "Total of injuries",
       x = "Event type") +
  scale_y_continuous(labels = scales::comma)
StatePropCost$PropetyDMG
# cost

ggplot(StatePropCost[1:10,], aes(x = reorder(`state`, -`PropetyDMGMillions`), y = `PropetyDMGMillions`)) +
  geom_bar(stat = "identity", fill = viridis::cividis(10, direction = -1)) +
  geom_text(aes(label=scales::dollar(PropetyDMGMillions)), vjust=-0.3, size=3.5) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(title = "Top 10 states with mayor properties cost, 1950-2011",
       subtitle = "NOAA: US data",
       y = "Total of millions",
       x = "State") +
  scale_y_continuous(labels = scales::dollar)

ggplot(StateCropCost[1:10,], aes(x = reorder(`state`, -`CropDMGMillions`), y = `CropDMGMillions`)) +
  geom_bar(stat = "identity", fill = viridis::cividis(10, direction = -1)) +
  geom_text(aes(label=scales::dollar(CropDMGMillions)), vjust=-0.3, size=3.5) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(title = "Top 10 states with mayor crop losses, 1950-2011",
       subtitle = "NOAA: US data",
       y = "Total of millions",
       x = "State") +
  scale_y_continuous(labels = scales::dollar)
## Results

