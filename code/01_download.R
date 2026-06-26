# 01_download.R
# Downloads raw data from the source URL and saves to data/raw/.
# Run once; data/raw/ is read-only after this point.

library(here)

bip <- read_csv2(
  file = here("data", "raw", "bip.csv"),
  skip = 3,
  # The first 3 rows were filled with explanations.
  col_names = c("jahr", "bip_preisbereinigt", "wachstum_preisbereinigt", "bip_nominal", "wachstum_nominal"),
  # The column names were not imported correctly and had to be added manually.
  locale = locale(encoding = "ISO-8859-1"),
  n_max = 51
  # After row 51, the data set contained only NAs.
)

cutunemp <- read_csv2(here("data", "raw", "unemployment_data_cut.csv"))
# This file was cut in the same way, to have the form of a clean data set

message("Raw data already present — delete data/raw/ and re-run to refresh.")
