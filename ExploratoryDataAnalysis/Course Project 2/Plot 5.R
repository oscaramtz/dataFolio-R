# Plot 5
## Verifying the existence of data
list.files("./exdata_data_NEI_data/")

## saving the paths
ClassCodePath <- list.files("./exdata_data_NEI_data/", full.names = TRUE)[1]
SummaryPath <- list.files("./exdata_data_NEI_data/", full.names = TRUE)[2]

## reading via readRDS()
SCC <- readRDS(ClassCodePath)
NEI <- readRDS(SummaryPath)


## subseting for Vehicle related emissions in Baltimore City
BaltimoreEmissions <- subset(NEI, subset = NEI$fips == "24510")

b <- 0

for (i in seq_along(names(SCC))){b <- c(b, grep("[vV]ehicle", SCC[,i]))}

uniqueb <- unique(b)
VehicleRelatedRows <- uniqueb[-1]

VehicleRelatedSCC <- as.character(SCC[VehicleRelatedRows, "SCC"])
VehicleRelatedEmissions <- BaltimoreEmissions[BaltimoreEmissions$SCC %in% VehicleRelatedSCC,]

## Summary table
VehicleRelatedEmSum <- aggregate(VehicleRelatedEmissions["Emissions"],
                                 list(year = VehicleRelatedEmissions$year),
                                 sum)

## Opening a new file in the plotting device
png('plot5.png', width=480, height=480)

## Setting up the plot device
ggplot(VehicleRelatedEmSum, aes(year, Emissions, label = round(Emissions, digits = 0)))+
  geom_point(alpha = 0.4, color = "Black")+
  geom_line(alpha = 0.7, color = "Darkblue")+
  geom_text(check_overlap = TRUE, vjust = 1.5, hjust = 0.4)+
  xlab("Year")+
  ylab("Coal related PM2.5 emissions [tons]")+
  ggtitle("Total PM2.5 Vehicle-related emissions in Baltimore city, 1999-2008")

## Closing the device
dev.off()
