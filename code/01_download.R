# 01_download.R
# Downloads raw data from the source URL and saves to data/raw/.
# Run once; data/raw/ is read-only after this point.

library(here)

bip <- read_csv2(
  file = here("data", "raw", "bip.csv"),
  skip = 3,
  col_names = c("Jahr", "BIP_preisbereinigt", "Wachstum_preisbereinigt", "BIP_nominal", "Wachstum_nominal"),
  locale = locale(encoding = "ISO-8859-1")
)
# This file was cut to become a clean data set after the import.

cutunemp <- read_csv2(here("data", "raw", "unemployment_data_cut.csv"))
# This file was cut to become a clean data set after the import.

message("Raw data already present — delete data/raw/ and re-run to refresh.")
