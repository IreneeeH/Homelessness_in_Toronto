#### Preamble ####
# Purpose: Downloads and saves the Toronto Shelter System Flow data and Deaths of People Experiencing Homelessness data from opendatatoronto.
# Author: Irene Huynh
# Date: 2 April 2024
# Contact: irene.huynh@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)
library(dplyr)


#### Download shelter data ####
toronto_shelters <-
  # Each package is associated with a unique id  found in the "For 
  # Developers" tab of the relevant page from Open Data Toronto
  # https://open.toronto.ca/dataset/toronto-shelter-system-flow/
  list_package_resources("ac77f532-f18b-427c-905c-4ae87ce69c93") |>
  filter(name == "toronto-shelter-system-flow.csv") |>
  # Having reduced the dataset to one row we can get the resource
  get_resource()


#### Save shelter data ####
write_csv(toronto_shelters, "data/raw_data/raw_toronto_shelters_data.csv") 


#### Download homeless deaths data ####
package <- show_package("a7ae08f3-c512-4a88-bb3c-ab40eca50c5e")
package

# Get all resources for this package
resources <- list_package_resources("a7ae08f3-c512-4a88-bb3c-ab40eca50c5e")

# Identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# Load the first datastore resource as a sample
data <- filter(datastore_resources, row_number()==1) %>% get_resource()


### Save homeless deaths data ###
write_csv(data, "data/raw_data/raw_homeless_deaths_data.csv")