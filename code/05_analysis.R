# 05_analysis.R
# Main statistical analysis: modelling and inference.
library(tidyverse)
library(here)

findings <- "## Findings

Our analysis examines the relationship between macroeconomic conditions in Germany and support for the AfD, drawing on federal polling data, real GDP growth, unemployment figures, and ALLBUS survey data for the period from 2017 onward.
Looking first at AfD polling in isolation, support followed a distinctly non-linear path. After an initial decline over the course of 2017 and a partial recovery later that year, polling entered a phase of relative stagnation between 2018 and 2020. The onset of the COVID-19 pandemic coincided with a further drop and a sustained period at lower levels. From 2022 into 2023, support then roughly doubled in a steep and continuous climb, followed by a marked decline in 2024. Since then, polling has resumed a slower but nearly uninterrupted upward trend.
Setting these dynamics against real GDP growth reveals a relationship that appears to shift over time. In the pre-pandemic years, modest but steady economic growth was accompanied by broadly stable AfD support. During the early pandemic, polling and growth declined together, suggesting that the party did not benefit from the weakening economy in this phase; support likewise remained low through the post-lockdown recovery. The pattern changes from 2022 onward: as growth slowed into stagnation, AfD support rose sharply. Notably, support fell again shortly after the recessionary 2024 figures were published, before resuming its climb as the economy edged slowly out of recession.
Taken together, the descriptive evidence points to a link between a weak economy and stronger AfD support that appears more pronounced in the post-COVID period than before it. We emphasise that these are exploratory observations based on the co-movement of the series; a formal statistical test is required to establish whether the association is robust once other factors are accounted for."

writeLines(findings, here("docs", "findings.md"))
message("Wrote docs/findings.md")
