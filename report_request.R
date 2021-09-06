


stock_summary <- read.taf("data/stock_summary.csv")

rmarkdown::render("report_request.Rmd", output_file = "request", output_dir = "report")
