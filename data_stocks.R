## Preprocess data, write TAF data tables

## Before:
## After:

library(icesTAF)
library(dplyr)
library(httr)

mkdir("data")

stocks <-
  c(
    "cod.27.47d20", "had.27.46a20", "whg.27.47d", "ple.27.420",
    "ple.27.7d", "ple.27.7d", "pok.27.3a46", "cod.27.6a",
    "cod.27.7e-k", "had.27.6b", "had.27.7a", "had.27.7b-k",
    "whg.27.7b-ce-k", "ple.27.7a", "cod.27.22-24", "cod.27.24-32",
    "ple.27.21-23", "ple.27.24-32", "hke.27.3a46-8abd",
    "meg.27.7b-k8abd", "meg.27.8c9a", "ldb.27.8c9a"
  )

stocks <-
  c(
    "cod.27.6a", "ple.27.21-23", "ple.27.24-32"
  )


dirs <- dir(taf.data.path())
dirs <- dirs[dirs %in% stocks]

data <-
  lapply(dirs, function(x) {
    fname <- taf.data.path(x, "data.csv")
    if (file.exists(fname)) {
      read.taf(fname)
    } else {
      NULL
    }
  })
data <- data[!sapply(data, is.null)]
all_stocks <- do.call(rbind, data)

write.taf(all_stocks, dir = "data")
