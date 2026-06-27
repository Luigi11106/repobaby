# 01_download.R
# Downloads raw data from the source URL and saves to data/raw/.
# Run once; data/raw/ is read-only after this point.

library(here)

bip <- read_csv2(
  file = here("data", "raw", "bip.csv"),
  skip = 3,
  # The first 3 rows were filled with explanations.
  col_names = c("year", "gdp_real", "growth_real", "gdp_nominal", "growth_nominal"),
  # The column names were not imported correctly and had to be added manually.
  n_max = 51
  # After row 51, the data set contained only NAs.
)

unemp <- read_csv2(
  file = here("data", "raw", "unemp.csv"),
  skip = 8,
  # Again, we skip the first few rows without values to fit the data correctly.
  col_names = c("month", "unemployment_total", "inflow_unemployment", "outflow_unemployment", "unemployment_rate"),
  # The column names were proactively translated into English.
  n_max = 229
)


message("Raw data already present — delete data/raw/ and re-run to refresh.")
