# 03_eda.R
# Exploratory data analysis: distributions, missingness, relationships.
# Figures are saved to docs/ for inclusion in report.qmd.

library(tidyverse)
library(here)
library(haven)

# function for calculating the scale factor for plots
skalierung_berechnen <- function(dataset, variable) {
  scale <- max(elect_clean$afd, na.rm = TRUE) / max(dataset[[variable]], na.rm = TRUE)
  return(scale)
}

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

# scale factor for bip
skalierung_bip <- skalierung_berechnen(bip_clean, "growth_real")

# plot bip x afd polling
ggplot() +
  geom_path(
    data = elect_clean,
    aes(x = date, y = afd),
    color = "blue"
  ) +
  geom_path(
    data = bip_clean,
    aes(x = date, y = growth_real * skalierung_bip),
    color = "red"
  ) +
  scale_y_continuous(
    name = "AfD - polling",
    sec.axis = sec_axis(~ . / skalierung_bip, name = "Real GDP growth")
  ) +
  theme_minimal() +
  theme(
    axis.title.y = element_text(color = "blue", face = "bold"),
    axis.text.y = element_text(color = "blue"),
    axis.title.y.right = element_text(color = "red", face = "bold"),
    axis.text.y.right = element_text(color = "red")
  ) +
  labs(title = "Afd polling numbers compared to real GDP growth\n in Germany 2017 - 2026")

ggsave(filename = here("plots", "BIP_AFD.png"))
# We conclude:
# Pre-Covid: Mostly stable, albeit slow economic growth. Stable AFD-polling.
# Beginning of Covid: Polling and growth decline together, AfD does not profit from weak economy.
# Post-Lockdown-Effect: The economy bounces back, AfD numbers stay low.
# Economic stagnation: Growth slows down, AfD numbers start to rise again drastically.
# Recession: Interestingly, Right after the publication of the recessive 2024 numbers, the AfD numbers drop again.
# Hovering around the 0: The economy very slowly works its way out of the recession, while AFD polling now grows slower, but with barely any interuption
# Alltogether: Link between weak economy and strong AfD looks stronger after Covid.


#------------------------------------------------------------------------------
# plot for unemployment x vote share afd

unemployment_clean <- read_csv(here("data", "processed", "unemp_clean.csv"))

# unemployment rate over time
unemployment_clean |>
  ggplot(aes(date, unemployment_rate)) +
  geom_path()
# Conclusion:
# unem dropped till mid 2018
# stayed consistent till 2020
# surged till mid 2021 during covid
# fell sharply to pre pandemic levels in mid 2022
# consistent uptick in eunemp until today, slightly higher levels then
# the pandemic high

# scale factor for unemployment
skalierung_unemp <- skalierung_berechnen(unemployment_clean, "unemployment_rate")

# plot unemployment rate x afd polling numbers

ggplot() +
  geom_path(
    data = elect_clean,
    aes(
      x = date,
      y = afd
    ),
    color = "blue"
  ) +
  geom_path(
    data = unemployment_clean,
    aes(
      x = date,
      y = unemployment_rate * skalierung_unemp
    ),
    color = "red"
  ) +
  scale_y_continuous(
    name = "AfD - polling",
    sec.axis = sec_axis(~ . / skalierung_unemp, name = "Unemployment share")
  ) +
  theme_minimal() +
  theme(
    axis.title.y = element_text(color = "blue", face = "bold"),
    axis.text.y = element_text(color = "blue"),
    axis.title.y.right = element_text(color = "red", face = "bold"),
    axis.text.y.right = element_text(color = "red")
  ) +
  labs(title = "Afd polling numbers compared to unemployment rate\n in Germany 2017 - 2026")

ggsave(filename = here("plots", "UNEMPLOYMENT_AFD.png"))

# conclusion
# until 2020 no meaningful link is present
# 2020 - 2022 there is a inverse correlation, unemp rises, afd numers fall
# since 2022, unemp steadily rises, afd also gains in the long term


#----------------------------------------------------------------------
# allbus importieren
# wir verwenden allbus_mini_clean aus skript 03
# ep01 muss gewichtet werden
ep01_wght <- allbus_mini_raw |>
  filter(!(ep01 %in% c(-42, -11, -9, -8, -1))) |>
  group_by(year) |>
  summarise(ep01_mean = weighted.mean(ep01, w = wghtpew, na.rm = TRUE)) |>
  filter(year > 2014)

# afd polling numbers mean per year
avg_year_afd <- elect_clean |>
  group_by(jahr = format(date, "%Y")) %>%
  summarise(
    mittelwert = mean(afd, na.rm = TRUE)
  ) |>
  mutate(jahr = as.integer(jahr))

# skalierung afd / econ satisfaction
skalierung_ep01 <- skalierung_berechnen(ep01_wght, "ep01_mean")

# plot economy satisfaction x afd polling number
ggplot() +
  geom_point(
    data = avg_year_afd,
    aes(
      x = jahr,
      y = mittelwert
    ),
    color = "blue"
  ) +
  geom_line(
    data = avg_year_afd,
    aes(
      x = jahr,
      y = mittelwert
    ),
    color = "blue"
  ) +
  geom_point(
    data = ep01_wght,
    aes(
      x = year,
      y = ep01_mean * skalierung_ep01
    ),
    color = "red"
  ) +
  geom_line(
    data = ep01_wght,
    aes(
      x = year,
      y = ep01_mean * skalierung_ep01
    ),
    color = "red"
  ) +
  scale_y_continuous(
    name = "AfD - polling",
    sec.axis = sec_axis(~ . / skalierung_unemp, name = "Satisfaction with economy \n (1 = very good, 3 = somewhat, 5 = very bad)")
  ) +
  theme_minimal() +
  theme(
    axis.title.y = element_text(color = "blue", face = "bold"),
    axis.text.y = element_text(color = "blue"),
    axis.title.y.right = element_text(color = "red", face = "bold"),
    axis.text.y.right = element_text(color = "red")
  ) +
  labs(title = "Afd polling numbers compared to economic satisfaction\n in Germany 2017 - 2026")

ggsave(filename = here("plots", "ECON_SATISFACTION_AFD.png"))
# conclusion
# limitation: ony 3 allbus rounds while afd exists
# but trens is visible, worse economic situation correaltes to rising afd numbers
