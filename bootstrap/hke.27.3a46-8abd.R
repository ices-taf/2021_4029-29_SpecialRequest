#' Data from hke.27.3a46-8abd
#'
#' @name hke.27.3a46-8abd
#' @format csv file
#' @tafOriginator ICES, WGCSE
#' @tafYear 2020
#' @tafAccess Public
#' @tafSource script

library(icesTAF)

fdata <- read.taf("https://taf.ices.dk/fs/2020_hke.27.3a46-8abd_assessment_alt/output/fatage.csv")

data <- taf2long(fdata, c("year", "age", "harvest"))
data$stock_code <- "hke.27.3a46-8abd"
data$assessment_year <- 2020

write.taf(data)
