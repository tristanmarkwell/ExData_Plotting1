##download zip file
download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', 'data.zip')
##unzip folder
unzip('data.zip')
##read data
data <- read.table('household_power_consumption.txt',sep=';', na.strings='?',header=TRUE,
                   colClasses=c('character','character','numeric','numeric',
                                'numeric','numeric','numeric','numeric','numeric'))
##subset to 2/1/2007 and 2/2/2007 - note date string is in d/m/yyyy format
subset <- data[data$Date == '1/2/2007' | data$Date == '2/2/2007' ,]
##create datetime column
subset$DateTime <- strptime(paste(subset$Date,' ',subset$Time),format='%d/%m/%Y %H:%M:%S')
##open PNG device
png(filename='plot3.png', width=480, height=480)
##draw empty plot
plot(subset$DateTime, subset$Sub_metering_1, type='n',
     xlab='', ylab='Energy sub metering')
##add lines for each sub metering
lines(subset$DateTime, subset$Sub_metering_1, col='black')
lines(subset$DateTime, subset$Sub_metering_2, col='red')
lines(subset$DateTime, subset$Sub_metering_3, col='blue')
##add legend
legend('topright',c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
       lty=c(1,1,1),col=c('black','red','blue'))
##close PNG device
dev.off()
