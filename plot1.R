# Overall assignment Requirements:
# Reconstruct the given plots all of which were constructed using the base plotting system.
# 1. Each plot should be saved as a PNG file with a width of 480 pixels and a height of 480 pixels
# 2. Name of each plot files is plot1.png, plot2.png, etc.
# 3. A separate R code file (plot1.R, plot2.R, etc.) corresponds the plot.png 
#    i.e. code in plot1.R constructs the plot1.png plot.
#    The code file includes code for reading the data so that the plot can be fully reproduced.
#    The code file includes the code that creates the PNG file.
# 4. The PNG file and R code file are pushed to the top-level folder of a github repository

# Data Set:
# This assignment uses data from the UC Irvine Machine Learning Repository
# We will be using the Individual household electric power consumption Data Set
# The data set can be downloaded from the following link:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

# Data Set Description:
# Measurements of electric power consumption in one household with a one-minute sampling 
# rate over a period of almost 4 years. 
# Different electrical quantities and some sub-metering values are available.


# Plots:
# Plot 1 is a histogram plot of Frequency and killowats
# Plot 2 is a line graph of kilotwatts by time with points at days of the week 
# Plot 3 is a line graph of energy submetering by time with points at days of the week  including a legend
# Plot 4 contains 4 charts in a 2X2 format. 
#   plot 4a in the upper left is a line graph of kilotwatts by time (similar to plot 2)
#   plot 4b in the lower left is a line graph of energy submetering by time including a legend (similar to plot 3)
#   plot 4c in the upper right is a line graph of voltage by time with points at days of the week 
#   plot 4d in the lower right is a line graph of reactive power by time with points at days of the week 

# Prerequisites

# > .Platform$OS.type
# [1] "windows"

# > R.version
#               _                           
# platform       x86_64-w64-mingw32          
# arch           x86_64                      
# os             mingw32                     
# system         x86_64, mingw32             
# status                                     
# major          3                           
# minor          4.1                         
# year           2017                        
# month          06                          
# day            30                          
# svn rev        72865                       
# language       R                           
# version.string R version 3.4.1 (2017-06-30)
# nickname       Single Candle    

# # Set the Working Directory
setwd("~/DataScience")

# download a zip file containing household electric power consumption data. 
# Set the target file name and save it to the working directory.
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="household_power_consumption.zip")

# unzip the destination file in the working directory
unzip("household_power_consumption.zip")

# A visual observation of the unzip shows a file household_power_consumption.txt is created.
# There are nine variables in the file with 2,075,259 observations.
# The file contains a header row. The seperation character is a semi-colon ;
# The variables are descibed below
# 1. Date: Date in format dd/mm/yyyy
# 2. Time: time in format hh:mm:ss
# 3. Global_active_power: household global minute-averaged active power (in kilowatt)
# 4. Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
# 5. Voltage: minute-averaged voltage (in volt)
# 6. Global_intensity: household global minute-averaged current intensity (in ampere)
# 7. Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
# 8. Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
# 9. Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.

# The first requirement is to perform a rought calculation on how much memory is required to read the file into R. 
# Columns*Rows*bytes
# 9*2075259*8=149418648 ~ 150MB

# first we will load the data set
data <- read.table("~/DataScience/household_power_consumption.txt", 
                   header=TRUE, 
                   sep=";",
                   na.strings = "?",
                   stringsAsFactors=FALSE)


# actual size
object.size(data) # 133003464 bytes ~133 MB. 
# Our calculation was a little high but fine. 

# for improved plotting we add a new column to the data set with both date and timestamp
datewtime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
data <- cbind(datewtime, data)
# We convert the date columns to data use during plotting.
data$Date <- as.Date(data$Date,format="%d/%m/%Y")

# Remove nulls
dataclean <- data[complete.cases(data),]

# We will only be using data from the dates 2007-02-01 and 2007-02-02
# so we can filter the data set
dataf <- dataclean[(dataclean$Date=="2007-02-01") | (dataclean$Date=="2007-02-02"),]


# Now that we have a tidy data set we can start plotting

# The code below is for plot1
hist(dataf$Global_active_power, freq=TRUE,
     xlab="Global Active Power (kilowatts)",
     col="red", main="Global Active Power")

# Now we create a png image file and close the PNG device
dev.copy(png, file = "plot1.png", width=480,height=480,units="px")
dev.off()
