## Download data and unzip files
if (!file.exists("electric_data.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","electric_data.zip")
}
if (!file.exists("household_power_consumption.txt")){
  unzip("electric_data.zip")
}
## Read data
electric<- read.table("electric data/household_power_consumption.txt",sep=";",header=T,na.strings = "?")
## Change Date observations into Date objects
electric$Date<-as.Date(electric$Date,"%d/%m/%Y")
## Select data from the dates 2007-02-01 and 2007-02-02
electric_selected <- subset(electric, Date == as.Date("2007-02-01","%Y-%m-%d")|Date == as.Date("2007-02-02","%Y-%m-%d"))
## Change Time observations into Time objects 
date_and_time<- paste(electric_selected$Date,electric_selected$Time)
date_and_time<-strptime(date_and_time,"%Y-%m-%d %H:%M:%S")
electric_selected$Time<-date_and_time
## Generate the plot
png("plot4.png",width=480,height=480,units="px")
par(mfrow=c(2,2))
plot(electric_selected$Time,electric_selected$Global_active_power,type="l",xlab="",ylab="Global Active Power")
plot(electric_selected$Time,electric_selected$Voltage,type="l",xlab="datetime",ylab="Voltage")
plot(electric_selected$Time,electric_selected$Sub_metering_1,type="l",xlab="",col="black",ylab="Energy sub metering")
lines(electric_selected$Time,electric_selected$Sub_metering_2, col="red")
lines(electric_selected$Time,electric_selected$Sub_metering_3, col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=c(1,1,1),cex=0.8)
plot(electric_selected$Time,electric_selected$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")
dev.off()