library(dplyr)
#step 0: downlaod files

zipUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile <- "household_power_consumption.zip"

if (!file.exists(zipFile)) {
  download.file(zipUrl, zipFile, mode = "wb")
}

# unzip zip file containing data if data directory doesn't already exist
dataPath <- "household_power_consumption"
if (!file.exists(dataPath)) {
  unzip(zipFile)
}


#read the file to data, subset the data, convert date and time
data <-read.table('household_power_consumption.txt', sep=';', header=T, na.strings = "?")

#data$Date <- as.Date(as.character(data$Date), "%d/%m/%Y")

#print(as.character(data$Date))

data <-subset(data, as.character(Date) == '1/2/2007' | as.character(Date) == '2/2/2007')

data$Time <- paste(data$Date, ' ', data$Time)

data$Time <- strptime(data$Time, '%d/%m/%Y %H:%M:%S')


#make the plot
png(filename="plot4.png", width = 480, height = 480)

par(mfrow=c(2,2))

#plot(1,1)
plot(data$Time, data$Global_active_power, xlab= '', ylab='Global Active Power', type="l")

#plot(1,2)
plot(data$Time, data$Voltage, xlab= 'datetime', ylab='Voltage', type="l")

#plot(2,1)

colors = c('black', 'red', 'blue')

plot(data$Time, data$Sub_metering_1, xlab= '', ylab='Energy sub metering', type="l", col = colors[1])
points(data$Time, data$Sub_metering_2, xlab= '', type="l", col = colors[2])
points(data$Time, data$Sub_metering_3, xlab= '', type="l", col = colors[3])
legend('topright', lty =1, bty = 'n', legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col=colors)

#plot(2,2)

plot(data$Time, data$Global_reactive_power, xlab= 'datetime', ylab='Voltage', type="l")

dev.off()
