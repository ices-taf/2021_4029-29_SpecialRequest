## Preprocess data, write TAF data tables

## Before:
## After:

library(icesTAF)
library(FLCore)
library(dplyr)
library(httr)

mkdir("data")

(load(taf.data.path("wgmixfish_fleets", "fleets.RData")))

# north sea
fleet_stock_names <-
  unique(
    unname(
      unlist(
        lapply(fleets$NorthSea, function(x) dims(x)$catches)
      )
    )
  )

NorthSeaFleets_lookup <-
  c(
    "cod.27.47d20" = "COD-NS",
    "had.27.46a20" = "HAD",
    "whg.27.47d" = "WHG-NS",
    "ple.27.420" = "PLE-NS",
    "ple.27.7d" = "PLE-EC",
    "pok.27.3a46" = "POK"
  )
NorthSeaFleets_lookup <-
  data.frame(
    fleet_stock_names = NorthSeaFleets_lookup,
    stock_codes = names(NorthSeaFleets_lookup)
  )

stock_summary <- read.taf("data/stock_summary.csv")
stock_summary$FLFleet <- FALSE

stock_summary$FLFleet[
  NorthSeaFleets_lookup[stock_summary$Stock,"fleet_stock_names"] %in% fleet_stock_names &
  stock_summary$Region == "NORTH SEA"
  ] <- TRUE


# Bob
fleet_stock_names <-
  unique(
    unname(
      unlist(
        lapply(fleets$BayOfBiscay, function(x) dims(x)$catches)
      )
    )
  )

stock_summary$FLFleet[
  stock_summary$Stock %in% c("hke.27.3a46-8abd", "meg.27.7b-k8abd") &
  stock_summary$Region == "SOUTH WESTERN WATERS"
  ] <- TRUE

# Iberian waters
stock_summary$FLFleet[
  stock_summary$Stock %in% c("meg.27.8c9a", "ldb.27.8c9a") &
  stock_summary$Region == "SOUTH WESTERN WATERS"
  ] <- TRUE


write.taf(stock_summary, dir = "data")
write.taf(NorthSeaFleets_lookup, dir = "data")

save(fleets, file = "data/fleets.RData")
