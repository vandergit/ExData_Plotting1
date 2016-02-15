plot2 <- function() {
  library(data.table)
  
  # Determining classes to improve fread efficiency
  data5   <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", nrows = 5)
  classes <- sapply(data5,class)
  
  # Reading data, subsetting based on date required, modifying time column and formatting columns
  data_all      <- fread("./household_power_consumption.txt", header = TRUE, sep = ";", colClasses = classes, na.strings = "?", stringsAsFactors = FALSE)
  data_sub      <- subset(data_all, data_all$Date == "1/2/2007" | data_all$Date == "2/2/2007")
  data_sub$Time <- paste(data_sub$Date, data_sub$Time)
  data_sub$Date <- as.Date(data_sub$Date, "%d/%m/%Y")
  data_sub$Time <- as.POSIXct(data_sub$Time, format="%d/%m/%Y %H:%M:%S")
  
  dev.new()
  
  # Plotting Graphics
  with(data_sub, plot(Time, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)"))
  
  # Copy to file
  dev.copy(png,"plot2.png", width = 480, height = 480)
  dev.off()
}