## Preprocess data, write TAF data tables

## Before:
## After:

library(icesTAF)
library(data.table)
library(dplyr)
library(icesVocab)

# get intercatch data
intercatch <- fread("data/intercatch.csv")

# create a gear lookup table
gear_table <-
  data.frame(
    Fleet = sort(unique(intercatch$Fleet))
  ) %>%
  mutate(
    Level4 = gsub("^([A-Z]{3})_[a-zA-Z]{3}.*", "\\1", Fleet),
    Level5 = gsub("^([A-Z]{3}_[a-zA-Z]{3}).*", "\\1", Fleet),
    Level6 = gsub("^([A-Z]{3}_[a-zA-Z]{3}_([<>=]*[0-9]+-?[0-9]*|[a-zA-Z]{3}))_.*", "\\1", Fleet)
  ) %>%
  left_join(
    getCodeList("IC_GearType")[c("Key", "Description")],
    by = c("Level4" = "Key")
  ) %>%
  rename(
    Level4_name = Description
  ) %>%
  left_join(
    getCodeList("Metier5_FishingActivity")[c("Key", "Description")],
    by = c("Level5" = "Key")
  ) %>%
  rename(
    Level5_name = Description
  ) %>%
  mutate(
    Level4_name = ifelse(is.na(Level4_name), Level4, Level4_name),
    Level5_name = ifelse(is.na(Level5_name), Level5, Level5_name)
  )

gear_table %>% select(Level4, Level4_name) %>% distinct()

# create larger grouping
lookup <-
  list(
    Static = c("GNS", "GTR", "LLS", "LHM", "FPO", "Passive"),
    Seines = c("SSC", "SDN"),
    "Bottom trawl" = c("OTB", "OTT", "PTB"),
    "Pelagic trawl" = c("OTM", "PTM"),
    "Beam trawl" = "TBB",
    dredge = "DRB",
    miscellaneous = "MIS"
  )
lookup <-
  data.frame(
    Level4 = unname(unlist(lookup)),
    fishing_cat = rep(names(lookup), sapply(lookup, length))
  )

gear_table <-
  gear_table %>%
  left_join(lookup, by = "Level4") %>%
  mutate(
    fishing_cat = ifelse(is.na(fishing_cat), Fleet, fishing_cat)
  )

gear_table %>%
  select(Level4, Level4_name) %>%
  distinct()

write.taf(gear_table, dir = "data")
