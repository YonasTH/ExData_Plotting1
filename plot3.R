## rough estimate of memory: 2,075,259 rows *9 columns * 8 bytes / 2^20 MB (i.e 142MB )
power_consumption <- read.csv2("power_consumption/household_power_consumption.txt",header=TRUE, na.strings="?")
#Convert time and date columns to POSIX classes and paste them into a single column
power_consumption$Date <- as.Date(power_consumption$Date, format="%d/%m/%Y")
power_consumption$Time <- strptime(power_consumption$Time)
sub_data <- power_consumption[power_consumption$Date=="2007-02-01"|power_consumption$Date=="2007-02-02", ]
sub_data$Date_Time <- paste(sub_data$Date, sub_data$Time)
#Add a column with abbreviated weekdays
#sub_data$Days <- weekdays(as.Date(sub_data$Date_Time), abbreviate=TRUE)

#plot3
#the values of the sub_metering columns are not shown correctly( they are factors), convert to numeric
#the values are converted to factors by default when using readcsv2.
#This could have been corrected with readcsv2(as.is=...., or colClasses="numeric")
png("plot3.png", width=480, height=480, units="px")
plot(as.POSIXlt(sub_data$Date_Time),as.numeric(as.character(sub_data$Sub_metering_1)),type="n", xlab="",ylab="Energy sub metering")
points(as.POSIXlt(sub_data$Date_Time),as.numeric(as.character(sub_data$Sub_metering_1)),type="l", col= "black")
points(as.POSIXlt(sub_data$Date_Time),as.numeric(as.character(sub_data$Sub_metering_2)),type="l", col= "red")
points(as.POSIXlt(sub_data$Date_Time),as.numeric(as.character(sub_data$Sub_metering_3)),type="l", col= "blue")
legend("topright", lty=c(1,1,1), col=c("black", "red", "blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
#using plot instead of points shows only the last plot