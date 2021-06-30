#' ICES Data Disclaimer
#'
#' ICES Data Disclaimer for special requests, a template is modified
#' to create a specific disclaimer for this product
#'
#' @name disclaimer
#' @format txt file
#' @tafOriginator ICES
#' @tafYear 2020
#' @tafAccess Public
#' @tafSource script

# read correct disclaimer template
github_raw_url <- "https://raw.githubusercontent.com"
disclaimer_repo <- "ices-tools-prod/disclaimers"
disclaimer_tag <- "1adaffbbe80ae8b155ff557cfa7ecc996c25308f"
disclaimer_fname <- "disclaimer_vms_data_ouput.txt"

disclaimer_url <-
  paste(
    github_raw_url,
    disclaimer_repo,
    disclaimer_tag,
    disclaimer_fname,
    sep = "/"
  )

disclaimer <- readLines(disclaimer_url)

# specific entries
data_specific <-
  paste(
    "The zip file contains csv files of F-at-age by stock, along with an R object of a named list of FLQuants containing the same information.",
    "Also included is partial F and proportion of the total catch in numbers by stock and age for various fleet components.  Three gear groupings are provided: a high level one, based the type of fishing (e.g. Otter trawl, pelagic trawl); a more detailed grouping based on metier level 4 codes; and the third more detailed still based on metier level 5 codes.  The most detailed level is provided in case the user wished to construct their own fleet grouping, and is likely to be too disaggregated to reflect the selectivities of these components accurately."
  )

recomended_citation <- "ICES. 2020. EU request on the production of matrices by year and age with F-at-age for stocks corresponding to the latest published advice for each stock. In Report of the ICES Advisory Committee, 2020. ICES Advice 2020, sr.2020.11. https://doi.org/10.17895/ices.advice.7497"

metadata <- "https://doi.org/10.17895/ices.advice.7497"

# apply to sections
# data specific info
line <- grep("3. DATA SPECIFIC INFORMATION", disclaimer)
disclaimer <-
  c(
    disclaimer[1:line],
    data_specific,
    disclaimer[(line + 1):length(disclaimer)]
  )

# recomended citation
line <- grep("Recommended citation:", disclaimer)
disclaimer <-
  c(
    disclaimer[1:line],
    recomended_citation,
    disclaimer[(line + 1):length(disclaimer)]
  )

# metadata section
line <- grep("7. METADATA", disclaimer)
disclaimer <-
  c(
    disclaimer[1:(line)],
    paste0(disclaimer[line + 1], metadata)
  )

cat(disclaimer, file = "disclaimer.txt", sep = "\n")
