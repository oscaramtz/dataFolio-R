# Plot 2
## Verifying the existence of data
list.files("./exdata_data_NEI_data/")

## saving the paths
ClassCodePath <- list.files("./exdata_data_NEI_data/", full.names = TRUE)[1]
SummaryPath <- list.files("./exdata_data_NEI_data/", full.names = TRUE)[2]

## reading via readRDS()
SCC <- readRDS(ClassCodePath)
NEI <- readRDS(SummaryPath)

## Subsetting Baltimore city as point of interest for analysis
BaltimoreEmissions <- subset(NEI, subset = NEI$fips == "24510")

## Opening a new file
png('plot2.png', width=480, height=480)


## Summary table
sumBaltimoreEms <- tapply(BaltimoreEmissions$Emissions,
                          BaltimoreEmissions$year,
                          sum)

## Setting up the plot
plot(names(sumBaltimoreEms),
     sumBaltimoreEms,
     type = "l",
     xlab = "Year",
     ylab = "Total PM2.5 emission [tons]",
     main = "Total PM2.5 emissions in Baltimor City, 1999 - 2008"
)

## Closing the device
dev.off()

