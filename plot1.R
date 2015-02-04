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

png("plot1.png")  # default width=480, height=480
hist(hpc$Global_active_power, col="red",
     xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()
