# ==========================================
# REMOVE ENCODING ERRORS
# ==========================================

if (!require("readr")) install.packages("readr")
if (!require("tidyverse")) install.packages("tidyverse")

library(readr)
library(dplyr)
library(stringr)

obliterate_mojibake_chains <- function(vec) {
  if (!is.character(vec)) return(vec)
  
  # Force UTF-8
  vec <- enc2utf8(vec)
  
  # 1. Remove long runs like ÃÂÃÂÃÂÃÂ...
  vec <- str_replace_all(vec, "(?:Ã|Â)+", "")
  
  # 2. Remove remaining mojibake characters
  vec <- str_replace_all(vec, "[ÃÂƒ‚¬Ç√É]", "")
  
  # 3. Remove ALL ASCII control characters (removes   etc.)
  vec <- str_replace_all(vec, "[[:cntrl:]]", "")
  
  # 4. Remove Unicode control/format characters
  vec <- str_replace_all(vec, "[\\p{Cc}\\p{Cf}]", "")
  
  # 5. Remove non-breaking spaces
  vec <- str_replace_all(vec, "[\\u00A0\\u2007\\u202F]", " ")
  
  # 6. Collapse whitespace
  vec <- str_replace_all(vec, "\\s+", " ")
  
  # 7. Trim
  vec <- str_trim(vec)
  
  return(vec)
}

# ==========================================
# RUN THE PIPELINE
# ==========================================

input_filename  <- "predictions_raw_to_review.csv"
output_filename <- "deghost_predictions_raw_to_review.csv"

cat("Loading file...\n")
df <- read_csv(
  input_filename,
  locale = locale(encoding = "UTF-8"),
  show_col_types = FALSE
)

cat("Obliterating mojibake...\n")
df_clean <- df %>%
  mutate(across(where(is.character), obliterate_mojibake_chains))

cat("Saving clean file...\n")
write_excel_csv(df_clean, output_filename, na = ""
)

cat("Done! Check your folder for:", output_filename, "\n")

