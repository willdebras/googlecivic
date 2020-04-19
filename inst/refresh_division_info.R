#!/usr/bin/R

# The `representativeInfoByDivision` API uses Open Civic Data division IDs to
# identify locations. These divisions can be queried with the division search
# endpoint, but the data itself is published by Open Civic Data. This script
# downloads that data and updates it in the package.

# Links:
# Open Civic Data Division ID docs: http://docs.opencivicdata.org/en/latest/proposals/0002.html
# Data on github: https://github.com/opencivicdata/ocd-division-ids/blob/master/identifiers/country-us.csv


ocd_divisions <- read.csv(
  'https://github.com/opencivicdata/ocd-division-ids/blob/master/identifiers/country-us.csv?raw=true',
  stringsAsFactors = FALSE,
  na.strings = c("NA", ""),
  colClasses = c(
    "validThrough" = "Date",
    "validFrom" = "Date"
  ),
  encoding = "UTF-8"
)

usethis::use_data(ocd_divisions, overwrite = TRUE)
