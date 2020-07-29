## download data, name variables, subset by the dates we need to look at 
power <- read.table("household_power_consumption.txt",skip=1,sep=";")
names(power) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
correctdates <- subset(power, power$Date=="1/2/2007"| power$Date=="2/2/2007")


## Create column in table with date and time merged together
TimeDate <- strptime(paste(correctdates$Date, correctdates$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
correctdates <- cbind(correctdates, TimeDate)

## Convert to numeric
correctdates$Global_active_power <- as.numeric(correctdates$Global_active_power)
correctdates$Sub_metering_1 <- as.numeric(correctdates$Sub_metering_1)
correctdates$Sub_metering_2 <- as.numeric(correctdates$Sub_metering_2)
correctdates$Sub_metering_3 <- as.numeric(correctdates$Sub_metering_3)

## convert Time from character to POSIXlt
correctdates$Time <- format(correctdates$Time, format = "%H:%M:%S")

## convert Date from character to Date
correctdates$Date <- as.Date(correctdates$Date, format = "%d/%m/%Y")

## organize plots
par(mfcol = c(2, 2))

## 1plot global active power vs datetime
with(correctdates, plot(TimeDate, Global_active_power, type="l", xlab=" ", ylab="Global Active Power"))

## 2plot energy sub_metering_1 vs timedate
with(correctdates, plot(TimeDate, Sub_metering_1, type="l", xlab=" ", ylab= "Energy sub metering"))

## add sub_metering_2 to plot
lines(TimeDate, correctdates$Sub_metering_2, col = "red")

## add sub_metering_3 to plot
lines(TimeDate, correctdates$Sub_metering_3, col = "blue")

## add legend 
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),col = c("black", "red", "blue"), lty = 1, bty = "n")

## 3plot datetime by voltage
with(correctdates, plot(TimeDate, correctdates$Voltage, type = "l", xlab= "datetime", ylab = "Voltage"))

## 4plot datetime by Global_reactive_power
with(correctdates, plot(TimeDate, correctdates$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power"))

## create png
dev.copy(png, 'plot4.png')
dev.off()
