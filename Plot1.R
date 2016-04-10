#################################################################
## Coursera Course "Explorative Data Analysis" Project 1 Plot1 ##
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


# Create & Save Plot
png(paste0(output_data_location, "/Plot1.png"))
hist(energy_data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency" )
dev.off()


# Clean up
rm(input_data_location, output_data_location, energy_data)
