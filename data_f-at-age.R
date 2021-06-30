## Preprocess data, write TAF data tables

## Before:
## After:

library(icesTAF)
library(dplyr)
library(httr)

stocks <- read.taf(taf.data.path("stock_info", "stock_info.csv"))

dirs <- dir(taf.data.path())
dirs <- dirs[dirs %in% stocks$stock_code]

data <-
  lapply(dirs, function(x) {
    fname <- taf.data.path(x, "data.csv")
    if (file.exists(fname)) {
      read.taf(fname)[c("stock_code", "year", "age", "harvest", "assessment_year")]
    } else {
      NULL
    }
  })
data <- data[!sapply(data, is.null)]
all_stocks <- do.call(rbind, data)

write.taf(all_stocks, dir = "data")



comments <-
  lapply(dirs, function(x) {
    fname <- taf.data.path(x, "README.md")
    if (file.exists(fname)) {
      c(paste0("# ", x), readLines(fname), "")
    } else {
      NULL
    }
  })
comments <- comments[!sapply(comments, is.null)]
comments <- unlist(comments)
cat(comments, file = "data/comments.md", sep = "\n")
