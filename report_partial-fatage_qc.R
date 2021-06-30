## Prepare plots and tables for report

## Before:
## After:

library(dplyr)
library(tidyr)
library(ggplot2)
library(plotly)
library(data.table)

# ----
# partial fatage upload and download checks
# ----

# read in tables of partial F
fatage_partial.files <- dir("output", full.names = TRUE, pattern = "^fatage_partial_.*.csv$")
tables <-
  lapply(fatage_partial.files, fread)
names(tables) <- gsub("output/fatage_partial_(.*)\\.csv", "\\1", fatage_partial.files)

# join into one
pfdata <-
  do.call(
    rbind,
    tables
  )
pfdata$ftype <- rep(names(tables), sapply(tables, nrow))

stocks <- unique(pfdata$stock_code)
ftypes <- unique(pfdata$ftype)

# check
pfdata %>% filter(ftype == "fishing_cat") %>% select(fleet_grp)


plot_lists <- list()

for (type in ftypes) {

  # prop by year, fleet and age
  prop_yfa <-
    sapply(
      stocks,
      function(stock) {
        pfdata %>%
          filter(ftype == type & stock_code == stock) %>%
          ggplot(aes(x = as.numeric(year), y = nprop, col = fleet_grp)) +
          geom_line() +
          geom_point() +
          facet_wrap(~ stock_code + age)
      },
      simplify = FALSE
    )


  pfatage_yfa <-
    sapply(
      stocks,
      function(stock) {
        pfdata %>%
          filter(ftype == type & stock_code == stock) %>%
          ggplot(aes(x = as.numeric(year), y = partial_f, col = fleet_grp)) +
          geom_line() +
          geom_point() +
          facet_wrap(~ stock_code + age)
      },
      simplify = FALSE
    )


  # age, year and fleet
  prop_ayf <-
    sapply(
      stocks,
      function(stock) {
        pfdata %>%
          filter(ftype == type & stock_code == stock) %>%
          ggplot(aes(x = as.numeric(age), y = nprop, col = factor(year))) +
          geom_line() +
          geom_point() +
          facet_wrap(~ ftype + fleet_grp, scales = "free")
      },
      simplify = FALSE
    )


  pfatage_ayf <-
    sapply(
      stocks,
      function(stock) {
        pfdata %>%
          filter(ftype == type & stock_code == stock) %>%
          ggplot(aes(x = as.numeric(age), y = partial_f, col = factor(year))) +
          geom_line() +
          geom_point() +
          facet_wrap(~ ftype + fleet_grp, scales = "free")
      },
      simplify = FALSE
    )

  plot_lists[[type]] <-
    list(
      prop_yfa = prop_yfa,
      pfatage_yfa = pfatage_yfa,
      prop_ayf = prop_ayf,
      pfatage_ayf = pfatage_ayf
    )
}

rmarkdown::render("report_partial-fatage_qc.Rmd", output_file = "qc_partial-fatage", output_dir = "report")

# edit markdown html to remove ghost images (wait for system to catch up)
Sys.sleep(2)
lines <- readLines("report/qc_partial-fatage.html")
remlines <- grep("^<p><img src=\"data:image/png;base64", lines)
if (length(remlines)) {
  cat(
    lines[-remlines],
    file = "report/qc_partial-fatage.html",
    sep = "\n"
  )
}
