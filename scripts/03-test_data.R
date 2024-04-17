#### Preamble ####
# Purpose: Tests the cleaned Toronto Shelter System Flow data and Deaths of People Experiencing Homelessness data.
# Author: Irene Huynh
# Date: 2 April 2024
# Contact: irene.huynh@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)


#### Test homeless deaths data ####
deaths_test <- read_csv("data/analysis_data/cleaned_homeless_deaths_data.csv")

# Checking that there are exactly 78 entries/rows (12 months * 6 years + 6 months so far for 2023)
nrow(deaths_test) == 78

# Checking that the only years involved are from 2017 to 2023
deaths_test$year_of_death %in% c(2017, 2018, 2019, 2020, 2021, 2022, 2023)

# Checking that the only months involved are "January", "February", "March", "April", 
# "May", "June", "July", "August", "September", "October", "November", and "December"
deaths_test$month_of_death %in% c("January", "February", "March", "April", 
                                   "May", "June", "July", "August", "September", 
                                   "October", "November", "December")

# Checking the classes of the columns
deaths_test$year_of_death |> class() == "numeric"
deaths_test$month_of_death |> class() == "character"
deaths_test$count |> class() == "numeric"


#### Test shelter data ####
shelter_test <- read_csv("data/analysis_data/cleaned_toronto_shelters_data.csv")

# Checking that there are exactly 564 entries/rows
nrow(shelter_test) == 564

# Checking that the only years involved are from 2018 to 2023
substring(shelter_test$date, 5, 6) %in% c("18", "19", "20", "21", "22", "23", "24")

# Checking that the only population groups involved are "Chronic", "Refugees", "Families", 
# "Youth", "Single Adult", "Non-refugees", "Indigenous", and "All Population"
shelter_test$population_group %in% c("Chronic", "Refugees", "Families", 
                                   "Youth", "Single Adult", "Non-refugees", "Indigenous", 
                                   "All Population")

# Checking the classes of the columns
shelter_test$date |> class() == "character"
shelter_test$population_group |> class() == "character"
shelter_test$returned_from_housing |> class() == "numeric"
shelter_test$newly_identified |> class() == "numeric"
shelter_test$actively_homeless |> class() == "numeric"
shelter_test$age_under16 |> class() == "numeric"
shelter_test$age_16_24 |> class() == "numeric"
shelter_test$age_25_44 |> class() == "numeric"
shelter_test$age_45_64 |> class() == "numeric"
shelter_test$age_65over |> class() == "numeric"
shelter_test$gender_male |> class() == "numeric"
shelter_test$gender_female |> class() == "numeric"