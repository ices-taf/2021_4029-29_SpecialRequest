# given a gear grouping, calculate the partial Fs
require(dplyr)

calc_partial_f_data <- function(intercatch, gear_table, fatage, fleet_group) {
  gear_table$fleet_grp <- gear_table[[fleet_group]]

  # calculate sum over fleets
  intercatch %>%
    left_join(gear_table, by = "Fleet") %>%
    group_by(
      stock_code, year, age, fleet_grp
    ) %>%
    summarise(
      catage = sum(catage)
    ) %>%
    mutate(
      catage_total = sum(catage, na.rm = TRUE) # total over fleets
    ) %>%
    group_by(
      stock_code, fleet_grp
    ) %>%
    mutate(
      fleet_total = sum(catage)
    ) %>%
    ungroup() %>%
    filter(
      fleet_total > 0
    ) %>%
    left_join(
      fatage,
      by = c("year", "stock_code", "age")
    ) %>%
    filter(
      !is.na(harvest)
    ) %>%
    mutate(
      nprop = catage / catage_total,
      partial_f = harvest * nprop
    )
}
