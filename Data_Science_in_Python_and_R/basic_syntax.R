# ==========================================================
# Project: Basic R Syntax Practice
# Script Purpose: basic syntax practice and review
# Author: me
# Date: 2026-04-23
# ==========================================================

library(tidyverse)

### 1. print all data set in R -----
# data()

### 2. Print data frame of penguins(dataset)
# penguins

### 3. Get number of columns and rows -----
nrow(penguins)
ncol(penguins)

### 4. Get all variable(columns) names -----
colnames(penguins)

### 5. Get class of data frame -----
class(penguins)

### 6. Get size of data frame -----
dim(penguins)

### 7. Find information of function -----
# ?dim
# ?dim()

### 8. Get the first n rows -----
slice_head(penguins, n = 5)

### 9. Get the last n rows -----
slice_tail(penguins, n = 5)

### 10. Get the n samples -----
slice_sample(penguins, n = 5)

### 11. Print the structure and values at a glance -----
glimpse(penguins)

### 12. Remove all redundant elements
distinct(penguins, species)
