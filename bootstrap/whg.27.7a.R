#' Data from whg.27.7a
#'
#' @name whg.27.7a
#' @format csv file
#' @tafOriginator ICES, WGCSE
#' @tafYear 2020
#' @tafAccess Public
#' @tafSource script

library(icesTAF)
taf.library(icesSharePoint)

spgetfile(
  "2020 Meeting Docs/06. Data/WHG 7A/Assessment.zip",
  "/ExpertGroups/WGCSE",
  "https://community.ices.dk",
  destdir = "."
)

unzip("Assessment.zip", exdir = "temp")
unlink("Assessment.zip")

fname <- "temp/Assessment/1_Data/LowestoftFiles/WHG27.7a.F_run1_new.txt"

# read lowestoft file
fdata <- scan(fname, sep = "\t", skip = 5)
years <- scan(fname, sep = "\t", nlines = 1, skip = 2, quiet = TRUE)
years <- years[1]:years[2]
ages <- scan(fname, sep = "\t", nlines = 1, skip = 3, quiet = TRUE)
ages <- ages[1]:ages[2]

data <-
  data.frame(
    year = rep(years, each = length(ages)),
    age = rep(ages, length(years)),
    harvest = fdata
  )
data$stock_code <- "whg.27.7a"
data$assessment_year <- 2020
write.taf(data)

# clean up
unlink(taf.data.path("whg.27.7a", "Assessment"), recursive = TRUE)
