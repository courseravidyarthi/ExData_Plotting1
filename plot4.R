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
png(filename = "plot4.png", width = 480, height = 480)
###Creating the plot###
par(mfrow=c(2,2))
#Plot in upper left corner#
plot(test$datetime, test$Global_active_power, type="l", xlab="", ylab="Global Active Power")
#Plot in upper right corner#
plot(test$datetime, test$Voltage, type="l", xlab="datetime", ylab="Voltage")
#Plot in lower left corner#
with(test, {
             plot(datetime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", col="black")
             lines(datetime, Sub_metering_2, type="l", col="red")
             lines(datetime, Sub_metering_3, type="l", col="blue")
             legend("topright", bty="n", lty=1, col = c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
           }
    )
#Plot in lower right corner#
plot(test$datetime, test$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
###Closing the graphics device###
dev.off()