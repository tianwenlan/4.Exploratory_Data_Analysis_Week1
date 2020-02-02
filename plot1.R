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

data$Date <- as.Date(as.character(data$Date), "%d/%m/%Y")

data <-subset(data, Date == as.Date('1/2/2007', "%d/%m/%Y") | Date == as.Date('2/2/2007', "%d/%m/%Y"))

print(data)
data$Time <- format(strptime(data$Time, '%H:%M:%S'), "%H:%M:%S")

head(data)


#make the plot
png(filename="plot1.png", width = 480, height = 480)
hist(data$Global_active_power, main = 'Global Active Power', xlab='Global Active Power (kilowatts)', ylab='Frequency', col="red")
dev.off()
