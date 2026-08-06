# ==========================================
# VERIFY UTF-8 CSV AFTER EXPORTING FROM EXCEL
# ==========================================

library(readr)
library(dplyr)

# Change this to your exported CSV filename
input_filename <- "predictions_V4.csv"

cat("Loading file...\n")

df_check <- read_csv(
  input_filename,
  locale = locale(encoding = "UTF-8"),
  show_col_types = FALSE
)

cat("\n=====================================\n")
cat("UTF-8 VERIFICATION RESULTS\n")
cat("=====================================\n")

# ------------------------------------------
# Check 1: Mojibake characters
# ------------------------------------------

mojibake_count <- sum(
  grepl("Ã|Â|ƒ|‚|¬|Ç|√", unlist(df_check), perl = TRUE),
  na.rm = TRUE
)

cat("Mojibake artifacts found:", mojibake_count, "\n")

# ------------------------------------------
# Check 2: Hidden control characters
# ------------------------------------------

control_count <- sum(
  grepl("[[:cntrl:]]", unlist(df_check), perl = TRUE),
  na.rm = TRUE
)

cat("Control characters found:", control_count, "\n")

# ------------------------------------------
# Check 3: Unicode replacement characters (�)
# ------------------------------------------

replacement_count <- sum(
  grepl("\uFFFD", unlist(df_check), perl = TRUE),
  na.rm = TRUE
)

cat("Replacement characters (�) found:", replacement_count, "\n")

# ------------------------------------------
# Summary
# ------------------------------------------

if (mojibake_count == 0 &&
    control_count == 0 &&
    replacement_count == 0) {
  
  cat("\n✅ SUCCESS: The CSV appears to be UTF-8 clean.\n")
  
} else {
  
  cat("\n⚠ WARNING: Possible encoding issues remain.\n")
  cat("Inspect the affected records before analysis.\n")
  
}

# ------------------------------------------
# Open data viewer
# ------------------------------------------

View(df_check)

# Optional preview
head(df_check)
tail(df_check)