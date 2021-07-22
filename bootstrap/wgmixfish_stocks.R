#' Data provided by WGMIXFISH
#'
#' @name wgmixfish_stocks
#' @format csv file
#' @tafOriginator ICES, WGMIXFISH
#' @tafYear 2021
#' @tafAccess Public
#' @tafSource script

library(icesTAF)
taf.library(icesSharePoint)

# get zip file
if (FALSE) {
  spgetfile(
    "2019 Meeting Documents/06. Data/ple.27.7h-k.zip",
    "/ExpertGroups/WGCSE",
    "https://community.ices.dk",
    destdir = "."
  )
}

zfname <- "eu_data_request.zip"

cp(
  taf.boot.path("initial", "data", zfname),
  "."
)

unzip(zfname, exdir = "temp")
unlink(zfname)

(load("temp/ple.27.7h-k/XSA/ple_7hjk_stock_and_assessment.RData"))

# clean up
unlink("temp", recursive = TRUE)
