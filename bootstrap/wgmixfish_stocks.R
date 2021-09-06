#' Data provided by WGMIXFISH
#'
#' @name wgmixfish_stocks
#' @format csv file
#' @tafOriginator ICES, WGMIXFISH
#' @tafYear 2021
#' @tafAccess Public
#' @tafSource script

library(icesTAF)
library(FLCore)
library(FLBEIA)
taf.library(icesSharePoint)

# get stocks list
request <- read.taf(taf.data.path("request.csv"))

# "cod.27.47d20"     "had.27.46a20"     "whg.27.47d"       "ple.27.420"
# "ple.27.7d"        "ple.27.7d"        "pok.27.3a46"      "cod.27.7e-k"
# "had.27.7a"        "had.27.7b-k"      "whg.27.7b-ce-k"   "hke.27.3a46-8abd"
# "meg.27.7b-k8abd"  "meg.27.8c9a"      "ldb.27.8c9a"

# get zip file
if (FALSE) {
  spgetfile(
    "2019 Meeting Documents/06. Data/ple.27.7h-k.zip",
    "/ExpertGroups/WGCSE",
    "https://community.ices.dk",
    destdir = "."
  )
}

zfname <- "eu_data_request.zip"
cp(
  taf.boot.path("initial", "data", zfname),
  "."
)
unzip(zfname)
unlink(zfname)

# 1             NORTH SEA              Cod     cod.27.47d20 FALSE
# 2             NORTH SEA          Haddock     had.27.46a20 FALSE
# 3             NORTH SEA          Whiting       whg.27.47d FALSE
# 4             NORTH SEA           Plaice       ple.27.420 FALSE
# 6             NORTH SEA           Plaice        ple.27.7d FALSE
# 7             NORTH SEA           Saithe      pok.27.3a46 FALSE

nsstocks <-
  c(
    "cod.27.47d20" = "COD-NS.RData",
    "had.27.46a20" = "HAD.RData",
    "whg.27.47d" = "WHG-NS.RData",
    "ple.27.420" = "PLE-NS.RData",
    "ple.27.7d" = "PLE-EC.RData",
    "pok.27.3a46" = "POK.RData"
  )

list_stocks <- list()

for (stk in nsstocks) {
  loaded <-
    load(
      file.path(
        "eu_data_request", "NS_advice_data", stk
      )
    )

  list_stocks <- c(list_stocks, get(loaded))
}

# 9  NORTH WESTERN WATERS              Cod      cod.27.7e-k FALSE
# 12 NORTH WESTERN WATERS          Haddock      had.27.7b-k FALSE
# 13 NORTH WESTERN WATERS          Whiting   whg.27.7b-ce-k FALSE

csstocks <-
  c(
    "cod.27.7e-k" = "cod.27.7e-k.RData",
    "had.27.7b-k" = "had.27.7b-k.RData",
    "whg.27.7b-ce-k" = "whg.27.7b-ce-k.RData"
  )

for (i in seq_along(csstocks)) {
  loaded <-
    load(
      file.path(
        "eu_data_request", "CS_advice_data", csstocks[i]
      )
    )

  list_stocks <- c(list_stocks, get(loaded))
}

names(list_stocks) <- c(names(nsstocks), names(csstocks))

# 19 SOUTH WESTERN WATERS             Hake hke.27.3a46-8abd FALSE
# 20 SOUTH WESTERN WATERS           Megrim  meg.27.7b-k8abd FALSE
# 21 SOUTH WESTERN WATERS           Megrim      meg.27.8c9a FALSE
# 22 SOUTH WESTERN WATERS Four-spot megrim      ldb.27.8c9a FALSE

loaded <-
  load(
    file.path("eu_data_request", "Bob_advice_data", "fleets_biols.RData")
  )


# save
assign("mixed_fish", value = list_stocks)
save(mixed_fish, file = "mixed_fish.RData")
