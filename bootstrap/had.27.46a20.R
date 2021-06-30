#' Data from had.27.46a20
#'
#' @name had.27.46a20
#' @format csv file
#' @tafOriginator ICES, WGCSE
#' @tafYear 2020
#' @tafAccess Public
#' @tafSource script

library(icesTAF)
taf.library(icesSharePoint)

spgetfile(
  "Documents/Preliminary documents/bootstrap_initial_data/had.27.46a20/f-at-age.csv",
  "/admin/Requests",
  "https://community.ices.dk",
  destdir = "."
)

# read lowestoft file
fdata <- read.taf("f-at-age.csv")
years <- fdata$Year
ages <- as.numeric(colnames(fdata)[-1])

data <-
  data.frame(
    year = rep(years, length(ages)),
    age = rep(ages, each = length(years)),
    harvest = unname(unlist(fdata[, -1]))
  )
data$stock_code <- "had.27.46a20"
data$assessment_year <- 2020
write.taf(data)

cat(
  "NOTE:
* Estimates refer to the full year (January–December) except for age 0, for which the mortality rate given refers to the second half-year only (July–December).
* The 2020 estimates are TSA forecasts
",
  file = "README.md"
)

# clean up
unlink("f-at-age.csv")
