#' Data from cod.27.22-24
#'
#' @name cod.27.22-24
#' @format csv file
#' @tafOriginator ICES, WGCSE
#' @tafYear 2020
#' @tafAccess Public
#' @tafSource script

library(icesTAF)

fdata <- read.taf("https://taf.ices.dk/fs/2020_cod.27.22-24_assessment/output/fatage.csv")

data <- taf2long(fdata, c("year", "age", "harvest"))
data$stock_code <- "cod.27.22-24"
data$assessment_year <- 2020

write.taf(data)
