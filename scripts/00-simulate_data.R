#### Preamble ####
# Purpose: Simulates Toronto Shelter System Flow data from 2018 to 2023 and Toronto homeless deaths data.
# Author: Irene Huynh
# Date: 2 April 2024
# Contact: irene.huynh@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)


#### Simulate shelter data ####
set.seed(123) # For reproducibility 

n <- 504 # Number of observations/rows in the table

# Dates for each row
date_seq <- seq.Date(from=mdy("01-01-2018") , to=mdy("12-01-2023"), by="month")

simulated_shelter_data <-
  tibble(
    # Use 1 through to 504 to represent each id
    id = 1:504,
    date = rep(x = date_seq, each = 7),
    population_group = sample(c("Chronic", "Refugees", "Families", "Youth", "Single Adult", "Non-Refugees"), n, replace=TRUE),
    # Randomly pick an integer, with replacement, n times
    returned_from_housing = sample(1:200, n, replace=TRUE),
    newly_identified = sample(1:2000, n, replace=TRUE),
    actively_homeless = sample(1:11000, n, replace=TRUE),
    age_under16 = sample(1:2000, n, replace=TRUE),
    age_16_24 = sample(1:2000, n, replace=TRUE),
    age_25_44 = sample(1:5000, n, replace=TRUE),
    age_45_64 =sample(1:4000, n, replace=TRUE),
    age_65over = sample(1:700, n, replace=TRUE),
    gender_male = sample(1:7000, n, replace=TRUE),
    gender_female = sample(1:5000, n, replace=TRUE),
  )

# Format the date as seen in the original data set
simulated_shelter_data$date <- format(as.Date(simulated_shelter_data$date), "%b-%y")

simulated_shelter_data


### Simulate homeless deaths data ###
n <- 84 # 7 years * 12 months in each year

simulated_deaths_data <- 
  tibble(
    year = rep(x = c(2017, 2018, 2019, 2020, 2021, 2022, 2023), each = 12),
    month = rep(x = c("January", "February", "March", "April", 
                     "May", "June", "July", "August", "September", 
                     "October", "November", "December"), each = 1, times = 7),
    count = sample(1:50, n, replace=TRUE)
    )

simulated_deaths_data
