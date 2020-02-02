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

print(as.character(data$Date))

data <-subset(data, as.character(Date) == '1/2/2007' | as.character(Date) == '2/2/2007')


data$Time <- paste(data$Date, ' ', data$Time)

data$Time <- strptime(data$Time, '%d/%m/%Y %H:%M:%S')

head(data)


#make the plot
png(filename="plot2.png", width = 480, height = 480)
plot(data$Time, data$Global_active_power, xlab= '', ylab='Global Active Power (kilowatts)', type="l")
dev.off()
