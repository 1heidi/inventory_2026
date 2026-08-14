# GBC Biodata Inventory Update 2026

### Purpose: Repeat Update for the GBC Biodata Inventory

-   The GBC Biodata Inventory was conducted in 2022 and repeated in 2024 using BERT-based methods to classify articles and extract predicted resource names. This 2026 update was done with the same methods, including trained models, to identify new biodata resources published in the literature in 2024 and 2025.

### Result: 663 New Resources Identified for 2024 and 2025

| Inventory Year | Years Covered | \# Found | Total | Repo Link | Inventory File |
|:----------:|:----------:|:----------:|:----------:|:----------:|:----------:|
| 2022 | 2011-2021 | 3112 | 3112 | [inventory_2022](https://github.com/globalbiodata/inventory_2022) | final_inventory_2022.csv |
| 2024 | 2022-2023 | 661 | 3773 | [inventory_2024](https://github.com/globalbiodata/inventory_2024) | predictions_final_2024-07-12.csv |
| 2026 | 2024-2025 | 663 | 4436 | [you are here] | predictions_final_2026-08-07.csv |

### Key Files

-   ***predictions_final_2024-07-12.csv*** last inventory, covering years 2011-2023, used as input for this update to merge with newly identified resources
-   ***predictions_final_2026-08-07.csv*** updated inventory for years 2011-2025

### Process:

-   Started with updated [inventory_2022(main branch)](https://github.com/globalbiodata/inventory_2022)
-   Created branch [inventory_update_2026](https://github.com/1heidi/inventory_2022/tree/inventory_update_2026) for this exploratory effort
-   Repeated ML pipeline using Google Colab, creating a heavily modified notebook via Gemini: updating_inventory_2026.ipyn
    -   Per inventory instructions, updated config files and provided last inventory file (predictions_final_2024-07-12.csv) as required
    -   **All other modifications to adapt pipeline done in the notebook only**; no src files or otherwise were modified
    -   Retained previously updated updating_inventory.ipyn untouched for posterity
-   **(new this year)** Remove errant characters prior to manual review
    -   Note on file names: the ML pipeline outputs a file named predictions.csv for manual review and also inputs a file named predictions.csv post review to finish the pipeline; the file is temporarily renamed during the review steps to avoid confusion between versions
    -   Renamed to predictions.csv -\> predictions_raw_to_review.csv and then used this as input for deghost.R to remove encoding errors from special characters
    -   Resulting clean file, named deghost_predictions_raw_to_review.csv, was renamed to predictions_V1 for manual review
-   Completed manual review per [Manual Review Process for the Biodata Resource Inventory V2](https://doi.org/10.5281/zenodo.17644392)
    -   Resulting in post manual review file: **predictions_V4.csv**
    -   Also created a V3 of the guide
-   **(new this year)** Double check for encoding errors
    -   Run STEP_0_utf-8_verification.R
-   Use STEP_1_precheck_manual_reviewed.R from 2024 update to check that all flagged IDs have been reviewed with appropriate values
-   Saved file with required filename of predictions.csv to return to pipeline
-   Completed post-processing pipeline to get the final inventory for 2011-2025, resulting in file ***predictions_final_2026-08-07.csv***

### Exploratory Analysis:

-   663 new resources identified
-   Double checked counts between updates
    -   Oddly similar new resources counts for 2022/23 (661) and 2024/25 (663)
        -   Checked intermediate output files for issues -\> no issues with limits or bugs
        -   Checked query results -\> similar in \# but entirely different outputs

| Step | 2024 obs | 2026 obs | diff obs | pub year range |
|:-------------:|:-------------:|:-------------:|:-------------:|:-------------:|
| 01 query results | 4676 | 4597 | -79 | 2024: [2022-2023] & 2026: [2024-2025] |
| 08 processed manual review | 3773 | 4436 | 663 | 2024: [2011-2023] & 2026: [2011-2025] |
| 13 processed countries | 3773 | 4436 | 663 | 2024: [2011-2023] & 2026: [2011-2025] |

-   Prelim analysis of new resources
    -   STEP_2_analyze_new_resources.R
        -   As for last update, augmented w/ additional packages/scripts for better coverage just using R packages -- resulting analysis also helped confirm appropropriate/expected differences between the 2024 and 2026 updates. For better results, see upgraded work done for [GBC publication anlaysis](https://github.com/globalbiodata/gbc-publication-analysis), which used the [locationtagger](https://github.com/kaushiksoni10/locationtagger) Python module for see affiliation addresses.
        -   Generated CSVs of just new resources found in both unaugmented form (no additional attempts to pull country for URLs and affiliation) and augmented forms (light scripting to improve coverage from ML pipeline ouput)
