#' Data from whg.27.6a
#'
#' @name whg.27.6a
#' @format csv file
#' @tafOriginator ICES, WGCSE
#' @tafYear 2019
#' @tafAccess Public
#' @tafSource script

library(icesTAF)
taf.library(icesSharePoint)

spgetfile(
  "2019 Meeting Documents/06. Data/whg_6a/TSA final assessment and input data.zip",
  "/ExpertGroups/WGCSE",
  "https://community.ices.dk",
  destdir = "."
)

unzip("TSA final assessment and input data.zip")
unlink("TSA final assessment and input data.zip")


(load("TSA final assessment and input data/whiting fit including 2020.RData"))


# read lowestoft file
fdata <- whiting_fit$f$estimate
years <- as.numeric(rownames(fdata))
ages <- as.numeric(colnames(fdata))

data <-
  data.frame(
    year = rep(years, length(ages)),
    age = rep(ages, each = length(years)),
    harvest = c(fdata)
  )
data$stock_code <- "whg.27.6a"
data$assessment_year <- 2019
write.taf(data)

# clean up
unlink("TSA final assessment and input data", recursive = TRUE)
