#' Data from cod.27.47d20
#'
#' @name cod.27.47d20
#' @format csv file
#' @tafOriginator ICES, WGCSE
#' @tafYear 2020
#' @tafAccess Public
#' @tafSource script

library(icesTAF)
source(taf.boot.path("..", "utilities_bootstrap.R"))

data <- get_soa_fs("nscod20_ass02")
data$stock_code <- "cod.27.47d20"
data$assessment_year <- 2020
write.taf(data)
