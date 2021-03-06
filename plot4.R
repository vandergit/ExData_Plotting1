plot4 <- function() {
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
  par(mfcol = c(2,2))
  with(data_sub, {
    plot(Time, Global_active_power, type = "l", ylab = "Global Active Power")
    with(data_sub, {
      plot(Time, Sub_metering_1, type = "l", ylab = "Energy sub metering")
      lines(Time, Sub_metering_2, type = "l", col = "red")
      lines(Time, Sub_metering_3, type = "l", col = "blue")
      legend("topright", c(names(data_sub)[7],names(data_sub)[8],names(data_sub)[9]), lty = c(1,1,1), col = c("black","red","blue"), cex = 0.65, xjust = 0, y.intersp = 0.65, bty = "n")
    })
    plot(Time, Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
    plot(Time, Global_reactive_power, type = "l", xlab = "datetime", ylab = names(data_sub)[4])
  })
  
  # Copy to file
  dev.copy(png,"plot4.png", width = 480, height = 480)
  dev.off()
}