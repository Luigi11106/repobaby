# 02_clean.R
# Reads raw data, applies cleaning steps, writes to data/processed/.

library(tidyverse)
library(here)
library(lubridate)
library(withr)

elect_raw <- read_csv(here("data", "raw", "election_survey.csv"))

elect_clean <- elect_raw %>%
  # First, we create a new date variable with the correct data type.
  mutate(date = as.Date(Datum, format = "%d.%m.%Y")) %>%
  # Then, we standardize the names of the columns.
  rename(cdu_csu = `CDU/CSU`) %>%
  rename(spd = SPD) %>%
  rename(gruene = Grüne) %>%
  rename(afd = AfD) %>%
  rename(fdp = FDP) %>%
  rename(linke = Linke) %>%
  rename(bsw = BSW) %>%
  rename(freie_waehler = `Freie Wähler`) %>%
  # Then, we transform the values into percentages
  mutate(cdu_csu = cdu_csu / 10) %>%
  mutate(spd = spd / 10) %>%
  mutate(gruene = gruene / 10) %>%
  mutate(afd = afd / 10) %>%
  mutate(fdp = fdp / 10) %>%
  mutate(linke = linke / 10) %>%
  mutate(bsw = bsw / 10) %>%
  mutate(freie_waehler = freie_waehler / 10) %>%
  # Finally, we remove the previous date variable
  select(-Datum)

unemp_clean <- unemp %>%
  # Here, we transform the date variable to fit the previous data set.
  separate(month, into = c("Monat_Text", "Jahr"), sep = " ") %>%
  mutate(Monat_Zahl = case_match(
    Monat_Text,
    "Januar" ~ "01", "Jan" ~ "01",
    "Februar" ~ "02", "Feb" ~ "02",
    "März" ~ "03", "Mär" ~ "03",
    "April" ~ "04", "Apr" ~ "04",
    "Mai" ~ "05",
    "Juni" ~ "06", "Jun" ~ "06",
    "Juli" ~ "07", "Jul" ~ "07",
    "August" ~ "08", "Aug" ~ "08",
    "September" ~ "09", "Sep" ~ "09",
    "Oktober" ~ "10", "Okt" ~ "10",
    "November" ~ "11", "Nov" ~ "11",
    "Dezember" ~ "12", "Dez" ~ "12",
    .default = NA_character_
  )) %>%
  mutate(date = as.Date(paste(Jahr, Monat_Zahl, "01", sep = "-"))) %>%
  select(-Monat_Text, -Jahr, -Monat_Zahl) %>%
  filter(date >= "2017-01-01")

bip_clean <- bip %>%
  # We choose december 31st as our date, because the gdp numbers of a year of course represent the year that is coming to an end.
  mutate(date = make_date(year = year, month = 12, day = 31)) %>%
  select(-year) %>%
  filter(date >= "2016-12-31") %>%
  filter(date <= "2026-12-31")

allbus_mini_raw <- read_dta(here("data", "raw", "allbus_mini.dta"))

allbus_mini_clean <- allbus_mini_raw %>%
  # Again, we choose december 31st as the date for all allbus observations from a year.
  mutate(date = make_date(year = year, month = 12, day = 31)) %>%
  filter(year > 2016)

write_csv(allbus_mini_clean, here("data", "processed", "allbus_mini_clean.dta"))
write_csv(elect_clean, here("data", "processed", "elect_clean.csv"))
write_csv(unemp_clean, here("data", "processed", "unemp_clean.csv"))
write_csv(bip_clean, here("data", "processed", "bip_clean.csv"))
## message("Wrote data/processed/data_clean.csv")
