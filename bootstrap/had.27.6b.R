#' Data from had.27.6b
#'
#' @name had.27.6b
#' @format csv file
#' @tafOriginator ICES, WGCSE
#' @tafYear 2020
#' @tafAccess Public
#' @tafSource script

library(icesTAF)
library(FLCore)
taf.library(icesSharePoint)

spgetfile(
  "2020 Meeting Docs/06. Data/data_output2019_Had6b.zip",
  "/ExpertGroups/WGCSE",
  "https://community.ices.dk",
  destdir = "."
)

unzip("data_output2019_Had6b.zip", exdir = "temp")
unlink("data_output2019_Had6b.zip")

# fill up the FLStock object
stock <- readFLStock("temp/data2019/Had6b.IDX")
name(stock) <- "had.27.6b"

# read results tables
harvest(stock)[] <-
  t(
    read.table(
      "temp/output2019/harvest.txt",
      skip = 3, header = TRUE, check.names = FALSE
    )[, -1]
  )
stock.n(stock)[] <-
  t(
    read.table(
      "temp/output2019/catch.n.txt",
      skip = 3, header = TRUE, check.names = FALSE
    )[, -1]
  )

save(stock, file = "stock.RData")

# clean up
unlink("temp", recursive = TRUE)
