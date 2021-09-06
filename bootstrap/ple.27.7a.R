#' Data from ple.27.7a
#'
#' @name ple.27.7a
#' @format csv file
#' @tafOriginator ICES, WGCSE
#' @tafYear 2020
#' @tafAccess Public
#' @tafSource script

library(icesTAF)
taf.library(icesSharePoint)

spgetfile(
  "2020 Meeting Docs/06. Data/PLE 7A/ple7a.zip",
  "/ExpertGroups/WGCSE",
  "https://community.ices.dk",
  destdir = "."
)

unzip("ple7a.zip", exdir = "temp")
unlink("ple7a.zip")

loaded <- (load("temp/sam/assessment/b9model.RData"))
unlink("temp", recursive = TRUE)

stock <- get_soa_flstock("ple.27.7a", fit_b9)
desc(stock) <- "Fit from SAM model on SharePoint"

save(stock, file = "stock.RData")

cat(
  "Please note that this stock is unique (among finfish stocks) in that 40% of the discards are assumed to survive. The fishing mortalities therefore do not give the total catch, instead they give the dead catch which is the landings plus 60% of the discards.
",
  file = "README.md"
)
