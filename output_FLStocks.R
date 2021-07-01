
library(icesTAF)
library(dplyr)
library(tidyr)
library(FLCore)
library(ggplotFL)

mkdir("output")

flstock <- FLStock()

stocks <-
  read.taf("data/all_stocks.csv") %>%
  tibble() %>%
  pivot_longer(any_of(slotNames(flstock)), names_to = "slot", values_to = "data")

flstocks <-
  stocks %>%
  by(
    stocks$stock_code,
    function(x) {
      fls <- as.FLStock(as.data.frame(x[c("year", "age", "slot", "data")]))

      name(fls) <- x$stock_code[1]
      desc(fls) <- "extracted from 2020 assessment"

      # set units
      units(harvest(fls)) <- "f"
      units(m(fls)) <- "m"
      units(mat(fls)) <- ""
      units(harvest.spwn(fls)) <- ""
      units(m.spwn(fls)) <- ""

      # compute totals
      catch(fls) <- computeCatch(fls)
      stock(fls) <- computeStock(fls)

      fls
    }
  ) %>%
  unclass() %>%
  FLStocks()

save(flstocks, file = "output/flstocks_object.RData")

# also save individually?

if (FALSE) {
  # quick checks
  str(flstocks, 1)
  names(flstocks)
  flstocks[[1]]

  #
  catch(flstocks[[1]])
  plot(flstocks[[1]])
  plot(flstocks)
}
