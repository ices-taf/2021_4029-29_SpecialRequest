#' Data from meg.27.7b-k8abd
#'
#' @name meg.27.7b-k8abd
#' @format csv file
#' @tafOriginator ICES, WGCSE
#' @tafYear 2020
#' @tafAccess Public
#' @tafSource script

library(icesTAF)
taf.library(icesSharePoint)

spgetfile(
  "Documents/Preliminary documents/bootstrap_initial_data/meg.27.7b-k8abd/Input_Mixed_fishery_21may2020.RData",
  "/admin/Requests",
  "https://community.ices.dk",
  destdir = "."
)

(load("Input_Mixed_fishery_21may2020.RData"))
unlink("Input_Mixed_fishery_21may2020.RData")

fdata <- harvest
ages <- 1:10
years <- 1984:2019
# just as a check
dimnames(fdata) <- list(years, ages)
fdata

data <-
  data.frame(
    year = rep(years, length(ages)),
    age = rep(ages, each = length(years)),
    harvest = c(fdata)
  )
data$stock_code <- "meg.27.7b-k8abd"
data$assessment_year <- 2020
write.taf(data)

cat(
  "Note:
* ages and years guessed from the report,
* no data on sharepoint - possibly not checked in
",
  file = "README.md"
)
