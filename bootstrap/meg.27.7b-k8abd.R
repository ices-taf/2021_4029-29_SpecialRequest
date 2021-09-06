#' Data from meg.27.7b-k8abd
#'
#' @name meg.27.7b-k8abd
#' @format csv file
#' @tafOriginator ICES, WGCSE
#' @tafYear 2020
#' @tafAccess Public
#' @tafSource script

library(icesTAF)

loaded <- load(taf.data.path("Input_Mixed_fishery_21may2020.RData"))

ages <- 1:10
years <- 1984:2019

data <-
  data.frame(
    year = rep(years, length(ages)),
    age = rep(ages, each = length(years)),
    catch.n = c(catches.n),
    catch.wt = c(catches.wt),
    landings.n = c(landings.n),
    landings.wt = c(landings.wt),
    discards.n = c(cbind(discards.n, 0, 0)),
    discards.wt = c(discards.wt),
    stock.n = c(stock.n),
    harvest = c(harvest),
    mat = c(maturity)
  )
stock <-
  as.FLStock(
    tidyr::pivot_longer(data, cols = -(1:2), names_to = "slot", values_to = "data")
  )
name(stock) <- "meg.27.7b-k8abd"
desc(stock) <- ""

save(stock, file = "stock.RData")

cat(
  "Note:
* ages and years guessed from the report,
* no data on sharepoint - possibly not checked in
",
  "No natural mortality provided",
  file = "README.md"
)
