#' Data from had.27.7a
#'
#' @name had.27.7a
#' @format csv file
#' @tafOriginator ICES, WGCSE
#' @tafYear 2019
#' @tafAccess Public
#' @tafSource script

library(icesTAF)
library(FLCore)
taf.library(icesSharePoint)

spgetfile(
  "2020 Meeting Docs/06. Data/Haddock_VIIa_2020.zip",
  "/ExpertGroups/WGCSE",
  "https://community.ices.dk",
  destdir = "."
)

unzip("Haddock_VIIa_2020.zip", exdir = "temp")
unlink("Haddock_VIIa_2020.zip")

(load("temp/haddock/Assessment/had7aso.Rdata"))

save(stock, file = "stock.RData")

unlink("temp", recursive = TRUE)
