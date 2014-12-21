# Debug variable for development
debugT <- 0

# Check to see if the data sets exist. If not, load it in.
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
} 
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

# Get SCC codes for values with "coal" in it, and subset NEI using that vector
sccCodes <- SCC$SCC[grepl("coal", SCC$EI.Sector, ignore.case = TRUE)]
subDF <- NEI[NEI$SCC %in% sccCodes,]

# Aggregate the PM2.5 data points so we can graph it by year.
yearData <- aggregate(subDF$Emissions, 
                      by = list(Year = subDF$year),
                      FUN = sum)

# Open PNG device
if(debugT == 0){
  png(filename = "~/exploratory_proj2/plot4.png")
}

# Create the line plot using qplot/ggplot2.
qplot(Year, y = x, data=yearData, geom = "line", 
      main = "Emmisions for Coal", 
      ylab = "Emmision Total")

# Close the PNG device, and release data for memory management
if(debugT == 0){
  dev.off()
}
if(exists("debugT")){
  rm(debugT)
}
rm(yearData)
rm(subDF)
rm(sccCodes)
