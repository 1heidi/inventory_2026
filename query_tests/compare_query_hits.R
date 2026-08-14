# ==========================================
# TEST and COMPARE 2-YR QUERY CHUNKS 
# ==========================================

library(europepmc)
library(tidyverse)

base_query <- '(ABSTRACT:(www OR http*) AND ABSTRACT:(data OR resource OR database*)) NOT (TITLE:(retract* OR withdraw* OR erratum)) NOT (ABSTRACT:(retract* OR withdraw* OR erratum OR github.* OR cran.r OR youtube.com OR bitbucket.org OR links.lww.com OR osf.io OR bioconductor.org OR annualreviews.org OR creativecommons.org OR sourceforge.net OR bit.ly OR zenodo OR onlinelibrary.wiley.com OR proteomecentral.proteomexchange.org/dataset OR oxfordjournals.org/nar/database OR figshare OR mendeley OR .pdf OR "clinical trial" OR registration OR "trial registration" OR clinicaltrial OR "registration number" OR pre-registration OR preregistration)) AND (SRC:(MED OR PMC OR AGR OR CBA)) AND (FIRST_PDATE:[%d TO %d])'

# Define the 2-year periods from 2010-2011 up to 2024-2025
years_df <- tibble(
  start_year = seq(2010, 2024, by = 2),
  end_year   = seq(2011, 2025, by = 2)
)

# Iterate over each period and fetch the total hits count
results <- years_df %>%
  mutate(
    period = paste0(start_year, "-", end_year),
    query  = sprintf(base_query, start_year, end_year),
    hits   = map_int(query, epmc_hits)
  ) %>%
  select(period, start_year, end_year, hits)

write.csv(results, "query_hit_comparison.csv", row.names = FALSE)

## plot

ggplot(results, aes(x = period, y = hits)) +
  geom_col(fill = "#2b5c8f", width = 0.7) +
  geom_text(aes(label = scales::comma(hits)), vjust = -0.5, size = 3.5) +
  scale_y_continuous(labels = scales::comma, expand = expansion(mult = c(0, 0.15))) +
  labs(
    title = "Europe PMC Query Hits by 2-Year Interval",
    subtitle = "Counts for search query across 2010–2025",
    x = "2-Year Period",
    y = "Total Hits"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold"),
    axis.text.x = element_text(angle = 45, hjust = 1),
    panel.grid.major.x = element_blank()
  )