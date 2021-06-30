#' Data from ldb.27.8c9a
#'
#' @name ldb.27.8c9a
#' @format csv file
#' @tafOriginator ICES, WGCSE
#' @tafYear 2020
#' @tafAccess Public
#' @tafSource script

library(icesTAF)
taf.library(icesSharePoint)

spgetfile(
  "2020 Meeting Docs/06. Data/ldb.27.8c9a/outputsXSA.zip",
  "/ExpertGroups/WGBIE",
  "https://community.ices.dk",
  destdir = "."
)

unzip("outputsXSA.zip", exdir = "temp")
unlink("outputsXSA.zip")

res <- readLines("temp/ldb278c9a_tables2019.csv")

# read xsa output file
fline1 <- grep("Table  8", res)
fline2 <- grep("^0  FBAR", res)

nrows <- unique(fline2 - fline1)

fdata <-
  do.call(
    rbind,
    lapply(
      fline1,
      function(i) {
        tmp <- tempfile()
        cat(
          gsub("YEAR", "Age", res[i + c(1, 4:(nrows - 1))]),
          sep = "\n", file = tmp
        )
        x <- read.csv(tmp, check.names = FALSE)
        x <-
          if (any(grepl("FBAR", names(x)))) {
            names(x) <- c(names(x)[-1], "")
            x[, -ncol(x) + 1:0]
          } else {
            x <- x[, -ncol(x)]
            row.names(x) <- x[, 1]
            x[, -1]
          }
        t(x)
      }
    )
  )

ages <- as.numeric(colnames(fdata)[1]) - 1 + 1:ncol(fdata)
years <- as.numeric(rownames(fdata))

data <-
  data.frame(
    year = rep(years, length(ages)),
    age = rep(ages, each = length(years)),
    harvest = c(fdata)
  )
data$stock_code <- "ldb.27.8c9a"
data$assessment_year <- 2020
write.taf(data)

# clean up
unlink("temp", recursive = TRUE)
