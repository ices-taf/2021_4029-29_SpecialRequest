#' Data from whg.27.47d
#'
#' @name whg.27.47d
#' @format csv file
#' @tafOriginator ICES, WGCSE
#' @tafYear 2020
#' @tafAccess Public
#' @tafSource script

library(icesTAF)
source(taf.boot.path("..", "utilities_bootstrap.R"))

data <- get_soa_fs("NSwhiting_2020_new_method_new1")
data$stock_code <- "whg.27.47d"
data$assessment_year <- 2020
write.taf(data)
