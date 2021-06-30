#' Data from ple.27.24-32
#'
#' @name ple.27.24-32
#' @format csv file
#' @tafOriginator ICES, WGCSE
#' @tafYear 2020
#' @tafAccess Public
#' @tafSource script

library(icesTAF)
source(taf.boot.path("..", "utilities_bootstrap.R"))

warning("Ple 24 32 needs to be run again - model.Rdata is not in the run folder")

if (FALSE) {
  data <- get_soa_fs("ple.27.2432_2020_v2")
  data$stock_code <- "ple.27.24-32"
  data$assessment_year <- 2020
  write.taf(data)
}
