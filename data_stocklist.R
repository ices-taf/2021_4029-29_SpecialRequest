## Preprocess data, write TAF data tables

## Before:
## After:

library(icesTAF)
library(dplyr)

mkdir("data")

stocks <- read.taf(taf.data.path("stock_info", "stock_info.csv"))

requested_stocks <-
  stocks %>%
    by(
      stocks$area,
      function(x) {
        x <- unique(x$SpeciesCommonName)
        c(x, rep("", 5))[1:5]
      }
    ) %>%
    unclass() %>%
    do.call(what = 'cbind.data.frame') %>%
    select(
      "NORTH SEA",
      "NORTH WESTERN WATERS",
      "SOUTH WESTERN WATERS",
      "BALTIC SEA"
    )

requested_stocks

write.taf(requested_stocks, dir = "data")
