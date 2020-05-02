## Download data and unzip files
if (!dir.exists("electric data")){
  dir.create("electric data")
}
if (!file.exists("electric data/electric_data.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","electric data")
}
if (!file.exists("electric data/household_power_consumption.txt")){
  unzip("electric data/electric_data.zip",exdir="electric data")
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
png("electric data/plot2.png",width=480,height=480,units="px")
plot(electric_selected$Time,electric_selected$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")
dev.off()