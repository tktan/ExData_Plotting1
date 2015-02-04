library(dplyr)
library(lubridate)

hpc <- read.csv("household_power_consumption.txt", sep=";", na.strings="?", header=TRUE)
hpc <- tbl_df(hpc)
hpc <- hpc %>%
  mutate(DateTime = dmy(Date) + hms(Time)) %>%
  filter(DateTime >= ymd_hms("2007-02-01 00:00:00") & DateTime <= ymd_hms("2007-02-02 23:59:59"))
png("plot2.png")
plot(hpc$DateTime, hpc$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)", main="")
dev.off()
