#' Data from pok.27.3a46
#'
#' @name pok.27.3a46
#' @format csv file
#' @tafOriginator ICES, WGCSE
#' @tafYear 2020
#' @tafAccess Public
#' @tafSource script

fdata <- read.taf("https://taf.ices.dk/fs/2020_pok.27.3a46_assessment/output/tab_fay.csv")
years <- fdata$Year
ages <- as.numeric(colnames(fdata)[-1])

data <-
  data.frame(
    year = rep(years, length(ages)),
    age = rep(ages, each = length(years)),
    harvest = unname(unlist(fdata[, -1]))
  )
data$stock_code <- "pok.27.3a46"
data$assessment_year <- 2020
write.taf(data)
