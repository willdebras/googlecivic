#' get_rep_address
#'
#' This function interacts with the representatives endpoint of the Google Civic Information API
#'
#' @param address Address supplied as string
#'
#' @param includeOffices Whether to return information about offices and officials. False returns only top-level district information. Default is true.
#' @param levels List of office levels supplied as string. Only offices that serve at least one of these levels will be returned Acceptable values are: "administrativeArea1", "administrativeArea2", "country", "international", "locality", "regional", "special", "subLocality1", "subLocality2"
#' @param roles List of roles supplied as string. Only offices fulfilling one of these roles will be returned. Acceptable values are: "deputyHeadOfGovernment", "executiveCouncil", "governmentOfficer", "headOfGovernment", "headOfState", "highestCourtJudge", "judge", "legislatorLowerBody", "legislatorUpperBody", "schoolBoard", "specialPurposeOfficer"
#' @param key API key supplied as a string. Defaults to the environmental variable called "google_civic_api." Info on how to get a key can be found here: https://developers.google.com/civic-information
#'
#' @return Returns a list of offices by divisions and respective officials
#' @export
#' @importFrom httr GET http_type content
#' @importFrom jsonlite fromJSON
#'
#' @examples
#' \dontrun{
#' get_rep_address(address = "55 e monroe, chicago, il",level="regional", role="schoolBoard", key = Sys.getenv("google_civic_api"))
#' }
#'

get_rep_address <- function(address = NULL, includeOffices = NULL, levels = NULL, roles = NULL, key = Sys.getenv("google_civic_api")) {

  base_url <- "https://www.googleapis.com/civicinfo/v2/"

  end_point <- "representatives/"

  url_full <- paste0(base_url, end_point)

  raw_rep_address <- httr::GET(url_full, query = list(

    address = address,
    includeOffices = includeOffices,
    levels = levels,
    roles = roles,
    key = key

  ))

  if (httr::http_type(raw_rep_address) != "application/json") {
    stop("API didn't return JSON", call. = FALSE)
  }


  parsed_rep_address <- jsonlite::fromJSON(
    httr::content(raw_rep_address, "text"),
    simplifyDataFrame = TRUE
  )

  return(parsed_rep_address)
}
