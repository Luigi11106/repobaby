# This script is meant to shorten the size of the allbus dataset, so we are able to push it on GitHub.
library(tidyverse)
library(haven)
if (dir.exists("data/raw/ZA8835_v1-0-0.dta")) {
  big_allbus_data <- haven::read_dta("data/raw/ZA8835_v1-0-0.dta/ZA8835_v1-0-0.dta")
  small_allbus <- big_allbus_data %>% select(1:pv11, sex:mborn, eastwest:last_col())
  write_dta(small_allbus, "data/processed/allbus_mini.dta")
} else {
  message("data/raw/ZA8835_v1-0-0.dta not found\nYou can find the processed dataset \"allbus_mini.dta\" in data/processed or manually download the raw dataset into data/raw")
}
# This is how we got to the "allbus_mini" dataset, which is the one we are mainly using for this project
