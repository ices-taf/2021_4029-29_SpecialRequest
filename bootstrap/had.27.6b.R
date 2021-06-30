#' Data from had.27.6b
#'
#' @name had.27.6b
#' @format csv file
#' @tafOriginator ICES, WGCSE
#' @tafYear 2020
#' @tafAccess Public
#' @tafSource script

library(icesTAF)
taf.library(icesSharePoint)

spgetfile(
  "2020 Meeting Docs/06. Data/data_output2019_Had6b.zip",
  "/ExpertGroups/WGCSE",
  "https://community.ices.dk",
  destdir = "."
)

unzip("data_output2019_Had6b.zip", exdir = "temp")
unlink("data_output2019_Had6b.zip")

fname <- "temp/output2019/harvest.txt"
readLines(fname)

# read lowestoft file
fdata <- read.table(fname, skip = 3, header = TRUE, check.names = FALSE)
years <- fdata$year
ages <- as.numeric(colnames(fdata)[-1])

data <-
  data.frame(
    year = rep(years, length(ages)),
    age = rep(ages, each = length(years)),
    harvest = unname(unlist(fdata[, -1]))
  )

data$stock_code <- "had.27.6b"
data$assessment_year <- 2020
write.taf(data)

# clean up
unlink("temp", recursive = TRUE)
