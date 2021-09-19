#' Data from ple.27.24-32
#'
#' @name ple.27.24-32
#' @format csv file
#' @tafOriginator ICES, WGCSE
#' @tafYear 2020
#' @tafAccess Public
#' @tafSource script

library(icesTAF)
library(FLCore)
taf.library(FLfse)
taf.library(stockassessment)

fit <- fitfromweb("ple.27.2432_2020_v2", character.only = TRUE)
stock <- FLfse::SAM2FLStock(fit)
name(stock) <- "ple.27.24-32"
# trim off 2020
stock <- stock[, paste(2002:2019)]
units(stock) <- standardUnits(stock)

catch.n(stock)[] <- stockassessment:::getFleet(fit, 1)
landings.n(stock)[] <- fit$data$landFrac
discards.n(stock)[] <- catch.n(stock)[] - landings.n(stock)[]
discards.n(stock)[discards.n(stock) < 0] <- 0

catch(stock) <- computeCatch(stock)
landings(stock) <- computeLandings(stock)
discards(stock) <- computeDiscards(stock)

save(stock, file = "stock.RData")
