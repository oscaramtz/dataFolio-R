# Plot 1
## Verifying the existence of data
list.files("./exdata_data_NEI_data/")

## saving the paths
ClassCodePath <- list.files("./exdata_data_NEI_data/", full.names = TRUE)[1]
SummaryPath <- list.files("./exdata_data_NEI_data/", full.names = TRUE)[2]

## reading via readRDS()
SCC <- readRDS(ClassCodePath)
NEI <- readRDS(SummaryPath)

## Summary table
sumEmissions <- tapply(NEI$Emissions,
                       NEI$year,
                       sum)

## Opening a new file
png('plot1.png', width=480, height=480)

## Setting up the plot
plot(names(sumEmissions),
     sumEmissions,
     type = "l",
     xlab = "Year",
     ylab = "Total PM2.5 emission [tons]",
     main = "Total PM2.5 emission in the U.S., 1999 - 2008"
)

## Closing the device
dev.off()
