library(sqldf)
my_string = "select * from file where Date in ('1/2/2007', '2/2/2007')"
my_data <- read.csv.sql("household_power_consumption.txt", sql = my_string, sep = ";")
dtm <- paste(my_data[,1], my_data[,2])
# convert from factor to date
dtm <- strptime(dtm, format = "%d/%m/%Y %H:%M:%S")
# obtain a new data frame with dtm as the first column
hhpc <- cbind(dtm, my_data[,3:9])
# open the PNG file device
png(filename = "plot1.png")
# create the plot
hist(hhpc$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
# close the PNG file device
dev.off()
