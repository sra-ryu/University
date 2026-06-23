# ==========================================================
# Project: Data Aggregation, Summary and Grouping
# Script Purpose: review of aggregation, summary and grouping functions
# Author: me
# Date: 2026-04-27
# ==========================================================

library(tidyverse)

### 1. Aggregation data and summarize -----
summarise(penguins, avg_body_mass = mean(body_mass, na.rm = TRUE))
summarise(penguins, max_body_mass = max(body_mass, na.rm = TRUE))

### Functions frequently used with summarise
### mean(), max(), min(), sd(), n(), n_distinct(), usw.

### 2. Grouping based on a specific column
group_by(penguins, species)

### 3. Aggregation data and summarize based on a specific column
summarise(group_by(penguins, species), avg_body_mass_by_species = mean(body_mass, na.rm = TRUE))

