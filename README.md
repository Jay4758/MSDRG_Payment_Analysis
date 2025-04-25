# MSDRG_Payment_Analysis

This project was created for Module 6 of my Health Data Management II course. It focuses on analyzing inpatient hospital payment data using MS-DRG codes from the 2017 and 2018 Medicare datasets.

## What This Project Does

The goal was to explore how average payments from **non-Medicare sources** (like patient copays and private insurance) vary by:
- MS-DRG (Medical Severity Diagnosis-Related Groups)
- U.S. state
- Year (comparing 2017 and 2018)

## Tools Used

- **MySQL Workbench** – for querying and exporting the Medicare datasets
- **RStudio** with the `dplyr` and `ggplot2` packages – for data wrangling and creating visualizations

## Visuals Included

The R script creates several types of charts:
- Bar chart: top 50 DRGs by non-Medicare payment amount
- Cleveland dot plots: payment amounts by DRG and by state (for spinal fusion procedures)
- Heat maps: show payment variation by DRG and state, and year-to-year changes

## Files in This Repository

- `Ch7_R_Code.R`: Full R script used to process, analyze, and visualize the data
- `Ch7_SQL_Queries.sql`: SQL code used to extract the data from the textbook database
- `README.md`: You're reading it!

## Author

Created by **Jason Morocho**  
GitHub: [@Jay4758](https://github.com/Jay4758)
