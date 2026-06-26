# This script is meant to shorten the size of the allbus dataset, so we are able to push it on GitHub.
library(tidyverse)
library(haven)
big_allbus_data <- haven::read_dta("data/raw/ZA8835_v1-0-0.dta /ZA8835_v1-0-0.dta")
small_allbus <- big_allbus_data %>% select(1:pv11, sex:mborn, eastwest:last_col())
write_dta(small_allbus, "data/processed/allbus_mini.dta")
