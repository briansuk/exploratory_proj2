# Check to see if the data sets exist. If not, load it in.
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
} 
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

# Aggregate the PM2.5 data points so we can graph it by year, specifically for fips 24510.
yearData <- aggregate(NEI$Emissions[NEI$fips == 24510], 
                      by = list(Year = NEI$year[NEI$fips == 24510]), 
                      FUN = sum)

# Open PNG device
png(filename = "~/exploratory_proj2/plot2.png")

# Create the line plot using the base plot.
plot(yearData$Year, yearData$x, type = "o", ylab = "Total PM2.5", xlab = "Year", 
     main = "Total PM2.5 for All Sources by Year for fips 24510")

# Close the PNG device, and release yearData for memory management
dev.off()
rm(yearData)