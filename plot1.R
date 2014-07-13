### This code expects the input zip file to be present in the working directory###

###Reading and formatting the data###
unzip("exdata-data-household_power_consumption.zip")
trim <- function (x) gsub("^\\s+|\\s+$", "", x)
test <- subset(read.table("household_power_consumption.txt",header=TRUE, sep=";"), 
as.character(trim(Date))=="1/2/2007" | as.character(trim(Date))=="2/2/2007")
test$Date <- as.Date(as.character(trim(test$Date)),"%d/%m/%Y")
test$datetime <- strptime(paste(test$Date, as.character(trim(test$Time))),format="%Y-%m-%d %H:%M:%S")
test$Global_active_power <- as.numeric(as.character(trim(test$Global_active_power)))
test$Global_reactive_power <- as.numeric(as.character(trim(test$Global_reactive_power)))
test$Voltage <- as.numeric(as.character(trim(test$Voltage)))
test$Global_intensity <- as.numeric(as.character(trim(test$Global_intensity)))
test$Sub_metering_1 <- as.numeric(as.character(trim(test$Sub_metering_1)))
test$Sub_metering_2 <- as.numeric(as.character(trim(test$Sub_metering_2)))
test$Sub_metering_3 <- as.numeric(as.character(trim(test$Sub_metering_3)))

###Opening the graphics device###
png(filename = "plot1.png", width = 480, height = 480)
###Creating the plot###
hist(test$Global_active_power, col = "red", main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency")
###Closing the graphics device###
dev.off()