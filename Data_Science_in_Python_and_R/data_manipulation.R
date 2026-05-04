# ==========================================================
# Project: Data Manipulation
# Script Purpose: review data manipulation
# Author: me
# Date: 2026-05-03
# ==========================================================

library(tidyverse)

### 1. Read and inspect the dataset. How many observations do the data have?
trade_df <- read_csv('trade_incl_GDP.csv')
ncol(trade_df)

### 2. What are those variables, what do they encode?
glimpse(trade_df)

### 3. Calculate total trade(imports + exports).
trade_df <- trade_df |>
  group_by(country) |>
  mutate(total_trade = sum(export + import))

### 4. Compute the trade openness(total trade / GDP)
trade_df <- trade_df |>
  group_by(country) |>
  mutate(openness = total_trade / GDP_USD)

### 5. 