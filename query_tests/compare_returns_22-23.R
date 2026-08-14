# =====================================================
# COMPARE 2024 and 2026 QUERY RESULTS FOR YRS 2022-2023
# =====================================================

library(europepmc)
library(tidyverse)

pmids_2022_23 <- epmc_search(sprintf(base_query, 2022, 2023), limit = 100000) %>% select(pmid)
sum(is.na(ids26$pmid))

ids26 <- pmids_2022_23
ids24 <- read.csv("query_results_2024.csv")
ids24 <- ids24 %>% mutate(id = as.character(id))

no_match <- anti_join(ids26, ids24, by = "id")

# Build single batch query from the 'id' column
batch_query <- paste0("EXT_ID:(", paste(no_match$id, collapse = " OR "), ")")

# Fetch metadata from Europe PMC
meta_results <- epmc_search(query = batch_query, limit = nrow(no_match)) %>%
  select(
    id = pmid,
    title,
    year = pubYear,
    journal = journalTitle,
    author = authorString
  ) %>%
  mutate(id = as.character(id))

# Join metadata back into no_match
no_match <- no_match %>%
  left_join(meta_results, by = "id")

write.csv(no_match, "compare_22-23.csv", row.names = FALSE)

