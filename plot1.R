allData <- read.delim("./household_power_consumption.txt", sep=";",stringsAsFactors=FALSE)
library(dplyr)
library(datasets)

## Filter out only what we need to make things smaller
householdData <- filter(allData, Date == '1/2/2007' | Date == '2/2/2007')

## Add a DateTime column
householdData$DateTime <- as.POSIXct(paste(householdData$Date, householdData$Time), format="%d/%m/%Y %H:%M:%S")
## householdData$Date <- as.Date(householdData$Date, "%d/%m/%y")

## Convert other columns to numeric
householdData[, c(3:9)]<- sapply(householdData[, c(3:9)], as.character)
householdData[, c(3:9)]<- sapply(householdData[, c(3:9)], as.numeric)

# Reset any existing graphics
graphics.off()

# Copy out to png file
png(file = "./plot1.png")

# Plot with appropriate labeling
hist(householdData$Global_active_power, main="Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)")

# Close png
dev.off()



