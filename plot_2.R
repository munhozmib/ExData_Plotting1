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

## Plot the data
plot(data$Global_active_power~data$datetime, type="l", 
     ylab="Global Active Power (kilowatts)", xlab="Day of the week")

## Save the plot as png!
dev.copy(png, "plot_2.png", width = 480, height = 480)
dev.off()