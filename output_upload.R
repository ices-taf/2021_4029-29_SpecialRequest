## Extract results of interest, write TAF output tables

## Before:
## After:

library(icesTAF)
library(dplyr)

mkdir("output")

# read harvest information
all_data <- read.taf("data/all_stocks.csv")
stocks <- read.taf(taf.data.path("stock_info", "stock_info.csv"))

data_years <-
  all_data %>%
  select(stock_code, assessment_year) %>%
  mutate(
    have_data = TRUE
  ) %>%
  distinct()

stocks <-
  stocks %>%
  left_join(data_years, by = c("stock_code", "ActiveYear" = "assessment_year")) %>%
  mutate(
    have_data = !is.na(have_data)
  ) %>%
  by(.$stock_code, function(x) {
    if (any(x$have_data)) x[which(x$have_data), ] else x[which.max(x$ActiveYear), ]
  }) %>%
  unclass() %>%
  do.call(rbind, .) %>%
  tibble()



comment <- character(0)

for (stock in stocks$stock_code) {
  # split off one stock
  # stock <- stocks$stock_code[1]
  # stock <- "cod.27.7e-k"

  # assume user has a data.frame in wide format, ages on top
  data <-
    all_data %>%
    filter(stock_code == stock) %>%
    select(year, age, harvest) %>%
    long2taf()

  if (nrow(data) == 0) {
    comment <- c(comment, "no data")
    next
  }

  assessment_info <-
    list(
      unit = "F", # vocabulary
      valueType = "harvest", # vocabulary
      stockCode = stock # vocabulary
    )

  # check
  ok <- upload.fay(data, assessment_info, only.check = TRUE)
  if (!ok) {
    comment <- c(comment, "json failed check")
    next
  }

  comment <- c(comment, "uploaded")
  upload.fay(data, assessment_info)
}

stocks$comment <- comment
stocks %>%
  arrange(DataCategory, ExpertGroup) %>%
  select(-have_data) %>%
  as.data.frame() %>%
  write.taf("stock_upload_summary.csv", dir = "output", quote = TRUE)
