## Preprocess data, write TAF data tables

## Before:
## After:

library(icesTAF)
library(FLCore)
library(dplyr)
library(httr)

mkdir("data")

stock_summary <- read.taf("data/stock_summary.csv")

dirs <- list.dirs(taf.data.path(), full.names = FALSE)
dirs <- dirs[dirs %in% stock_summary$Stock]

stocks <- list()
for(idir in dirs) {
  rdata <- taf.data.path(idir, "stock.RData")
  if (file.exists(rdata)) {
    load(rdata)
    stocks <- c(stocks, stock)
  }
}
names(stocks) <- sapply(stocks, name)

# mixfish stocks
load(taf.data.path("wgmixfish_stocks", "mixed_fish.RData"))
stocks <- c(stocks, mixed_fish)

# clean all stocks

stocks <- lapply(stocks, window, end = 2019)
stocks <-
  lapply(
    stocks,
    function(x) {
      catch(x) <- computeCatch(x)
      stock(x) <- computeStock(x)
      landings(x) <- computeLandings(x)
      discards(x) <- computeDiscards(x)
      x
    }
  )

(load(taf.data.path("ices.stks.cleaned.rdata")))

stks[["cod.27.22-24"]] <- stocks[["cod.27.22-24"]]
stks[["ple.27.24-32"]] <- stocks[["ple.27.24-32"]]

stocks_taf <- stocks
stocks <- lapply(stks, function(x) x)

stock_summary$FLStock <- stock_summary$Stock %in% names(stocks)

write.taf(stock_summary, dir = "data")

save(stocks, file = "data/stocks.RData")
