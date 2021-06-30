## Run analysis, write model results

## Before:
## After:

library(icesTAF)
library(data.table)
library(dplyr)

source("utilities_partial_fatage.R")

mkdir("model")

fatage <- read.taf("data/all_stocks.csv")
intercatch <- fread("data/intercatch.csv")
gear_table <- read.taf("data/gear_table.csv")

gear_table %>% select(Level4, Level5) %>% distinct()

# calculate partial Fs for different gear groupings
fatage_partial <- list()

opts <- c("fishing_cat", "Level4", "Level5")

for (opt in opts) {
  fatage_partial[[opt]] <-
    calc_partial_f_data(intercatch, gear_table, fatage, opt)
}


# check the gear groups
with(fatage_partial[[1]], table(stock_code, fleet_grp))
with(fatage_partial[[2]], table(stock_code, fleet_grp))
with(fatage_partial[[3]], table(stock_code, fleet_grp))

fatage_partial[[1]] %>% select(fleet_grp) %>% distinct()
fatage_partial[[2]] %>% select(fleet_grp) %>% distinct()
fatage_partial[[3]] %>% select(fleet_grp) %>% distinct()


save(fatage_partial, file = "model/fatage_partial.RData")
