# Plot 4
## Verifying the existence of data
list.files("./exdata_data_NEI_data/")

## saving the paths
ClassCodePath <- list.files("./exdata_data_NEI_data/", full.names = TRUE)[1]
SummaryPath <- list.files("./exdata_data_NEI_data/", full.names = TRUE)[2]

## reading via readRDS()
SCC <- readRDS(ClassCodePath)
NEI <- readRDS(SummaryPath)


## subseting for Coal related emissions
a <- 0
for (i in seq_along(names(SCC))){a <- c(a, grep("[Cc]oal", SCC[,i]))}

coalRelatedRows <- unique(a)
coalRelatedRows <- uniqueA[-1]


coalRelatedSCC <- as.character(SCC[coalRelatedRows, "SCC"])
coalRelatedEmissions <- NEI[NEI$SCC %in% coalRelatedSCC,]


## Summary table
CoalRelatedESum <- aggregate(coalRelatedEmissions["Emissions"],
                             list(year = coalRelatedEmissions$year),
                             sum)

## Opening a new file in the plotting device
png('plot4.png', width=480, height=480)

## Setting up the plot
ggplot(CoalRelatedESum, aes(year, Emissions, label = round(Emissions, digits = 0)))+
  geom_point(alpha = 0.4, color = "Black")+
  geom_line(alpha = 0.7, color = "Darkblue")+
  geom_text(check_overlap = TRUE, vjust = 1.5, hjust = 0.4)+
  xlab("Year")+
  ylab("Coal related PM2.5 emissions [tons]")+
  ggtitle("Total PM2.5 Coal combustion-related emissions in the U.S., 1999-2008")

## Closing the device
dev.off()
