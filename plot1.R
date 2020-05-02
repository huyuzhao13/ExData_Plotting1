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
## Generate the histogram
png("plot1.png",width=480,height=480,units="px")
hist(electric_selected$Global_active_power,xlab="Global Active Power (kilowatts)",col="red",main="Global Active Power")
dev.off()