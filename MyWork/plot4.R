#Exploratory Data Analysis First Project Plot 4 R Script

#Download Data and unzip file
URLname<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(URLname,"PowerConsumptionData.zip",method="curl")
unzip("PowerConsumptionData.zip")

#Read Data in
filename="household_power_consumption.txt"
data<-read.delim(filename,header=TRUE,sep=";",na.strings="?")

#Combine Date and time into a single POSIXct column and save it in DateTime
#Also Put Dates and Times in Date and time classes
data$DateTime<-as.POSIXct(paste(data$Date,data$Time,sep=" "), format="%d/%m/%Y %H:%M:%S")
data$Date<-as.Date(data$Date, format="%d/%m/%Y")
data$Time<-strptime(data$Time, format="%H:%M:%S")

#Subset data to first two days in February of 2007
ourData<-data[data$Date==as.Date("2007/02/01")|data$Date==as.Date("2007/02/02"),]

#Create png device
png(filename="plot1.png",width=480, height=480,units="px")


# Plotting ----------------------------------------------------------------

#create four places to put graphs
par(mfrow=c(2,2))

#Plot the first graph against global power
plot(ourData$DateTime, ourData$Global_active_power,type="l", xlab="", ylab="Global Active Power")

#Plot the second graph agains voltage
plot(ourData$DateTime, ourData$Voltage,type="l", ylab="Voltage",xlab="datetime")

#Plot the third with all of the submetering as in plot3.R
plot(ourData$DateTime, ourData$Sub_metering_1,type="l", xlab="", ylab="Energy sub metering")
lines(ourData$DateTime,ourData$Sub_metering_2,col="red")
lines(ourData$DateTime,ourData$Sub_metering_3,col="blue")
legendText<-c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend(x="topright",legend=legendText, col=c("black","red","blue"),lty=1)

#Plot the final against reactive power
plot(ourData$DateTime, ourData$Global_reactive_power,type="l", ylab="Global_reactive_power",xlab="datetime")

#Close png device
dev.off()





