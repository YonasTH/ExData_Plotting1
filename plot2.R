## rough estimate of memory: 2,075,259 rows *9 columns * 8 bytes / 2^20 MB (i.e 142MB )
power_consumption <- read.csv2("power_consumption/household_power_consumption.txt",header=TRUE, na.strings="?")
#Convert time and date columns to POSIX classes and paste them into a single column
power_consumption$Date <- as.Date(power_consumption$Date, format="%d/%m/%Y")
power_consumption$Time <- strptime(power_consumption$Time)
sub_data <- power_consumption[power_consumption$Date=="2007-02-01"|power_consumption$Date=="2007-02-02", ]
sub_data$Date_Time <- paste(sub_data$Date, sub_data$Time)
#Add a column with abbreviated weekdays
#sub_data$Days <- weekdays(as.Date(sub_data$Date_Time), abbreviate=TRUE)

#plot2
##plotting X(type char) vs y(type numeric) gives error "need finite xlim"
##using as.Date instead of as.POSIXlt plots the points against Days only (variation with time of a day not shown)
png("plot2.png", width=480, height=480, units="px")
plot(as.POSIXlt(sub_data$Date_Time),as.numeric(as.character(sub_data$Global_active_power)),type="l", xlab="",ylab="Global Active Power (kilowatts)")
dev.off()