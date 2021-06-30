#' Data from ple.27.7d
#'
#' @name ple.27.7d
#' @format csv file
#' @tafOriginator ICES, WGCSE
#' @tafYear 2020
#' @tafAccess Public
#' @tafSource script

url <- "https://taf.ices.dk/fs/2020_ple.27.7d_assessment/output/fatage.csv"
fdata <- read.taf(url)

years <- fdata$Year
ages <- as.numeric(gsub("\\+", "", colnames(fdata)[-1]))

data <-
  data.frame(
    year = rep(years, length(ages)),
    age = rep(ages, each = length(years)),
    harvest = unname(unlist(fdata[, -1]))
  )
data$stock_code <- "ple.27.7d"
data$assessment_year <- 2020
write.taf(data)
