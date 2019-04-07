## First we'll start by reading the data in the file downloaded
data <- {read.table("household_power_consumption.txt", header=TRUE, sep=";",
                    na.strings = "?")}

## Secondly, we'll convert the Date column to the Date format
data$Date <- as.Date(data$Date, "%d/%m/%Y")

## Then we'll remove all the incomplete cases
data <- data[complete.cases(data),]

## In the fourth step, we'll filter our observations to the specified dates. 
## It should leave only 2880 observations in the dataset.
data <- subset(data, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## We'll work with days in the week, so we'll have to filter even further.
## We will combine the columns of Date and Time.
datetime <- paste(data$Date, data$Time)

## Give a name to the datetime vector
datetime <- setNames(datetime, "datetime")

## We'll then exclude the Date and Time columns and add our own column.
data <- data[ ,!(names(data) %in% c("Date", "Time"))]
data <- cbind(datetime, data)
data$datetime <- as.POSIXct(datetime)

## Use the par to adjust the parameters
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
## plot the graph
with(data, {
  plot(Global_active_power~datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~datetime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~datetime,col='Dark Red')
  lines(Sub_metering_3~datetime,col='Blue')})

## Add the legend to the top right corner of the lower left plot:
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
  legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Plot the fourth graph:
  plot(data$Global_reactive_power~data$datetime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")

## Save as PNG
dev.copy(png, "plot_4.png", height=480, width=480)
dev.off()