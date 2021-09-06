#' Data from cod.27.22-24
#'
#' @name cod.27.22-24
#' @format csv file
#' @tafOriginator ICES, WGCSE
#' @tafYear 2020
#' @tafAccess Public
#' @tafSource script

library(icesTAF)
source(taf.boot.path("..", "utilities_bootstrap.R"))

download("https://taf.ices.dk/fs/2020_cod.27.22-24_assessment/output/model.rdata")
loaded <- load("model.rdata")
unlink("model.rdata")

fit <- get(loaded)

stock <- get_soa_flstock("cod.27.22-24", fit)
desc(stock) <- "Fit from SAM model on TAF"

save(stock, file = "stock.RData")
