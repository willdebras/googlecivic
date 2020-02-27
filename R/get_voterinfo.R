#' Title
#'
#' @param address
#' @param electionid
#'
#' @return
#' @export
#' @importFrom httr GET http_type content
#' @importFrom jsonlite fromJSON
#'
#' @examples
get_voterinfo <- function(address = NULL, electionid = NULL, key = Sys.getenv("google_civic_api")) {

  base_url <- "https://www.googleapis.com/civicinfo/v2/"

  end_point <- "voterinfo/"

  url_full <- paste0(base_url, end_point)

  raw_voterinfo <- httr::GET(url_full, query = list(

    address = address,
    electionId = electionid,
    key = key

  ))

  if (httr::http_type(raw_voterinfo) != "application/json") {
    stop("API didn't return JSON", call. = FALSE)
  }


  parsed_voterinfo <- jsonlite::fromJSON(
    httr::content(raw_voterinfo, "text"),
    simplifyDataFrame = TRUE
  )

  return(parsed_voterinfo)

}
