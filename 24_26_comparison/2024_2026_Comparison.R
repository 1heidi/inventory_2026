## Note: as assessing, remember some outputs cover just the query years while the others are for the entire inventory period!

## outputs from 2026 run
o01_26 <- read.csv("1 2026 query results.csv")
o02_26 <- read.csv("2 2026 class pred.csv")
o03_26 <- read.csv("3 2026 class pred pos.csv")
o04_26 <- read.csv("4 2026 ner.csv")
o05_26 <- read.csv("5 2026 init dedup.csv")
o06_26 <- read.csv("6 2026 for man review.csv")
o07_26 <- read.csv("7 2026 man review.csv")
o08_26 <- read.csv("8 2026 proc man review.csv")
o09_26 <- read.csv("9 2026 proc names.csv")
o10_26 <- read.csv("10 2026 url extract.csv")
o11_26 <- read.csv("11 2026 url check.csv")
o12_26 <- read.csv("12 2026 epmc meta.csv")
o13_26 <- read.csv("13 2026 proc countries.csv")

## outputs from 2024 run
o01_24 <- read.csv("1 2024 query results.csv")
o02_24 <- read.csv("2 2024 class pred.csv")
o03_24 <- read.csv("3 2024 class pred pos.csv")
o04_24 <- read.csv("4 2024 ner.csv")
o05_24 <- read.csv("5 2024 init dedup.csv")
o06_24 <- read.csv("6 2024 for man review.csv")
o07_24 <- read.csv("7 2024 man review.csv")
o08_24 <- read.csv("8 2024 proc man review.csv")
o09_24 <- read.csv("9 2024 proc names.csv")
o10_24 <- read.csv("10 2024 url extract.csv")
o11_24 <- read.csv("11 2024 url check.csv")
o12_24 <- read.csv("12 2024 epmc meta.csv")
o13_24 <- read.csv("13 2024 proc countries.csv")

## Create table of observations per year

# 1. Group objects into ordered lists
list_24 <- list(o01_24, o02_24, o03_24, o04_24, o05_24, o06_24, o07_24, o08_24, o09_24, o10_24, o11_24, o12_24, o13_24)
list_26 <- list(o01_26, o02_26, o03_26, o04_26, o05_26, o06_26, o07_26, o08_26, o09_26, o10_26, o11_26, o12_26, o13_26)

# 2. Define step names (first + last part of file name)
step_names <- c(
  "01 query results", "02 class pred", "03 class pred pos", 
  "04 ner", "05 init dedup", "06 for man review", 
  "07 man review", "08 proc man review", "09 proc names", 
  "10 url extract", "11 url check", "12 epmc meta", "13 proc countries"
)

# 3. Helper function to extract year range from YYYY-MM-DD "publication_date"
get_pub_year_range <- function(df) {
  if (is.null(df) || nrow(df) == 0) return("N/A")
  
  # Search for publication_date or date-related column
  col_match <- grep("publication_date|pub.*date|^date$", colnames(df), ignore.case = TRUE, value = TRUE)[1]
  if (is.na(col_match)) return("N/A")
  
  # Extract first 4 characters (YYYY) and convert to numeric
  yrs <- suppressWarnings(as.numeric(substr(as.character(df[[col_match]]), 1, 4)))
  yrs <- yrs[!is.na(yrs) & yrs >= 1900 & yrs <= 2026] # Sanity check for valid year range
  
  if (length(yrs) == 0) return("N/A")
  
  paste0(min(yrs), "-", max(yrs))
}

# 4. Construct summary data frame (13 rows x 5 columns)
comparison_df <- data.frame(
  step_name = step_names,
  obs_2024 = sapply(list_24, nrow),
  obs_2026 = sapply(list_26, nrow),
  diff_obs = sapply(list_26, nrow) - sapply(list_24, nrow),
  pub_year_range = sapply(1:13, function(i) {
    r24 <- get_pub_year_range(list_24[[i]])
    r26 <- get_pub_year_range(list_26[[i]])
    paste0("2024: [", r24, "] | 2026: [", r26, "]")
  }),
  stringsAsFactors = FALSE
)

write.csv(comparison_df,"2024_2026_output_comparison.csv", row.names = FALSE)
