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

## For the first plot, then, we will create the histogram
hist(data$Global_active_power, main="Global Active Power", xlab = "Global Active
     Power (kilowatts)", col = "dark red")

## Lastly, to save the plot as a PNG file:
dev.copy(png, "plot_1.png", width=480, height=480)
dev.off()