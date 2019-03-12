# Plot 3
## Verifying the existence of data
list.files("./exdata_data_NEI_data/")

## saving the paths
ClassCodePath <- list.files("./exdata_data_NEI_data/", full.names = TRUE)[1]
SummaryPath <- list.files("./exdata_data_NEI_data/", full.names = TRUE)[2]

## reading via readRDS()
SCC <- readRDS(ClassCodePath)
NEI <- readRDS(SummaryPath)

## Loading dependecies
library(ggplot2)

## Open a new device file
png('plot3.png', width=480, height=480)

## Subsetting Baltimore city as point of interest for analysis
BaltimoreEmissions <- subset(NEI, subset = NEI$fips == "24510")

## Setting up the summary table
BaltimoreEmsByType <- aggregate(BaltimoreEmissions["Emissions"],
                                list(type = BaltimoreEmissions$type,
                                     year = BaltimoreEmissions$year),
                                sum)

## Setting up the plot device
ggplot(BaltimoreEmsByType, aes(year, Emissions, color = type))+
  geom_point(alpha = 0.4)+
  geom_line(alpha = 0.7)+
  ggtitle("Total PM2.5 Emissions in Baltimore per Type, 1999-2008")

## Closing the device
dev.off()
