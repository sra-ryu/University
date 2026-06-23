# ==========================================================
# Project: Practice pipe operator
# Script Purpose: review pipe operator
# Author: me
# Date: 2026-04-30
# ==========================================================

library(tidyverse)

### 1. Get the number of rows in penguins using pipe operator
penguins |> nrow()

### 2. summarise and compute the avg body mass of penguins
penguins |> summarise(avg_body_mass = mean(body_mass, na.rm = TRUE))

### 3. Get penguins grouped by species
penguins |> group_by(species)

### 4. Calculate the avg_body_mass by penguin species
penguins |> group_by(species) |> summarise(avg_body_mass = mean(body_mass, na.rm = TRUE))

### 5. Calculate the avg_body_mass and avg_bill_len by penguin species
penguins |> group_by(species) |> summarise(avg_bill_len = mean(bill_len, na.rm = TRUE), avg_body_mass = mean(body_mass, na.rm = TRUE))

### 6. Count the number of penguins per island
penguins |> group_by(island) |> summarise(count = n())
# n() returns a number of rows


