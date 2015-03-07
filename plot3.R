# Set Working Directory
setwd("./DataSci_coursera/ExploratoryDA/CourseProject01/ExData_Plotting1")

# Use sqldf package to select out only 
# the two needed dates out of the large file
library("sqldf")

dta <- read.csv.sql("household_power_consumption.txt", sep = ";", 
                    sql = paste0('select * from file where ',
                                 'Date = "1/2/2007" OR Date = "2/2/2007"'))

# Convert to POSIXlt
dta$Date <- paste(dta$Date, dta$Time)
dta$Date <- strptime(dta$Date, format = "%d/%m/%Y %H:%M:%S")
colnames(dta) <- c("datetime", colnames(dta)[-1])
dta <- subset(dta, select = -Time)

png("plot3.png", bg = "transparent")
with(dta, plot(datetime, Sub_metering_1, type = "l", xlab = "", 
               ylab = "Energy sub metering"))
with(dta, lines(x = datetime, y = Sub_metering_2, , col = "red"))
with(dta, lines(x = datetime, y = Sub_metering_3, col = "blue"))
legend("topright", colnames(dta)[6:8], lty = 1, col = c("black", "red", "blue"))
dev.off()