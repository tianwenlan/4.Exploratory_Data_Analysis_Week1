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
png(filename="plot3.png", width = 480, height = 480)
colors = c('black', 'red', 'blue')

plot(data$Time, data$Sub_metering_1, xlab= '', ylab='Energy sub metering', type="l", col = colors[1])
points(data$Time, data$Sub_metering_2, xlab= '', type="l", col = colors[2])
points(data$Time, data$Sub_metering_3, xlab= '', type="l", col = colors[3])
legend('topright', lty =1, legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col=colors)
dev.off()
