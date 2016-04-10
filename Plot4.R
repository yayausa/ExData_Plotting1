#################################################################
## Coursera Course "Explorative Data Analysis" Project 1 Plot4 ##
## To run the script please change the input_data_location and ##
## output_data_location to the appropriate directories and     ##
## fileon your computer.                                       ##
## Please use the directory with the unziped txt file.         ##
#################################################################

# Specify paths
input_data_location <- "D:/Dropbox/Coursera/Data Science Specialization/4. Exploratory Data Analysis/Project1/household_power_consumption.txt"
output_data_location <- "D:/Dropbox/Coursera/Data Science Specialization/4. Exploratory Data Analysis/Project1/git"

# Import only needed data and recoding ? to NA
library(data.table)
energy_data <- fread(input_data_location, header = TRUE, sep = ";", na.strings = "?")

# Subset dataset
energy_data <- energy_data[energy_data$Date == "1/2/2007" | energy_data$Date == "2/2/2007",]

# Cleaning data 
## Recoding Data & Time with strptime() & as.Date()  
energy_data$Date <- as.Date(strptime(energy_data$Date, "%d/%m/%Y"))
energy_data$Date_Time <- as.POSIXct(paste(energy_data$Date, energy_data$Time), format = "%Y-%m-%d %H:%M:%S")

# Set locale time to english for english weekdays in plot
original_settings <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "C")

# Create & Save Plot
png(paste0(output_data_location, "/Plot4.png"))
par(mfrow = c(2, 2))

# Plot top left
plot(energy_data$Date_Time, energy_data$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "" )

# Plot top right
plot(energy_data$Date_Time, energy_data$Voltage, type = "l", ylab = "Voltage", xlab = "datetime" )

# Plot bottom left
plot(energy_data$Date_Time, energy_data$Sub_metering_1, col = "black", type = "l", ylab = "Energy sub metering", xlab = "" )
lines(energy_data$Date_Time, energy_data$Sub_metering_2, col = "red", type = "l")
lines(energy_data$Date_Time, energy_data$Sub_metering_3, col = "blue", type = "l")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, bty = "n")

# Plot bottom right
plot(energy_data$Date_Time, energy_data$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime" )

dev.off()


# Clean up
Sys.setlocale("LC_TIME",original_settings)
rm(input_data_location, output_data_location, energy_data, original_settings)
