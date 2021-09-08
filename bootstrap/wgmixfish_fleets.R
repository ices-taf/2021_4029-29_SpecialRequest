#' Data provided by WGMIXFISH
#'
#' @name wgmixfish_fleets
#' @format csv file
#' @tafOriginator ICES, WGMIXFISH
#' @tafYear 2021
#' @tafAccess Public
#' @tafSource script

library(icesTAF)
library(FLCore)
library(FLBEIA)
taf.library(icesSharePoint)

# get stocks list
request <- read.taf(taf.data.path("request.csv"))

zfname <- "eu_data_request.zip"
cp(
  taf.boot.path("initial", "data", zfname),
  "."
)
unzip(zfname)
unlink(zfname)

# NS fleets
(load(
  file.path(
    "eu_data_request",
    "NS_advice_data",
    "03_NS_Fleet_database_AA_KW.RData"
  )
))

fleets_ns <- fleets

# Bob
(load(
  file.path(
    "eu_data_request", "Bob_advice_data", "fleets_biols.RData"
  )
))

fleets_bob <- fleets

# IBW
(load(
  file.path(
    "eu_data_request", "IBW_advice_data", "biols_STF20.RData"
  )
))

fleets_ibw <- list(ldb.27.8c9a = fleets.ldb, meg.27.8c9a = fleets.meg)

# save
fleets <-
  list(
    NorthSea = fleets_ns,
    BayOfBiscay = fleets_bob,
    IberianWaters = fleets_ibw
  )
save(fleets, file = "fleets.RData")

# clean
unlink("eu_data_request", recursive = TRUE)
