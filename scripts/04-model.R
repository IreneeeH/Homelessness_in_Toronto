#### Preamble ####
# Purpose: Models the predicated number of deaths of homeless individuals based on the month.
# Author: Irene Huynh
# Date: 2 April 2024
# Contact: irene.huynh@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(modelsummary)


#### Read data ####
cleaned_homeless_deaths_data <- read_parquet("data/analysis_data/cleaned_homeless_deaths_data.parquet")


### Model data ####
deaths_months_prediction <-
  stan_glm(
    count ~ month_of_death,
    data = cleaned_homeless_deaths_data,
    family = poisson(link = "log"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 853
  )


#### Save model ####
saveRDS(
  deaths_months_prediction,
  file = "models/deaths_months_prediction.rds"
)


### View model summary ###
modelsummary(
  list(
    "Month" = deaths_months_prediction
  )
)
