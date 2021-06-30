#' Catches by fleet
#'
#' List of stock and stock codes, by area with information on
#' the contact person
#'
#' @name mixed_fisheries
#' @format csv file
#' @tafOriginator ICES
#' @tafYear 2020
#' @tafAccess Restricted
#' @tafSource script

library(icesTAF)
taf.library(icesSharePoint)

# skip mixfish data
if (FALSE) {
  spgetfile(
    "Documents/Preliminary documents/bootstrap_initial_data/mixfish/catch.csv",
    "/admin/Requests",
    "https://community.ices.dk",
    destdir = "."
  )
}