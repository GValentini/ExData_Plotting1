library(sqldf)
Sys.setlocale("LC_TIME", "English_United States.1252")
my_string = "select * from file where Date in ('1/2/2007', '2/2/2007')"
my_data <- read.csv.sql("household_power_consumption.txt", sql = my_string, sep = ";")
dtm <- paste(my_data[,1], my_data[,2])
## convert from factor to date
dtm <- strptime(dtm, format = "%d/%m/%Y %H:%M:%S")
## obtain a new data frame with dtm as the first column
hhpc <- cbind(dtm, my_data[,3:9])
## open the PNG file device
png(filename = "plot4.png")
## create the plot
par(mfrow = c(2, 2))
# topleft plot
with(hhpc, plot(dtm, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))
# topright plot
with(hhpc, plot(dtm, Voltage, type = "l", xlab = "datetime"))
# bottomleft plot
with(hhpc, {
  plot(dtm, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
  lines(dtm, Sub_metering_2, type = "l", col = "red")
  lines(dtm, Sub_metering_3, type = "l", col = "blue")
})
legend("topright", bty = "n", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# bottomright plot
with(hhpc, plot(dtm, Global_reactive_power, type = "l", xlab = "datetime"))
## close the PNG file device
dev.off()
