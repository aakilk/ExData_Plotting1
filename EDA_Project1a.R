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

# Generate First Plot
dev.new()
with(hpcDataFinal,hist(Global_active_power, col = "red",main = "Global Active Power",xlab = "Global Active Power (kilowatts)",ylab="Frequency"))
dev.copy(png,"./EDA-P1/plot1.png",width = 480, height = 480)
dev.off()