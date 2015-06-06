## rough estimate of memory: 2,075,259 rows *9 columns * 8 bytes / 2^20 MB (i.e 142MB )
power_consumption <- read.csv2("power_consumption/household_power_consumption.txt",header=TRUE, na.strings="?")
#Convert time and date columns to POSIX classes and paste them into a single column
power_consumption$Date <- as.Date(power_consumption$Date, format="%d/%m/%Y")
power_consumption$Time <- strptime(power_consumption$Time)
sub_data <- power_consumption[power_consumption$Date=="2007-02-01"|power_consumption$Date=="2007-02-02", ]
sub_data$Date_Time <- paste(sub_data$Date, sub_data$Time)
#Add a column with abbreviated weekdays
#sub_data$Days <- weekdays(as.Date(sub_data$Date_Time), abbreviate=TRUE)

#plot4
png("plot4.png", width=480, height=480, units="px")
par(mfcol=c(2,2))
with(sub_data, {
  plot(as.POSIXlt(sub_data$Date_Time),as.numeric(as.character(sub_data$Global_active_power)),type="l", xlab="",ylab="Global Active Power (kilowatts)")
  plot(as.POSIXlt(sub_data$Date_Time),as.numeric(as.character(sub_data$Sub_metering_1)),type="n", xlab="",ylab="Energy sub metering")
  points(as.POSIXlt(sub_data$Date_Time),as.numeric(as.character(sub_data$Sub_metering_1)),type="l", col= "black")
  points(as.POSIXlt(sub_data$Date_Time),as.numeric(as.character(sub_data$Sub_metering_2)),type="l", col= "red")
  points(as.POSIXlt(sub_data$Date_Time),as.numeric(as.character(sub_data$Sub_metering_3)),type="l", col= "blue")
  legend("topright", bty="n",lty=c(1,1,1), col=c("black", "red", "blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  plot(as.POSIXlt(sub_data$Date_Time),as.numeric(as.character(sub_data$Voltage)),type="l", xlab="datetime", ylab="Voltage")
  plot(as.POSIXlt(sub_data$Date_Time),as.numeric(as.character(sub_data$Global_reactive_power)),type="l", xlab="datetime", ylab="Global_reactive_power")
}
)
dev.off()