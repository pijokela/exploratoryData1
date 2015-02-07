# plot1.R

if (!file.exists("power_consumption.zip")) {
	fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
	download.file(fileUrl, destfile = "power_consumption.zip", method = "curl")
	unzip("power_consumption.zip")
	# household_power_consumption.txt created	
}

data <- read.csv(file="household_power_consumption.txt",head=TRUE,sep=";")

asDate <- as.Date(data$Date, format="%d/%m/%Y")
data$AsDate <- asDate

# 2007-02-01 and 2007-02-02
data1 <- subset(data, data$AsDate > as.Date("2007-01-31", format="%Y-%m-%d"))
data2 <- subset(data1, data1$AsDate < as.Date("2007-02-03", format="%Y-%m-%d"))

gap <- as.numeric(as.character(data2$Global_active_power))
data2$GlobalActivePower <- gap

png(filename="plot1.png")
hist(data2$GlobalActivePower, col="red", breaks=12, main="Global active power", ylab="Frequency", xlab="Global active power (kilowatts)")

