# Project Title

> Replace this with a short description of your project and dataset.

## Research Questions

1.  To what extent do economic fluctuations (measured by GDP, growth, or a decline in GDP) influence voting intention and the polling numbers of the AfD?

## Dataset

- **Source:** <!-- URL or citation -->
- **Licence:** GESIS ToS
- **Description:** The ALLBUS cumulative data set contains survey data from Germany, with key variables covering socio-demographics, political attitudes and social values.

<!-- -->

- **Source:** https://www.bundesfinanzministerium.de/Datenportal/Daten/offene-daten/wirtschaft-und-finanzen/s33-bruttoinlandsprodukt/s33-bruttoinlandsprodukt.html
- **Licence:** Datenlizenz Deutschland - Namensnennung Version 2.0
- **Description:** This BIP data set contains key economic values in Germany since 1980

<!-- -->

- **Source:** https://dawum.de
- **Licence:** Open Data Commons Open Database License (ODbL)
- **Description:** Polling numbers for all parties in Germany

<!-- -->

- **Source:** <!-- URL or citation -->
- **Licence:** <!-- e.g. CC BY 4.0 -->
- **Description:** Unemployment data Germany since 2007

## Group Members

| Name.            | GitHub username |
|------------------|-----------------|
| Luis Baumgartner | Luigi11106      |
| Colin Reck       | cfkm88qsmj-byte |
| Luca Friedel     | luggi211        |
| Paul Petras      | Krampfheli      |

## Repository Structure

```         
data/raw/        read-only raw data and licence documentation
data/processed/  cleaned data produced by code/02_clean.R
code/            numbered R scripts (01 download → 02 clean → 03 EDA → 04 analysis)
docs/            rendered Quarto website output (auto-generated, do not edit)
proposal.qmd     W07 project proposal
report.qmd       final analysis report
```

## How to reproduce

``` r
# 1. Install dependencies
renv::restore()   # if using renv, otherwise install packages manually

# 2. Run the pipeline in order
source("code/01_download.R")
source("code/02_prepare_allbus_dataset.R")
source("code/03_clean.R")
source("code/04_eda.R")
source("code/05_analysis.R")


# 3. Render the website
quarto::quarto_render()
```
