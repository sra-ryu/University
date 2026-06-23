# ==========================================================
# Project: Transforming Data
# Script Purpose: practicing transforming data
# Author: me
# Date: 2026-04-30
# ==========================================================

library(tidyverse)

### 1. Select only species, body_mass, and sex columns of penguins
penguins |> select(species, body_mass, sex)

### 2. Drop the year column of penguins
penguins |> select(-year)

### 3. Compute average body mass per species and island, and keep only species, island, and body mass
penguins |>
  select(species, island, body_mass) |>
  group_by(species, island) |>
  summarise(avg_body_mass = mean(body_mass, na.rm = TRUE))

### 4. Filter penguins by sex, removing NA values
penguins |> filter(!is.na(sex))

### 5. Filter all Adelie penguins
penguins |> filter(species == 'Adelie')

### 6. Filter penguins whose body mass is more than 5000 grams
penguins |> filter(body_mass > 5000)

### 7. Filter female Gentoo penguins, them compute average body mass per island
penguins |>
  filter(species == 'Gentoo' & sex == 'female') |>
  group_by(island) |>
  summarise(avg_body_mass = mean(body_mass, na.rm = TRUE))

### 8. Add a body_mass_kg column that covert body_mass from grams to kilos
penguins |> mutate(body_mass_kg = body_mass / 1000)
# mutate doesn't change original dataset, it returns new dataset with extra columns

### 9. Filter Chinstrap penguins and select only species and body_mass, then add a body_mass_kg, and save it to chinstrap_mass
chinstrap_mass <- penguins |>
  select(species, body_mass) |>
  mutate(body_mass_kg = body_mass / 1000)

### 10. Filter large penguins(body_mass > 4500) and add a new column body_mass_kg
### Keep only species, sex, bill_len, and body_mass_kg and compute avg bill len and avg body mass kg by species and sex
### Save the result to large_penguins
large_penguins <- penguins |>
  filter(body_mass > 4500) |>
  mutate(body_mass_kg = body_mass / 1000) |>
  select(species, sex, bill_len, body_mass_kg) |>
  group_by(species, sex) |>
  summarise(
    avg_bill_len = mean(bill_len, na.rm = TRUE), 
    avg_body_mass = mean(body_mass_kg, na.rm = TRUE)
    )

print(large_penguins)
