#' Data from whg.27.7b-ce-k
#'
#' @name whg.27.7b-ce-k
#' @format csv file
#' @tafOriginator ICES, WGCSE
#' @tafYear 2020
#' @tafAccess Public
#' @tafSource script

library(icesTAF)
source(taf.boot.path("..", "utilities_bootstrap.R"))

if (FALSE) {
  data <- get_soa_fs("whg.7b-ce-k_FRA_Sept20")
  data$stock_code <- "whg.27.7b-ce-k"
  data$assessment_year <- 2020
  write.taf(data)

  cat(
    "NOTE:
* Due to an ongoing benchmark for this stock, advice release was postponed for 2020. Advice is being drafted and is due to be published on the October 30th, so F-at-age is not final, and will be updated int he DB when approved.
",
    file = "README.md"
  )
}


contents <-
  "Year 1 2 3 4 5 6 7
2009 0.033 0.282 0.333 0.478 0.446 0.333 0.333
2010 0.011 0.118 0.342 0.475 0.544 0.330 0.330
2011 0.030 0.050 0.159 0.416 0.410 0.380 0.380
2012 0.035 0.097 0.118 0.204 0.283 0.245 0.245
2013 0.009 0.100 0.216 0.243 0.313 0.304 0.304
2014 0.044 0.107 0.219 0.413 0.366 0.291 0.291
2015 0.041 0.207 0.361 0.523 0.388 0.442 0.442
2016 0.111 0.291 0.652 0.569 0.569 0.371 0.371
2017 0.101 0.411 0.515 0.868 0.794 0.728 0.728
2018 0.042 0.255 0.627 0.577 1.035 0.865 0.865
"

contents <- strsplit(strsplit(contents, "\n")[[1]], " ")

fdata <-
  do.call(
    rbind.data.frame,
    contents[-1]
  )
names(fdata) <- contents[[1]]
fdata[] <- lapply(fdata, type.convert, as.is = TRUE)
fdata

data <- taf2long(fdata, names = c("year", "age", "harvest"))

data$stock_code <- "whg.27.7b-ce-k"
data$assessment_year <- 2019
write.taf(data)
