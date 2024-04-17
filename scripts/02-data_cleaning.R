#### Preamble ####
# Purpose: Cleans the raw Toronto Shelter System Flow data and Deaths of People Experiencing Homelessness data from opendatatoronto.
# Author: Irene Huynh
# Date: 2 April 2024
# Contact: irene.huynh@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)
library(janitor)
library(dplyr)
library(arrow)


#### Clean shelter data ####
raw_toronto_shelters_data <- read_csv("data/raw_data/raw_toronto_shelters_data.csv")

cleaned_toronto_shelters_data <-
  raw_toronto_shelters_data |> 
  rename(date = date.mmm.yy., 
         age_under16 = ageunder16,
         age_16_24 = age16.24,
         age_25_44 = age25.44,
         age_45_64 = age45.64,
         age_65over = age65over) |>
  clean_names() |>
  select(date, 
         population_group, 
         returned_from_housing, 
         newly_identified, 
         actively_homeless, 
         age_under16, 
         age_16_24, 
         age_25_44, 
         age_45_64, 
         age_65over,
         gender_male, 
         gender_female)

# Remove last row with NAs
cleaned_toronto_shelters_data <- cleaned_toronto_shelters_data %>% filter(row_number() <= n()-1)


#### Save shelter data ####
write_csv(cleaned_toronto_shelters_data, "data/analysis_data/cleaned_toronto_shelters_data.csv")
write_parquet(cleaned_toronto_shelters_data, "data/analysis_data/cleaned_toronto_shelters_data.parquet")


### Clean homeless deaths data ###
raw_homeless_deaths_data <- read_csv("data/raw_data/raw_homeless_deaths_data.csv")

cleaned_homeless_deaths_data <- 
  raw_homeless_deaths_data |>
  rename(year_of_death = Year_of_death,
         month_of_death = Month_of_death,
         count = Count) |>
  clean_names() |>
  filter(month_of_death != "Unknown") |>
  select(year_of_death, month_of_death, count)

months = c("January", "February", "March", "April", "May", "June", "July", "August", "September",
           "October", "November", "December")

# Rename all months to only the first three letters of the month
for (i in 1:12){
  cleaned_homeless_deaths_data$month_of_death[cleaned_homeless_deaths_data$month_of_death==months[i]] <- substring(months[i], 1, 3)
}


#### Save homeless deaths data ####
write_csv(cleaned_homeless_deaths_data, "data/analysis_data/cleaned_homeless_deaths_data.csv")
write_parquet(cleaned_homeless_deaths_data, "data/analysis_data/cleaned_homeless_deaths_data.parquet")