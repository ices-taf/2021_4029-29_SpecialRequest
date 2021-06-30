#' Data from ple.27.7h-k
#'
#' @name ple.27.7h-k
#' @format csv file
#' @tafOriginator ICES, WGCSE
#' @tafYear 2020
#' @tafAccess Public
#' @tafSource script

library(icesTAF)
taf.library(icesSharePoint)

spgetfile(
  "2019 Meeting Documents/06. Data/ple.27.7h-k.zip",
  "/ExpertGroups/WGCSE",
  "https://community.ices.dk",
  destdir = "."
)

unzip("ple.27.7h-k.zip", exdir = "temp")
unlink("ple.27.7h-k.zip")

(load("temp/ple.27.7h-k/XSA/ple_7hjk_stock_and_assessment.RData"))
unlink("temp", recursive = TRUE)

# something odd going on
cat(
  "NOTE:",
  "* rdata on 2019 data folder seems to be the 2016 assessment",
  file = "README.md",
  sep = "\n"
)
