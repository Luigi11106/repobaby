# 03_eda.R
# Exploratory data analysis: distributions, missingness, relationships.
# Figures are saved to docs/ for inclusion in report.qmd.

library(tidyverse)
library(here)

elect_clean <- read_csv(here("data", "processed", "elect_clean.csv"))
bip_clean <- read_csv(here("data", "processed", "bip_clean.csv"))

# TODO: add EDA plots and summaries
glimpse(elect_clean)

elect_clean %>% ggplot(aes(x = date, y = afd)) +
  geom_path()
# We conclude:
# 1. Decline during 2017
# 2. Resurface late in 2017
# 3. Stagnation from 2018-2020
# 4. Drop and low stagnation during Covid
# 5. Steep twofold increase in 2022 and 2023
# 6. Steep decline in 2024
# 7. Almost constant growth until today

skalierung <- max(elect_clean$afd, na.rm = TRUE) / max(bip_clean$growth_real, na.rm = TRUE)
ggplot() +
  geom_path(
    data = elect_clean,
    aes(x = date, y = afd),
    color = "blue"
  ) +
  geom_path(
    data = bip_clean,
    aes(x = date, y = growth_real),
    color = "red"
  ) +
  scale_y_continuous(
    name = "AfD - polling",
    sec.axis = sec_axis(~ . / skalierung, name = "Real GDP growth")
  ) +
  theme_minimal() +
  theme(
    axis.title.y = element_text(color = "blue", face = "bold"),
    axis.text.y = element_text(color = "blue"),
    axis.title.y.right = element_text(color = "red", face = "bold"),
    axis.text.y.right = element_text(color = "red")
  )
# We conclude:
# Pre-Covid: Mostly stable, albeit slow economic growth. Stable AFD-polling.
# Beginning of Covid: Polling and growth decline together, AfD does not profit from weak economy.
# Post-Lockdown-Effect: The economy bounces back, AfD numbers stay low.
# Economic stagnation: Growth slows down, AfD numbers start to rise again drastically.
# Recession: Interestingly, Right after the publication of the recessive 2024 numbers, the AfD numbers drop again.
# Hovering around the 0: The economy very slowly works its way out of the recession, while AFD polling now grows slower, but with barely any interuption
# Alltogether: Link between weak economy and strong AfD looks stronger after Covid.
