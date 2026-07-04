# GBC Biodata Inventory Update 2026

### Purpose: Repeat Update for the GBC Biodata Inventory

-   The GBC Biodata Inventory was conducted in 2022 and repeated in 2024 using BERT-based methods to classify articles and extract predicted resource names. This 2026 update was done with the same methods, including trained models, to identify new biodata resources published in the literature in 2024 and 2025.
   
### Result: XXX New Resources Identified

| Inventory Year | Years Covered | # Found | Total | Repo Link | Inventory File |
| :--------: | :--------: | :--------: | :--------: | :--------: | :--------: |
| 2022 | 2011-2021 | 3112 | 3112 | [inventory_2022](https://github.com/globalbiodata/inventory_2022) | final_inventory_2022.csv |
| 2024 | 2022-2023 | 661 | 3773 | [inventory_2024](https://github.com/globalbiodata/inventory_2024) | predictions_final_2024-07-12.csv |
| 2026 | 2024-2025 | XXX | XXXX | [you are here] | predictions_final_XXXX.csv |

### Key Files

- ***predictions_final_2024-07-12.csv*** last inventory, used as input for this update to compare and merge with newly identified resources
- ***predictions_vXXX.csv*** post manual review process
- ***predictions_final_XXXX.csv*** post complete pipeline

### Process:

-   Started with updated [inventory_2022(main branch)](https://github.com/globalbiodata/inventory_2022)
-   Created branch inventory_update_2026 for this exploratory effort
-   Repeated ML pipeline using Google Colab, creating a heavily modified notebook via Gemini: updating_inventory_2026.ipyn
    -   Used modifed config files and provided last inventory file as required
    -   All other modifications to adapt pipeline done in the notebook only; no src files or otherwise were modified
    -   Retained previously updated updating_inventory.ipyn untouched
-   Completed manual review per [Manual Review Process for the Biodata Resource Inventory V2](https://doi.org/10.5281/zenodo.17644392)
-   Used STEP_1_precheck_manual_reviewed.R from 2024 update to check that all flagged IDs have been reviewed with appropriate values
-   Cleanup per 2024 update, resulting in file ***predictions_vXXX.csv***
-   Completed post-processing pipeline to get the final inventory for 2011-2025, resulting in file ***predictions_final_XXXX.csv*** 
 
### Exploratory Analysis:

-   Analyzed new resources
    -   STEP_2_analyze_new_resources.R
    -   Author affiliation (total occurrences; may be \>1 per article)
    -   URL geocoordinates
    -   Both known to be tricky; augmented with additional packages/scripts for better coverage
        -   as is: new_biodata_resources_2026_unaugmented.csv
        -   with additional coverage: new_biodata_resources_2026_augmented.csv
            -   Top 5 Countries via Author Affiliations:
                -  * N (#)*
                -  * N (#)*
                -  * N (#)*
                -  * N (#)*
                -  * N (#)*
            -   Top 5 Countries via URL Geocoordinates:
                -  * N (#)*
                -  * N (#)*
                -  * N (#)*
                -  * N (#)*
                -  * N (#)*
            -   Notes on augmentation
                1)  Provision of input files and scripts allows for reproducibility but these scripts will not be generalizable for future updates! Data and code must be reviewed/edited for any future updates to ensure countries are not missed, etc.
