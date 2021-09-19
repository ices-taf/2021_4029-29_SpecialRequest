icesTAF::taf.library(stockassessment)
library(FLCore)

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
get_soa_flstock <- function(run, fit = NULL) {

  if (is.null(fit)) {
    fit <- fitfromweb(run, character.only = TRUE)
  }

  fdata <- faytable(fit)
  ages <- as.numeric(colnames(fdata))
  years <- as.numeric(rownames(fdata))

  catch.n <- stockassessment:::getFleet(fit, 1)
  if (nrow(catch.n) < length(years)) {
    extraNA <- rep(NA, length(ages))
  } else {
    extraNA <- numeric(0)
  }

  if (ncol(catch.n) < length(ages)) {
    newcatch.n <- fit$data$landMeanWeight
    newcatch.n[] <- NA
    newcatch.n[, colnames(catch.n)] <- catch.n
    catch.n <- newcatch.n
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

  # convert to FLStock
  stock <-
    as.FLStock(
      tidyr::pivot_longer(data, cols = -(1:2), names_to = "slot", values_to = "data")
    )
  name(stock) <- run
  desc(stock) <- "Fit from SAM model on SAO"

  stock(stock) <- computeStock(stock)
  catch(stock) <- computeCatch(stock)
  landings(stock) <- computeLandings(stock)
  discards(stock) <- computeDiscards(stock)

  stock
}





# fname <- "temp/ldb278c9a_tables2019.csv"
read_xsa_output <- function(fname) {
  gettable <- function(table_no) {
    itabs <- grep(paste0("Table[ ]+", table_no, "[ ]+"), res[tables])

    data <-
      do.call(
        cbind,
        lapply(
          itabs,
          function(i) {
            tmp <- tempfile()
            cat(
              res[tables[i]:pgs[i]][-c(1, 3, 4)],
              sep = "\n", file = tmp
            )
            x <- read.csv(tmp, check.names = FALSE)
            x[, -c(1, ncol(x))]
          }
        )
      )

    data
  }

  getname <- function(table_no) {
    itabs <- grep(paste0("Table[ ]+", table_no, "[ ]+"), res[tables])
    trimws(res[tables[itabs][1]])
  }

  res <- readLines(fname)
  res <- gsub("FBAR [*][*]-[*][*]", "FBAR **-**,", res)
  res <- gsub("GMST [0-9][0-9]-[*][*]", "GMST,", res)
  res <- gsub("AMST [0-9][0-9]-[*][*]", "AMST,", res)

  # find tables
  tables <- grep("Table[ ]+[0-9]+", res)
  pgs <- grep("[+]gp[,]", res)
  tables <- tables[1:length(pgs)]

  # list of tables
  slots <-
    c(
      "catch.n" = 1, "catch.wt" = 2, "stock.wt" = 3, "m" = 4, "mat" = 5,
      "m.spwn" = 6, "harvest.spwn" = 7,
      "harvest" = 8, "stock.n" = 10
    )

  data <-
    lapply(
      slots,
      gettable
    )

  data$harvest <- data$harvest[, -ncol(data$harvest)]
  data$stock.n <- data$stock.n[, -ncol(data$stock.n) + 0:1]

  agemin <- as.numeric(strsplit(res[tables[1] + 4], ",")[[1]][1])
  ages <- agemin + 1:nrow(data$stock.n) - 1

  data <-
    lapply(data, function(x) {
      x <- t(x)
      xyears <- as.numeric(rownames(x))
      data.frame(
        age = rep(ages, each = length(xyears)),
        year = rep(xyears, length(ages)),
        data = c(x)
      )
    })

  data <-
    do.call(
      rbind,
      lapply(names(data), function(nx) {
        data[[nx]]$slot <- nx
        data[[nx]]
      })
    )

  # trim off xsa survivors and make into FLStock
  stock <- as.FLStock(data[data$year < max(data$year), ])

  stock
}
