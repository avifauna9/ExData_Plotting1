
## download data, name variables, subset by the dates we need to look at 
power <- read.table("household_power_consumption.txt",skip=1,sep=";")
names(power) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
correctdates <- subset(power, power$Date=="1/2/2007"| power$Date=="2/2/2007")

## convert to numeric, plot hist, alter labels, create png 
GlobalActivePower <- correctdates$Global_active_power
GlobalActivePower <- as.numeric(GlobalActivePower)
hist(GlobalActivePower, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red")
dev.copy(png, 'plot1.png')
dev.off()
