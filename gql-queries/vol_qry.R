# Create vol_qry(id, from, to)-function

vol_qry <- function(id, from, to) {
  query <- glue::glue('
    {{
      trafficData(trafficRegistrationPointId: "{id}") {{
        volume {{
          byHour(from: "{from}", to: "{to}") {{
            edges {{
              node {{
                from
                to
                total {{
                  volumeNumbers {{
                    volume
                  }}
                }}
              }}
            }}
          }}
        }}
      }}
    }}
  ', id = id, from = from, to = to)
  
  return(query)
}


# Double braces help to distinguish glue expressions from other characters in
# the string. We use double braces to avoid conflicts with regular text that
# might contain single braces. The glue-function interpolate variables and
# expressions into strings. Interpolation is the process of inserting the values
# of variables or expressions into a template string at specific placeholders
#indicated with {}

GQL(
  vol_qry(
    id = stations_metadata_df$id[1],
    from = to_iso8601(stations_metadata_df$latestData[1], -4),
    to = to_iso8601(stations_metadata_df$latestData[1], 0)),
  .url = configs$vegvesen_url[1]
)




# I used the example below to check if the function printed the correct answer

vol_qry(
  id = stations_metadata_df$id[1],
  from = to_iso8601(stations_metadata_df$latestData[1], -4),
  to = to_iso8601(stations_metadata_df$latestData[1], 0))






