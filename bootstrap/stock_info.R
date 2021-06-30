#' List of stocks of interest
#'
#' List of stock and stock codes, by area with information on
#' the contact person
#'
#' @name stock_info
#' @format csv file
#' @tafOriginator ICES
#' @tafYear 2020
#' @tafAccess Restricted
#' @tafSource script

library(icesTAF)
library(dplyr)
taf.library(icesSharePoint)
taf.library(icesSAG)
taf.library(icesSD)

spgetfile(
  "Documents/Preliminary documents/bootstrap_initial_data/stock_info.csv",
  "/admin/Requests",
  "https://community.ices.dk",
  destdir = "."
)

# do not include MED stocks
stock_info <-
  read.taf("stock_info.csv") %>%
  filter(area != "MEDITERRANEAN SEA")

# get


# read in SAG data
sag <-
  rbind(
    icesSAG::getListStocks(2019),
    icesSAG::getListStocks(2020)
  )

sag <-
  sag %>%
  tibble() %>%
  filter(StockKeyLabel %in% stock_info$stock_code) %>%
  select(AssessmentKey, AssessmentYear, StockKeyLabel, Status, SAGStamp)

# read in SD data
sd <- icesSD::getSD()

sd <-
  sd %>%
  tibble() %>%
  filter(ActiveYear %in% c(2019, 2020) & StockKeyLabel %in% stock_info$stock_code) %>%
  select(
    StockKeyLabel, SpeciesCommonName, ActiveYear,
    EcoRegion, ExpertGroup, DataCategory, AssessmentType
  )

stock_info %>%
  tibble() %>%
  select(stock_code, contact, area) %>%
  left_join(sd, by = c("stock_code" = "StockKeyLabel")) %>%
  left_join(sag, by = c("stock_code" = "StockKeyLabel", "ActiveYear" = "AssessmentYear")) %>%
  select(
    SpeciesCommonName, area, stock_code, DataCategory, ExpertGroup,
    AssessmentType, ActiveYear, Status
  ) %>%
  write.taf(file = "stock_info.csv", quote = TRUE)
