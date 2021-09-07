#' Data from meg.27.8c9a
#'
#' @name meg.27.8c9a
#' @format csv file
#' @tafOriginator ICES, WGCSE
#' @tafYear 2020
#' @tafAccess Public
#' @tafSource script

library(icesTAF)
taf.library(icesSharePoint)

source(taf.boot.path("..", "utilities_bootstrap.R"))

spgetfile(
  "2020 Meeting Docs/06. Data/meg.27.8c9a/outputsXSA.zip",
  "/ExpertGroups/WGBIE",
  "https://community.ices.dk",
  destdir = "."
)

unzip("outputsXSA.zip", exdir = "temp")
unlink("outputsXSA.zip")

stock <- read_xsa_output("temp/meg278c9a_tables2019.csv")

name(stock) <- "meg.27.8c9a"
desc(stock) <- "Exracted from XSA text output"

save(stock, file = "stock.RData")

# clean up
unlink("temp", recursive = TRUE)
