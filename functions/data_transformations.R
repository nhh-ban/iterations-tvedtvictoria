 # Create a function called "transform_metadata_to_df" which should complete
# the transformation of "stations_metadata" to a data frame similar to the one
# in the problem description.
# "LatestData" should be converted to *UTC* format.

# Load necessary libraries
library(tibble)
library(dplyr)
library(tidyverse)
library(purrr)

# Function to transform metadata to data frame

transform_metadata_to_df <- function(metadata) {
  stations_metadata[[1]] %>% 
    map(as_tibble) %>% 
    list_rbind() %>% 
    mutate(latestData = map_chr(latestData, 1, .default = NA_character_)) %>% 
    mutate(latestData = as_datetime(latestData, tz = "UTC")) %>% 
    unnest_wider(location) %>% 
    unnest_wider(latLon)
}



  