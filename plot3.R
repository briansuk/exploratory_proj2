library(ggplot2)

# Debug variable for development
debugT <- 0

# Check to see if the data sets exist. If not, load it in.
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
} 
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

# Aggregate the PM2.5 data points so we can graph it by year and type, specifically for fips 24510.
yearData <- aggregate(NEI$Emissions[NEI$fips == 24510], 
                      by = list(Year = NEI$year[NEI$fips == 24510], Type = NEI$type[NEI$fips == 24510]), 
                      FUN = sum)

# Factor the data
yearData$Year <- factor(yearData$Year, levels=unique(yearData$Year))
yearData$Type <- factor(yearData$Type, levels=unique(yearData$Type))

# Open PNG device
if(debugT == 0){
  png(filename = "~/exploratory_proj2/plot3.png")
}

# Create the line plot using qplot/ggplot2.
qplot(Year, y = x, data=yearData, group=Type, geom = "line", 
      color = Type, main = "Emmisions for Baltimore City by Emmission Type", 
      ylab = "Emmision Total")

# Close the PNG device, and release data for memory management
if(debugT == 0){
  dev.off()
}
rm(yearData)
if(exists("debugT")){
  rm(debugT)
}