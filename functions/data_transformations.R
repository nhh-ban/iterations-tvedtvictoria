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


# Define the to_iso8601 function
to_iso8601 <- function(date_time, offset_days) {
  # Add the offset in days
  adjusted_date <- date_time + days(offset_days)
  # Converts the adjusted_date to ISO8601 format. Tried to use the iso8601
  # function to do this, but did not find out exactly how to include the "Z" at
  # the end of the printed result when using this function. Therefore, I decided
  # to just format it manually
  iso8601_date <- format(adjusted_date, "%Y-%m-%dT%H:%M:%SZ")
  
  return(iso8601_date)
}














  