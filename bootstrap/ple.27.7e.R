#' Data from ple.27.7e
#'
#' @name ple.27.7e
#' @format csv file
#' @tafOriginator ICES, WGCSE
#' @tafYear 2020
#' @tafAccess Public
#' @tafSource script

fdata <- read.taf("https://taf.ices.dk/fs/2020_ple.27.7e_assessment/report/tables_xsa_f_at_age.csv")
years <- fdata$year
ages <-
  as.numeric(
    gsub("[+]", "", colnames(fdata)[c(-1, -ncol(fdata))])
  )

data <-
  data.frame(
    year = rep(years, length(ages)),
    age = rep(ages, each = length(years)),
    harvest = unname(unlist(fdata[, c(-1, -ncol(fdata))]))
  )
data$stock_code <- "ple.27.7e"
data$assessment_year <- 2020
write.taf(data)
