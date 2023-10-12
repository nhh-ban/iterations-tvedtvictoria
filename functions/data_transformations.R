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

# Create "to_iso8601" function
  
library(anytime)
library(lubridate)

to_iso8601 <- function(datetime, offset_days) {
  datetime_and_offset_days <- datetime + days(offset_days) # Adds offset_days
  # to days in datetime
  iso8601_format <- iso8601(datetime_and_offset_days) #Format the modified
  # datetime to ISO8601-format
  return(iso8601_format)
}






  