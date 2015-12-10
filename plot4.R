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
png(file = "./plot4.png")

# Setup layout
par(mfcol = c(2,2), mar = c(4,4,4,2), oma= c(0,0,0,0))

# First plot - Same as plot 2
plot(householdData$DateTime, householdData$Global_active_power, type="l", xlab="", ylab="Global Active Power")

# Second plot - Same as plot 3
with(householdData, plot(DateTime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
with(householdData, lines(DateTime, Sub_metering_2, col="red"))
with(householdData, lines(DateTime, Sub_metering_3, col="blue"))
legend("topright", lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")

# Third plot - Upper right
with(householdData, plot(DateTime, Voltage, type="l", xlab="datetime", ylab="Voltage"))

#Fourth plot - Lower right
with(householdData, plot(DateTime, Global_reactive_power, type="l", xlab="datetime"))

# Close png
dev.off()
