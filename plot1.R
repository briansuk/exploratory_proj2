# Check to see if the data sets exist. If not, load it in.
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
} 
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

# Aggregate the PM2.5 data points so we can graph it by year.
yearData <- aggregate(NEI$Emissions, 
                      by = list(Year = NEI$year[NEI$year==1999|NEI$year==2002|NEI$year==2005|NEI$year==2008]), 
                      FUN = sum)

# Open PNG device
png(filename = "~/exploratory_proj2/plot1.png")

# Create the line plot using the base plot.
plot(yearData$Year, yearData$x, type = "o", ylab = "Total PM2.5", xlab = "Year", main = "Total PM2.5 by Year")

# Close the PNG device
dev.off()