#' get_electionid
#'
#' This function interacts with the election endpoint of the Google Civic Information API
#' @param key API key supplied as a string. Defaults to the environmental variable called "google_civic_api." Info on how to get a key can be found here: https://developers.google.com/civic-information
#'
#' @return Returns a list of election informations: id, name, date and ocdDivisionID
#' @export
#' @importFrom httr GET http_type content
#' @importFrom jsonlite fromJSON
#'
#' @examples
#' \dontrun{
#' get_electionid(key = Sys.getenv("google_civic_api"))
#' }
get_electionid <- function(key = Sys.getenv("google_civic_api")) {

  base_url <- "https://www.googleapis.com/civicinfo/v2/"

  end_point <- "elections/"

  url_full <- paste0(base_url, end_point)

  raw_elections <- httr::GET(url_full, query = list(

    key = key

  ))

  if (httr::http_type(raw_elections) != "application/json") {
    stop("API didn't return JSON", call. = FALSE)
  }


  parsed_elections <- jsonlite::fromJSON(
    httr::content(raw_elections, "text"),
    simplifyDataFrame = TRUE
  )

  return(parsed_elections)

}
