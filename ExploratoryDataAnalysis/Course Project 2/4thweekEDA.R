Code Source para
data source directory
source <- "C:/Users/OscarAMtz/OneDrive/WD/R-WD/exdata_data_NEI_data"
"./exdata_data_NEI_data/"
list.files("./exdata_data_NEI_data/")

## saving the paths
ClassCodePath <- list.files("./exdata_data_NEI_data/", full.names = TRUE)[1]
SummaryPath <- list.files("./exdata_data_NEI_data/", full.names = TRUE)[2]

## reading via readRDS()
SCC <- readRDS(ClassCodePath)
NEI <- readRDS(SummaryPath)

## metadata
This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008. For each year, the table contains number of tons of PM2.5 emitted from a specific type of source for the entire year.
## Plot 1
SCC <- readRDS(ClassCodePath)
NEI <- readRDS(SummaryPath)

sumEmissions <- tapply(NEI$Emissions,
                       NEI$year,
                       sum)

png('plot1.png', width=480, height=480)

plot(names(sumEmissions),
     sumEmissions,
     type = "l",
     xlab = "Year",
     ylab = "Total PM2.5 emission [tons]",
     main = "Total PM2.5 emission in the U.S., 1999 - 2008"
)


dev.off()

# plot 2
png('plot2.png', width=480, height=480)

BaltimoreEmissions <- subset(NEI, subset = NEI$fips == "24510")

sumBaltimoreEms <- tapply(BaltimoreEmissions$Emissions,
                          BaltimoreEmissions$year,
                          sum)

plot(names(sumBaltimoreEms),
     sumBaltimoreEms,
     type = "l",
     xlab = "Year",
     ylab = "Total PM2.5 emission [tons]",
     main = "Total PM2.5 emissions in Baltimor City, 1999 - 2008"
)

dev.off()

# plot 3
library(ggplot2)
png('plot3.png', width=480, height=480)

##
# xtabs(Emissions~type+year, NEI)
## or
#TypeEmsSum <- with(NEI, tapply(Emissions, list(type, year), FUN=sum))
## or
# with(BaltimoreEmissions, tapply(Emissions, list(type, year), FUN=sum))


BaltimoreEmissions <- subset(NEI, subset = NEI$fips == "24510")
BaltimoreEmsByType <- aggregate(BaltimoreEmissions["Emissions"], list(type=BaltimoreEmissions$type, year = BaltimoreEmissions$year), sum)


ggplot(BaltimoreEmsByType, aes(year, Emissions, color = type))+
  geom_point(alpha = 0.4)+
  geom_line(alpha = 0.7)+
  ggtitle("Total PM2.5 Emissions in Baltimore per Type, 1999-2008")

dev.off()

# Plot 4
png('plot4.png', width=480, height=480)

a <- 0
for (i in seq_along(names(SCC))){a <- c(a, grep("[Cc]oal", SCC[,i]))}
coalRelatedRows <- unique(a)
coalRelatedRows <- uniqueA[-1]
coalRelatedSCC <- as.character(SCC[coalRelatedRows, "SCC"])
coalRelatedEmissions <- NEI[NEI$SCC %in% coalRelatedSCC,]

CoalRelatedESum <- aggregate(coalRelatedEmissions["Emissions"],
                             list(year = coalRelatedEmissions$year),
                             sum)

ggplot(CoalRelatedESum, aes(year, Emissions, label = round(Emissions, digits = 0)))+
  geom_point(alpha = 0.4, color = "Black")+
  geom_line(alpha = 0.7, color = "Darkblue")+
  geom_text(check_overlap = TRUE, vjust = 1.5, hjust = 0.4)+
  xlab("Year")+
  ylab("Coal related PM2.5 emissions [tons]")+
  ggtitle("Total PM2.5 Coal combustion-related emissions in the U.S., 1999-2008")

dev.off()

# Plot 5
png('plot5.png', width=480, height=480)

BaltimoreEmissions <- subset(NEI, subset = NEI$fips == "24510")

b <- 0
##for (i in seq_along(names(SCC))){b <- c(b, grep("[mM]otor", SCC[,i]))}
for (i in seq_along(names(SCC))){b <- c(b, grep("[vV]ehicle", SCC[,i]))}
uniqueb <- unique(b)
VehicleRelatedRows <- uniqueb[-1]
VehicleRelatedSCC <- as.character(SCC[VehicleRelatedRows, "SCC"])
VehicleRelatedEmissions <- BaltimoreEmissions[BaltimoreEmissions$SCC %in% VehicleRelatedSCC,]

VehicleRelatedEmSum <- aggregate(VehicleRelatedEmissions["Emissions"],
                             list(year = VehicleRelatedEmissions$year),
                             sum)

ggplot(VehicleRelatedEmSum, aes(year, Emissions, label = round(Emissions, digits = 0)))+
  geom_point(alpha = 0.4, color = "Black")+
  geom_line(alpha = 0.7, color = "Darkblue")+
  geom_text(check_overlap = TRUE, vjust = 1.5, hjust = 0.4)+
  xlab("Year")+
  ylab("Coal related PM2.5 emissions [tons]")+
  ggtitle("Total PM2.5 Vehicle-related emissions in Baltimore city, 1999-2008")

dev.off()

### Plot 6
png('plot6.png', width=480, height=480)

#BaltimoreEmissions <- subset(NEI, subset = NEI$fips == "24510")
#LosAngelesEmissions <- subset(NEI, subset = NEI$fips == "06037")
BalLACEmissions <- subset(NEI, subset = NEI$fips == "06037" | NEI$fips == "24510")
c <- 0
##for (i in seq_along(names(SCC))){b <- c(b, grep("[mM]otor", SCC[,i]))}
for (i in seq_along(names(SCC))){c <- c(c, grep("[vV]ehicle", SCC[,i]))}
uniquec <- unique(c)
VehicleRelatedRows <- uniquec[-1]
VehicleRelatedSCC <- as.character(SCC[VehicleRelatedRows, "SCC"])


BalLACVehicleRelatedEmissions <- BalLACEmissions[BalLACEmissions$SCC %in% VehicleRelatedSCC,]

BalLACVehicleRelatedEmissions[BalLACVehicleRelatedEmissions$fips == "06037","City"] <- "Los Angeles"
BalLACVehicleRelatedEmissions[BalLACVehicleRelatedEmissions$fips == "24510","City"] <- "Baltimore"

BalLACVehicleRelatedEmSum <- aggregate(BalLACVehicleRelatedEmissions["Emissions"],
                                 list(year = BalLACVehicleRelatedEmissions$year,
                                      city = BalLACVehicleRelatedEmissions$City),
                                 sum)



ggplot(BalLACVehicleRelatedEmSum, aes(year, Emissions, label = round(Emissions, digits = 0), colour = city))+
  geom_point(alpha = 0.4, color = "Black")+
  geom_line(alpha = 0.7)+
  geom_text(check_overlap = TRUE, vjust = 1.5, hjust = 0.4)+
  xlab("Year")+
  ylab("Coal related PM2.5 emissions [tons]")+
  ggtitle("Total PM2.5 Vehicle-related emissions,\nBaltimore city vs Los Angeles County., 1999-2008")

dev.off()
