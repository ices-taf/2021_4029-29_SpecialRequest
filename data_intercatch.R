## Preprocess data, write TAF data tables

## Before:
## After:

library(icesTAF)
library(data.table)
library(dplyr)

# CATON catch one record per stratum
# CANUM WECA numbers and mean weight at age or length per age or length (CATON is repeated for each age or length)

# get ic data
ic <-
  fread(
    taf.data.path(
      "intercatch",
      "2019 06 22 WGMIXFISH CANUM WECA for stocks with distributions all WG 2002 2019.csv"
    )
  )

# filter only age data and clean of by fleet names
intercatch <-
  ic %>%
  filter(CANUMType == "Age") %>%
  rename(
    year = Datayear, stock_code = Stock, age = ageorlength, catage = CANUM
  ) %>%
  select(
    stock_code, year, age, Fleet, catage
  ) %>%
  mutate(
    Fleet =
      Fleet %>%
      gsub("^OTB-DEF$", "OTB_DEF", .) %>%
      gsub("^OTT-CRU$", "OTT_CRU", .) %>%
      gsub("^Longline$", "LLS", .) %>%
      gsub("^Longline set$", "LLS", .) %>%
      gsub("^Gillnet$", "GNS", .) %>%
      gsub("^GIL$", "GNS", .) %>%
      gsub("^Gillnets set$", "GNS", .) %>%
      gsub("^G\\.\\._DEF<10-18_0$", "GNS_DEF_<10-18_0", .) %>%
      gsub("^Fleet-All$", "All", .) %>%
      gsub("^Bottom trawl$", "OTB", .) %>%
      gsub("^Trawl$", "OTB", .) %>%
      gsub("^C-Allgears$", "All", .) %>%
      gsub("^Pelagic trawlers$", "Pelagic trawl", .) %>%
      gsub("^Passive gears$", "Passive", .)
  )

write.taf(intercatch, dir = "data")
