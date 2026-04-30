# ==========================================================
# Project: Read and Write Data
# Script Purpose: practicing reading and writing data
# Author: me
# Date: 2026-04-30
# ==========================================================

library(tidyverse)

### 1. Save a data frame, that only has Gentoo penguins, as CSV file
gentoo_penguins <- penguins |> filter(species == 'Gentoo')
write_csv(gentoo_penguins, 'gentoo_penguins.csv')

### 2. Read csv file, 'gentoo_penguins.csv'
read_csv('gentoo_penguins.csv')

### 3. Save 'gentoo_penguins.csv' to gentoo_penguins
gentoo_penguins <- read_csv('gentoo_penguins.csv')

### 4. Inspect the structure with glimpse()
glimpse(gentoo_penguins)

### 5. Make a new directory for gentoo_penguins
dir.create('gentoo_penguins')

### 6. Move working directory to 'gentoo_penguins'
setwd('gentoo_penguins/')
getwd() # check current directory

### 7. Make subdirectory 'data' and write 'gentoo_penguins.csv' there
write_csv(gentoo_penguins, 'data/gentoo_penguins.csv')

### 8. In 'analysis.R', save 'gentoo_penguins.csv' to penguins_data
### print one line of penguins_data and run script with source()
source('analysis.R')

### 9. On what island do the Gentoo penguins have the longest flippers?
### Write command in 'analysis.R' and run it.
# add: slice_max(gentoo_penguins, flipper_len)
source('analysis.R')
