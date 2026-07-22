# Exploratory data analysis: distributions, missingness, relationships.
# Figures are saved to docs/ for inclusion in report.qmd.

library(tidyverse)
library(here)
library(haven)
library(lubridate)

allbus <- read_dta(here("data", "processed", "allbus_mini_clean.dta"))
bip <- read_csv(here("data", "processed", "bip_clean.csv"))
unemp <- read_csv(here("data", "processed", "unemp_clean.csv"))
elect <- read_csv(here("data", "processed", "elect_clean.csv"))

elect %>% ggplot(aes(x = date, y = afd)) +
  geom_path() +
  labs(title = "AfD support in Germany")

# This plot shows the vote share of the AfD in Germany over the years.
# AfD support declined in 2017 before recovering later that year. Between 2018 and 2020, polling numbers remained largely stable. Support fell again during the COVID-19 pandemic, followed by a sharp increase in 2022 and 2023. After a decline in 2024, polling support has gradually increased again.

unemp |>
  ggplot(aes(unemployment_rate)) +
  geom_histogram(binwidth = 0.25, fill = "forestgreen", color = "black") +
  labs(title = "Histogramm of enemployment in percent in Germany 2007 - 2026") +
  theme_minimal()

allbus %>%
  group_by(ep01) %>%
  summarise("Total amount" = n()) |>
  rename("subjective state of the economy \n 1 = good 5 = bad" = ep01)
