#' Data from cod.27.22-24
#'
#' @name cod.27.22-24
#' @format csv file
#' @tafOriginator ICES, WGCSE
#' @tafYear 2020
#' @tafAccess Public
#' @tafSource script

library(icesTAF)
library(FLCore)
taf.library(FLfse)
taf.library(stockassessment)

download("https://taf.ices.dk/fs/2020_cod.27.22-24_assessment/output/model.rdata")
loaded <- load("model.rdata")
unlink("model.rdata")

fit <- get(loaded)

stock <- FLfse::SAM2FLStock(fit)
name(stock) <- "cod.27.22-24"
desc(stock) <- "Fit from SAM model on TAF"

# trim off 2020 and age 0
stock <- stock[paste(1:7), paste(2002:2019)]
units(stock) <- standardUnits(stock)

FLCore::verify(stock)
stock

save(stock, file = "stock.RData")





save(stock, file = "stock.RData")
