#' Data from cod.27.24-32
#'
#' @name cod.27.24-32
#' @format csv file
#' @tafOriginator ICES, WGCSE
#' @tafYear 2020
#' @tafAccess Public
#' @tafSource script

library(icesTAF)
library(ss3om)

download("https://taf.ices.dk/fs/2020_cod.27.24-32_assessment", destfile = "temp.zip")
unzip("temp.zip", exdir = "temp")
unlink("temp.zip")

stock <- readFLSss3("temp\\2020_cod.27.24-32_assessment\\model")
name(stock) <- "cod.27.24-32"
desc(stock) <- "SS3 fit dowloaded from TAF"

save(stock, file = "stock.RData")

unlink("temp", recursive = TRUE)
