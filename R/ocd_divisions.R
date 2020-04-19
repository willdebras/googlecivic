#' Open Civic Data Division Identifiers
#'
#' A data frame of Open Civic Data division identifiers. The IDs are suitable
#' passing to Google Civic Information API's `representativeInfoByDivision`
#' endpoint. Searching for relevant strings in `name` can help locate relevant
#' IDs.
#'
#' @format A data frame with 193,493 row and 13 columns, including
#'
#' - id
#' - name
#' - sameAs
#' - sameAsNote
#' - validThrough
#' - census_geoid
#' - census_geoid_12
#' - census_geoid_14
#' - openstates_district
#' - placeholder_id
#' - sch_dist_stateid
#' - state_id
#' - validFrom
#'
#' @source [OpenCivicData](https://github.com/opencivicdata/ocd-division-ids/blob/master/identifiers/country-us.csv)
"ocd_divisions"
