## Extract results of interest, write TAF output tables

## Before:
## After:

# load partial fs
objname <- load("model/fatage_partial.RData")
# rename incase it chages in model script
fatage_partial <- get(objname)

# write out tables
for (opt in names(fatage_partial)) {
  write.taf(
    fatage_partial[[opt]],
    file = paste0("fatage_partial_", opt, ".csv"),
    dir = "output"
  )
}
