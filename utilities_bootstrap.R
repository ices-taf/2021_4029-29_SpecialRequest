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
# run <- "cod6a_WGCSE2020_final"
get_soa_flstock <- function(run) {
  fit <- fitfromweb(run, character.only = TRUE)

  fdata <- faytable(fit)
  ages <- as.numeric(colnames(fdata))
  years <- as.numeric(rownames(fdata))

  catch.n <- stockassessment:::getFleet(fit, 1)
  if (nrow(catch.n) < length(years)) {
    extraNA <- rep(NA, length(ages))
  } else {
    extraNA <- numeric(0)
  }

  data <-
    data.frame(
      year = rep(years, length(ages)),
      age = rep(ages, each = length(years)),
      catch.n = c(c(catch.n), extraNA),
      catch.wt = c(c(fit$data$catchMeanWeight), extraNA),
      discards.wt = c(c(fit$data$disMeanWeight), extraNA),
      landings.wt = c(c(fit$data$landMeanWeight), extraNA),
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
