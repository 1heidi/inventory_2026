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
-   Created branch inventory_update_2026 for this exploratory effort
-   Repeated ML pipeline using Google Colab, creating a heavily modified notebook via Gemini: updating_inventory_2026.ipyn
    -   Updated config files and provided last inventory file, as required
    -   **All other modifications to adapt pipeline done in the notebook only**; no src files or otherwise were modified
    -   Retained previously updated updating_inventory.ipyn untouched for posterity
-   **(new this year)** remove errant characters
    -   Note that the ML pipeline outputs a file named predictions.csv for manual review and also inputs a file named predictions.csv post review to finish the pipeline; the file is temporarily renamed during the review steps to avoid confusion between versions
    -   Renamed to predictions.csv -\> predictions_raw_to_review.csv and then used this as input for deghost.R to remove encoding errors from special characters
    -   Resulting clean file, named deghost_predictions_raw_to_review.csv, was renamed to predictions_V1 for manual review
-   Completed manual review per [Manual Review Process for the Biodata Resource Inventory V2](https://doi.org/10.5281/zenodo.17644392)
    -   Resulting in post manual review file: **predictions_V4.csv**
-   **(new this year)** double check for encoding errors
    -   Run STEP_0_utf-8_verification.R
-   Use STEP_1_precheck_manual_reviewed.R from 2024 update to check that all flagged IDs have been reviewed with appropriate values
-   Saved file as **predictions.csv** to return to pipeline
-   Completed post-processing pipeline to get the final inventory for 2011-2025, resulting in file ***predictions_final_2026-08-07.csv***

### Exploratory Analysis:

-   Double check counts between updates
    -   Oddly similar new resources counts for 2022/23 (661) and 2024/25 (663)
        -   Checked intermediate output files for issues
        -   Query results very similar but not identical:

| Step | 2024 obs | 2026 obs | diff obs | pub year range |
|:-------------:|:-------------:|:-------------:|:-------------:|:-------------:|
| 01 query results | 4676 | 4597 | -79 | 2024: [2022-2023] & 2026: [2024-2025] |
| 06 for manual review | 3904 | 4557 | 653 | 2024: [2011-2023] & 2026: [2011-2025] |
| 08 processed manual review | 3773 | 4436 | 663 | 2024: [2011-2023] & 2026: [2011-2025] |
| 13 processed countries | 3773 | 4436 | 663 | 2024: [2011-2023] & 2026: [2011-2025] |

-   Analyzed new resources
    -   STEP_2_analyze_new_resources.R
    -   Author affiliation (total occurrences; may be \>1 per article)
    -   URL geocoordinates
    -   As last update, augmented w/ additional packages/scripts for better coverage
        -   as is: new_biodata_resources_2026_unaugmented.csv
        -   with additional coverage: new_biodata_resources_2026_augmented.csv
            -   Top 5 Countries via Author Affiliations:
