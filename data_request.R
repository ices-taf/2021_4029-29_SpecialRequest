

library(icesTAF)
library(dplyr)

mkdir("data")

request <- read.taf(taf.data.path("request.csv"))

# only need keep the first three columns
stock_summary <-
  request %>%
  select(Region, Species, Stock)

# write out for use in report
write.taf(stock_summary, dir = "data")
