library(dplyr)
library(lubridate)

hpc <- read.csv("household_power_consumption.txt",
                sep=";",         # semi-colon separated values
                na.strings="?",  # missing values are coded as "?"
                header=TRUE)
hpc <- tbl_df(hpc)
hpc <- hpc %>%
  mutate(DateTime = dmy(Date) + hms(Time)) %>%
  filter(DateTime >= ymd_hms("2007-02-01 00:00:00") &  # using data from
         DateTime <= ymd_hms("2007-02-02 23:59:59"))   # 2007-02-01 to 2007-02-02

png("plot4.png")  # default width=480, height=480
par(mfrow=c(2, 2),              # 2x2 plot
    mar=c(5.1, 4.1, 3.6, 2.1))  # slightly decrease top margin to match model plot

# plot c(1, 1)
plot(hpc$DateTime, hpc$Global_active_power, type="l",
     xlab="", ylab="Global Active Power")

# plot c(1, 2)
plot(hpc$DateTime, hpc$Voltage, type="l", xlab="datetime", ylab="Voltage")

# plot c(2, 1)
plot(hpc$DateTime, hpc$Sub_metering_1, type="l", col="black",
     xlab="", ylab="Energy sub metering", main="")
lines(hpc$DateTime, hpc$Sub_metering_2, type="l", col="red")
lines(hpc$DateTime, hpc$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd=1, col=c("black", "red", "blue"),
       box.col="transparent")  # make bounding box transparent to match model plot

# plot c(2, 2)
plot(hpc$DateTime, hpc$Global_reactive_power, type="l",
     xlab="datetime", ylab="Global_reactive_power")

dev.off()
