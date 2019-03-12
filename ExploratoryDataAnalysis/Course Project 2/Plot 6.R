# Plot 6
## Verifying the existence of data
list.files("./exdata_data_NEI_data/")

## saving the paths
ClassCodePath <- list.files("./exdata_data_NEI_data/", full.names = TRUE)[1]
SummaryPath <- list.files("./exdata_data_NEI_data/", full.names = TRUE)[2]

## reading via readRDS()
SCC <- readRDS(ClassCodePath)
NEI <- readRDS(SummaryPath)


## subseting for Vehicle related emissions in Baltimore City and Los Angeles County
BalLACEmissions <- subset(NEI, subset = NEI$fips == "06037" | NEI$fips == "24510")
c <- 0
for (i in seq_along(names(SCC))){c <- c(c, grep("[vV]ehicle", SCC[,i]))}
uniquec <- unique(c)

VehicleRelatedRows <- uniquec[-1]
VehicleRelatedSCC <- as.character(SCC[VehicleRelatedRows, "SCC"])

BalLACVehicleRelatedEmissions <- BalLACEmissions[BalLACEmissions$SCC %in% VehicleRelatedSCC,]

## Adding labels
BalLACVehicleRelatedEmissions[BalLACVehicleRelatedEmissions$fips == "06037","City"] <- "Los Angeles"
BalLACVehicleRelatedEmissions[BalLACVehicleRelatedEmissions$fips == "24510","City"] <- "Baltimore"

## Summary table
BalLACVehicleRelatedEmSum <- aggregate(BalLACVehicleRelatedEmissions["Emissions"],
                                       list(year = BalLACVehicleRelatedEmissions$year,
                                            city = BalLACVehicleRelatedEmissions$City),
                                       sum)

## Opening a new device
png('plot6.png', width=480, height=480)

## Setting up the plot device
ggplot(BalLACVehicleRelatedEmSum, aes(year, Emissions, label = round(Emissions, digits = 0), colour = city))+
  geom_point(alpha = 0.4, color = "Black")+
  geom_line(alpha = 0.7)+
  geom_text(check_overlap = TRUE, vjust = 1.5, hjust = 0.4)+
  xlab("Year")+
  ylab("Coal related PM2.5 emissions [tons]")+
  ggtitle("Total PM2.5 Vehicle-related emissions,\nBaltimore city vs Los Angeles County., 1999-2008")

## Closing the device
dev.off()
