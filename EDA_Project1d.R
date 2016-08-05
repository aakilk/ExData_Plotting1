# Load necessary libraries
library(data.table)

# Create Local Data Directory
if (!file.exists("./EDA-P1")){
  dir.create("EDA-P1")
}

# Download Zip File
if (!file.exists("./EDA-P1/household_power_consumption.zip")){
  fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl,destfile="./EDA-P1/household_power_consumption.zip", mode="wb")
}

# Unzip the household power consumption dataset
unzip (zipfile ="./EDA-P1/household_power_consumption.zip",exdir = "./EDA-P1")

# Household Power Consumption Dataset 
hpcData <- "./EDA-P1/household_power_consumption.txt"

hpcTable <- read.table(hpcData,header=TRUE,sep=";",na.strings="?")
hpcDataFinal<- subset(hpcTable,Date %in% c("1/2/2007","2/2/2007"))

dateAndTime <- strptime(paste(hpcDataFinal$Date,hpcDataFinal$Time,sep=" "),"%d/%m/%Y %H:%M:%S")

#Generate Fourth Plot
dev.new()
colors <- c("black","red","blue")
plotLabels <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
# Create Plot for Graphs as 2 x 2 
par(mfrow=c(2,2))

# Plot Global Active Power vs Date and Time
with(hpcDataFinal,plot(dateAndTime,Global_active_power,type="l",col="green", xlab="",ylab="Global Active Power"))

# Plot Voltage vs Date and Time
with(hpcDataFinal,plot(dateAndTime,Voltage, type = "l",xlab="datetime",ylab="voltage"))

# Same as Plot 3
with(hpcDataFinal,plot(dateAndTime,Sub_metering_1,type='l',col="black",xlab="",ylab="Energy sub metering"))
with(hpcDataFinal,lines(dateAndTime,Sub_metering_2,col="red"))
with(hpcDataFinal,lines(dateAndTime,Sub_metering_3,col="blue"))
legend("topright",bty="n",legend=plotLabels,col = colors,lty = "solid")

# Plot Global reactive power vs. Date and Time
with(hpcDataFinal,plot(dateAndTime,Global_reactive_power,type='l',col="blue",xlab="datetime",ylab="Global_reactive_power"))
dev.copy(png,"./EDA-P1/plot4.png",width = 480, height = 480)
dev.off()