# 01_download.R
# Downloads raw data from the source URL and saves to data/raw/.
# Run once; data/raw/ is read-only after this point.

library(here)

url <- "https://www.bundesfinanzministerium.de/Datenportal/Daten/offene-daten/wirtschaft-und-finanzen/s33-bruttoinlandsprodukt/datensaetze/csv_s33-bruttoinlandsprodukt.csv?__blob=publicationFile&v=10"
download.file(url, destfile = here("data", "raw", "bip_data.csv"))

cutunemp <- read_csv2(here("data", "raw", "unemployment_data_cut.csv"))
# This file has been modified to become a clean dataset after the import.

message("Raw data already present — delete data/raw/ and re-run to refresh.")
