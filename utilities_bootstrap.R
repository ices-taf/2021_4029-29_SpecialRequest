require(stockassessment)

get_soa_fs <- function(run) {

  fit <- fitfromweb(run, character.only = TRUE)

  fdata <- faytable(fit)
  ages <- as.numeric(colnames(fdata))
  years <- as.numeric(rownames(fdata))

  data <-
    data.frame(
      year = rep(years, length(ages)),
      age = rep(ages, each = length(years)),
      harvest = c(fdata)
    )

  data
}
