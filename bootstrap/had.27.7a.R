#' Data from had.27.7a
#'
#' @name had.27.7a
#' @format csv file
#' @tafOriginator ICES, WGCSE
#' @tafYear 2019
#' @tafAccess Public
#' @tafSource script

library(icesTAF)
taf.library(icesSharePoint)

spgetfile(
  "Documents/Preliminary documents/bootstrap_initial_data/had.27.7a/f-at-age.csv",
  "/admin/Requests",
  "https://community.ices.dk",
  destdir = "."
)

# read lowestoft file
fdata <- read.taf("f-at-age.csv")
years <- fdata$year
ages <- as.numeric(colnames(fdata)[-1])

data <-
  data.frame(
    year = rep(years, length(ages)),
    age = rep(ages, each = length(years)),
    harvest = unname(unlist(fdata[, -1]))
  )
data$stock_code <- "had.27.7a"
data$assessment_year <- 2020
write.taf(data)

cat(
  "NOTE:
* F taken from report, nothing on sharepoint
",
  file = "README.md"
)

# clean up
unlink("f-at-age.csv")
