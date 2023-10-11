# This file contains tests to be applied to 
# the Vegvesen stations-data *after* being transformed
# to a data frame. 
# 
# All tests are packed in a function test_stations_metadata that apples
# all the aforementioned tests

test_stations_metadata_colnames <-
  function(df) {
    
    expected_colnames <- c("id", "name", "latestData", "lat", "lon")
    
    if (all(colnames(df) == expected_colnames) == TRUE) {
      print("PASS: Data has the correct columns")
    } else{
      print("FAIL: Columns do not match the correct specification")
    }
  }

# This is a function taking a data frame as its parameter.
# The function expects the column-names to be "id", "name", "latestData", "lat",
# and "lon"
# If the dataframe has these columns it will return "PASS: Data has the correct
# columns". If not the function will print "FALSE: Columns do not match the
# correct specification"

test_stations_metadata_nrows <-
  function(df) {
    
    min_expected_rows <- 5000
    max_expected_rows <- 10000
    
    if (nrow(df) > min_expected_rows & nrow(df) < max_expected_rows) {
      print("PASS: Data has a reasonable number of rows")
    } else if (nrow(df) <= min_expected_rows) {
      print("FAIL: Data has suspiciously few rows")
    } else {
      print("FAIL: Data has suspiciously many rows")
    }
  }


# This function prints "PASS" if the number of rows in the data frame is higher
# than the expected minimum number of row & lower than the maximum expected
# number of rows, i.e., the actual number of rows in the data frame is between,
# here, 5000 and 10 000
# The function prints "FAIL" if 1) the data has 5000 or less rows, and 2)
# if the data has 10 000 or more rows

test_stations_metadata_coltypes <-
  function(df) {
    expected_coltypes <-
      c("character", "character", "double", "double", "double")
    
    if (all(df %>%
            map_chr( ~ typeof(.)) == expected_coltypes) == TRUE) {
      print("PASS: All cols have the correct specifications")
    } else{
      print("FAIL: Columns do not have the correct specification")
    }
  }


# This function expects the column to be of a certain type. If the columns are
# "character", "Character", "double", "double, "double" respectively, it prints
# "PASS", if not it prints "FAIL"
  
test_stations_metadata_nmissing <-
  function(df) {
    max_miss_vals <- 200
    
    if (df %>% map_int( ~ sum(is.na((.)))) %>% sum(.) < max_miss_vals) {
      print("PASS: Amount of missing values is reasonable")
    } else {
      print("FAIL: Too many missing values in data set")
    }
  }


# This function checkes if the amount of missing values in the data frame is
# reasonable or not
# If the amount of missing values is less than max_miss_values (200), it prints
# "PASS". If the amount of missing values is 200 or more it prints "FAIL"

test_stations_metadata_latestdata_timezone <-
  function(df) {
    
    if (attr(df$latestData,"tzone")=="UTC") {
      print("PASS: latestData has UTC-time zone")
    } else {
      print("FAIL: latestData does not have expected UTC-time zone")
    }
  }

# This function checkes if the latestData column is set to have a UTC-time zone
# To do so it extracts the time zone attribute of "latestData"
# If the time zone (tzone) is UTC it prints "PASS", if not it prints "FAIL"


test_stations_metadata <- 
  function(df){
    test_stations_metadata_colnames(df)
    test_stations_metadata_coltypes(df)
    test_stations_metadata_nmissing(df)
    test_stations_metadata_nrows(df)
    test_stations_metadata_latestdata_timezone(df)
  }

# This function takes "df" as its parameter and run all of the above functions
# with that parameter.
# If the function from problem 2 is correct the data frame will pass all of the
# requirements, and this function will print "PASS ..." for all of the five
# functions

test_stations_metadata(stations_metadata_df)





