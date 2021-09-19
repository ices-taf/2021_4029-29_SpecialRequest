
library(icesTAF)

draft.software(
  c("icesSAG", "icesSD", "icesSharePoint", "stockassessment", "FLfse"),
  file = TRUE
)

# remotes::install_github("r4ss/r4ss@v1.43.0", INSTALL_opts = "--no-multiarch")
# remotes::install_github("flr/ss3om", INSTALL_opts = "--no-multiarch")

taf.bootstrap(data = FALSE)

taf.roxygenise(
  files = c(
    "advice_pdf.R",
    "request.R",
    "disclaimer.R",
    "wgmixfish_stocks.R", "wgmixfish_fleets.R",
    "cod.27.22-24.R", "cod.27.24-32.R", "cod.27.6a.R",
    "had.27.6b.R", "had.27.7a.R",
    "ple.27.21-23.R",
    "ple.27.24-32.R", "ple.27.7a.R",
    #"hke.27.3a46-8abd.R",
    "Input_Mixed_fishery_21may2020.R", "meg.27.7b-k8abd.R",
    "ldb.27.8c9a.R", "meg.27.8c9a.R",
    "ices.stks.cleaned.R"
  )
)

taf.bootstrap(software = FALSE)

sourceAll()

# render README.md summary page
#rmarkdown::render("README.Rmd")
