## Prepare plots and tables for report

## Before:
## After:

library(icesTAF)

mkdir("report")

# collate documents into a zip file

# make a zip of fatage csv files
fatage.files <- dir("output", full.names = TRUE, pattern = "*_fatage.csv")
zip(
  file.path(
    "report",
    "fatage-csv.zip"
  ),
  fatage.files,
  extras = "-j"
)

# make a zip of the catches at age by stock and fleet
fatage_partial.files <- dir("output", full.names = TRUE, pattern = "^fatage_partial_.*.csv$")
zip(
  file.path(
    "report",
    "fatage_partial-csv.zip"
  ),
  fatage_partial.files,
  extras = "-j"
)


# zip up with disclaimer, and advice document
files <-
  c(
    taf.data.path("eu.2020.11.pdf"),
    taf.data.path("disclaimer", "disclaimer.txt"),
    "data/requested_stocks.csv",
    "report/fatage-csv.zip",
    "report/qc_fatage.html",
    "report/qc_partial-fatage.html",
    "report/fatage_partial-csv.zip",
    "output/FLQuants_fatage.RData",
    "output/stock_upload_summary.csv",
    "data/gear_table.csv"
  )


#' Data output: EU request on the production of matrices by year and
#' age with F-at-age for stocks corresponding to the latest published
#' advice for each stock
#'
#' The zip file contains csv files of F-at-age by stock, along with
#' an R object of a named list of FLQuants containing the same
#' information.
#' Also included is partial F and proportion of the total catch in
#' numbers by stock and age for various fleet components.  Three gear
#' groupings are provided, from a high level, describing the type of
#' fishing (e.g. Otter trawl, pelagic trawl), a more detailed grouping
#' based on metier level 4 codes, and a more detailed still based on
#' metier level 5.  Metier level 5 is provided in case the user wished
#' to construct thier own fleet grouping.
#'
#' @name ICES.2020.matrices-of-F-at-age-for-selected-stocks.zip
#' @references \url{https://ices.dk}
#' @format a zip file
#' @tafOriginator ICES TAF
#' @tafYear 2020
#' @tafAccess Public

zip(
  file.path(
    "report",
    "ICES.2020.matrices-of-F-at-age-for-selected-stocks.zip"
  ),
  files,
  extras = "-j"
)

# clean up
unlink("report/fatage-csv.zip")
unlink("report/fatage_partial-csv.zip")
