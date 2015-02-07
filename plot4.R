# plot4.R

if (!file.exists("power_consumption.zip")) {
	fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
	download.file(fileUrl, destfile = "power_consumption.zip", method = "curl")
	unzip("power_consumption.zip")
	# household_power_consumption.txt created	
}

data <- read.csv(file="household_power_consumption.txt",head=TRUE,sep=";",stringsAsFactors=F)

asDate <- as.Date(data$Date, format="%d/%m/%Y")
data$AsDate <- asDate

# 2007-02-01 and 2007-02-02
data1 <- subset(data, data$AsDate > as.Date("2007-01-31", format="%Y-%m-%d"))
data2 <- subset(data1, data1$AsDate < as.Date("2007-02-03", format="%Y-%m-%d"))

dtString <- paste(data2$Date, data2$Time)
dateTime <- strptime(dtString, format="%d/%m/%Y %H:%M:%S")
data2$DateTime <- dateTime

gap <- as.numeric(as.character(data2$Global_active_power))
data2$GlobalActivePower <- gap

png(filename="plot4.png")
par(mfrow = c(2, 2))

# Global active power
plot(data2$DateTime, data2$Global_active_power, type = "l", ylab="Global Active Power", xlab="")

# Voltage
plot(data2$DateTime, data2$Voltage, type = "l", ylab="Global Active Power", xlab="")

# Sub metering plot:
plot(data2$DateTime, data2$Sub_metering_1, type = "l", ylab="Energy sub metering", xlab="")
lines(data2$DateTime, y = data2$Sub_metering_2, type = "l", col="red")
lines(data2$DateTime, y = data2$Sub_metering_3, type = "l", col="blue")
legend("topright", pch = 1, col = c("black", "red", "blue"), 
	legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Global reactive power
plot(data2$DateTime, data2$Global_reactive_power, type = "l", ylab="Global Active Power", xlab="")

dev.off()
