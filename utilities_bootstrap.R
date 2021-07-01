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

# run <- "ple.27.21-23_WGBFAS_2020_v5"
get_soa_flstock <- function(run) {
  fit <- fitfromweb(run, character.only = TRUE)

  fdata <- faytable(fit)
  ages <- as.numeric(colnames(fdata))
  years <- as.numeric(rownames(fdata))

  data <-
    data.frame(
      year = rep(years, length(ages)),
      age = rep(ages, each = length(years)),
      catch.n = c(stockassessment:::getFleet(fit, 1)),
      catch.wt = c(fit$data$catchMeanWeight),
      discards.wt = c(fit$data$disMeanWeight),
      landings.wt = c(fit$data$landMeanWeight),
      stock.n = c(ntable(fit)),
      stock.wt = c(fit$data$stockMeanWeight),
      m = c(fit$data$natMor),
      mat = c(fit$data$propMat),
      harvest = c(fdata),
      harvest.spwn = c(fit$data$propF),
      m.spwn = c(fit$data$propM)
    )

  data
}
