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
  mutate(total_trade = export + import)

### 4. Compute the trade openness(total trade / GDP)
trade_df <- trade_df |>
  mutate(trade_openness = total_trade / GDP_USD)

### 5. Which EU country had the highest trade openness in 2019 Q4?
trade_df |>
    filter(year == 2019 & eu == "EU" & quarter == 4) |>
    filter(trade_openness == max(trade_openness, na.rm = TRUE))

### 6. Compute percentage of total trade for each country and quarter in 2019.
total_trade_percentage_2019 <- trade_df |>
    filter(year == 2019) |>
    summarise()