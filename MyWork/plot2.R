#Exploratory Data Analysis First Project Plot 2 R Script

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

#Plot the Datetime against the Global active power changing the x/y labels and main to appropriate strings
plot(ourData$DateTime, ourData$Global_active_power,type="l", xlab="", ylab="Global Active Power (kilowatts)")

#Close png device
dev.off()