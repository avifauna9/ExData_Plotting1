## download data, name variables, subset by the dates we need to look at 
power <- read.table("household_power_consumption.txt",skip=1,sep=";")
names(power) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
correctdates <- subset(power, power$Date=="1/2/2007"| power$Date=="2/2/2007")

## Create column in table with date and time merged together
TimeDate <- strptime(paste(correctdates$Date, correctdates$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
correctdates <- cbind(correctdates, TimeDate)

## convert to numeric
GlobalActivePower <- correctdates$Global_active_power
correctdates$Global_active_power <- as.numeric(GlobalActivePower)

## convert Time from character to POSIXlt
correctdates$Time <- format(correctdates$Time, format = "%H:%M:%S")

## convert Date from character to Date
correctdates$Date <- as.Date(correctdates$Date, format = "%d/%m/%Y")

## plot global active power vs datetime
with(correctdates, plot(TimeDate, Global_active_power, type="l", xlab=" ", ylab="Global Active Power (kilowatts)"))

## create png
dev.copy(png, 'plot2.png')
dev.off()

