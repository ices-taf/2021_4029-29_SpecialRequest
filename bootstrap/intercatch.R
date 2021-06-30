#' Data from intercatch
#'
#' @name intercatch
#' @format csv file
#' @tafOriginator ICES
#' @tafYear 2020
#' @tafAccess Public
#' @tafSource script

library(icesTAF)
taf.library(icesSharePoint)

dir <- "2020 Meeting Documents/06. Data/"
site <- "/ExpertGroups/WGMIXFISH-METH"
site_collection <- "https://community.ices.dk"

files <- spfiles(dir, site, site_collection, full = TRUE)

for (file in files) {
  spgetfile(file, site, site_collection, destdir = ".")
}

zips <- basename(files)[grep("[.]zip$", files)]

for (zip in zips) {
  unzip(zip)
  unlink(zip)
}
