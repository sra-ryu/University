library(tidyverse)

penguins_data <- read_csv('data/gentoo_penguins.csv')
# print(slice_head(penguins_data))

print(slice_max(penguins_data, flipper_len))