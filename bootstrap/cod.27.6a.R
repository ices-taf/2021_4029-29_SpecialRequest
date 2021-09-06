#' Data from cod.27.6a
#'
#' @name cod.27.6a
#' @format csv file
#' @tafOriginator ICES, WGCSE
#' @tafYear 2020
#' @tafAccess Public
#' @tafSource script

library(icesTAF)
library(dplyr)

source(taf.boot.path("..", "utilities_bootstrap.R"))

stock <- get_soa_flstock("cod6a_WGCSE2020_final")
name(stock) <- "cod.27.6a"

save(stock, file = "stock.RData")
