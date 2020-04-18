#' get_rep_by_division
#'
#' This function interacts with the representatives endpoint of the Google Civic Information API
#'
#' @param ocdId An Open Civic Data Division Identifier, e.g. from the `id`
#'     column of [ocd_divisions]
#' @param levels List of office levels supplied as string. Only offices that
#'     serve at least one of these levels will be returned Acceptable values
#'     are: "administrativeArea1", "administrativeArea2", "country",
#'     "international", "locality", "regional", "special", "subLocality1",
#'     "subLocality2"
#' @param recursive If `TRUE`, information about all divisions contained in the
#'     division requested will be included as well. For example, if querying
#'     ocd-division/country:us/district:dc, this would also return all DC's
#'     wards and ANCs.
#' @param roles List of roles supplied as string. Only offices fulfilling one of
#'     these roles will be returned. Acceptable values are:
#'     "deputyHeadOfGovernment", "executiveCouncil", "governmentOfficer",
#'     "headOfGovernment", "headOfState", "highestCourtJudge", "judge",
#'     "legislatorLowerBody", "legislatorUpperBody", "schoolBoard",
#'     "specialPurposeOfficer"
#' @param key API key supplied as a string. Defaults to the environmental
#'     variable called "google_civic_api." Info on how to get a key can be found
#'     here: https://developers.google.com/civic-information
#'
#' @return Returns a list of offices by divisions and respective officials
#' @export
#'
#' @examples
#' \dontrun{
#' get_rep_by_division(
#'     ocdId = "ocd-division/country:us/district:dc",
#'     level="locality",
#'     recursive = TRUE
#' )
#' }
#'

get_rep_by_division <- function(ocdId = NULL, levels = NULL, recursive = NULL, roles = NULL, key = Sys.getenv("google_civic_api")) {

  base_url <- "https://www.googleapis.com/civicinfo/v2/"
  end_point <- paste0("representatives/", utils::URLencode(ocdId, reserved = TRUE))
  url_full <- paste0(base_url, end_point)

  rep_response <- httr::GET(url_full, query = list(
    levels = levels,
    recursive = recursive,
    roles = roles,
    key = key
  ))

  httr::stop_for_status(rep_response)

  parsed_rep_address <- jsonlite::fromJSON(
    httr::content(rep_response, "text"),
    simplifyDataFrame = TRUE
  )

  return(parsed_rep_address)
}
