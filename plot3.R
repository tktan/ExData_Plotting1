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

png("plot3.png")  # default width=480, height=480
plot(hpc$DateTime, hpc$Sub_metering_1, type="l", col="black",  # Sub_metering_1
     xlab="", ylab="Energy sub metering", main="")
lines(hpc$DateTime, hpc$Sub_metering_2, type="l", col="red")   # Sub_metering_2
lines(hpc$DateTime, hpc$Sub_metering_3, type="l", col="blue")  # Sub_metering_3
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd=1, col=c("black", "red", "blue"))
dev.off()
