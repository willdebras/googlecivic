#' get_voterinfo
#'
#' This function interacts with the voterinfo endpoint of the Google Civic Information API
#'
#' @param address Address supplied as string
#' @param electionid An optional unique ID of an election, found here: https://www.googleapis.com/civicinfo/v2/elections.
#' @param key API key supplied as a string. Defaults to the environmental variable called "google_civic_api." Info on how to get a key can be found here: https://developers.google.com/civic-information
#'
#' @return Returns a list of elections, polling locations, state address info, and a normalized input of the address
#' @export
#' @importFrom httr GET http_type content
#' @importFrom jsonlite fromJSON
#'
#' @examples
#' \dontrun{
#' get_voterinfo(address = "55 e monroe, chicago, il", key = Sys.getenv("google_civic_api"))
#' }
  get_voterinfo <- function(address = NULL, electionid = NULL, key = Sys.getenv("google_civic_api")) {

    base_url <- "https://www.googleapis.com/civicinfo/v2/"

    end_point <- "voterinfo/"

    url_full <- paste0(base_url, end_point)

#    raw_voterinfo <- httr::RETRY(verb = "GET",
#                                 url = url_full,
#                                 query = list(
#
#      address = address,
#      electionId = electionid,
#      key = key
#
#    ))
    
          raw_voterinfo <- httr::GET(
                                   url = url_full,
                                   query = list(
                                     address = address,
                                     electionId = 2000,
                                     key = key
                                   ))

    if (httr::http_type(raw_voterinfo) != "application/json") {
      stop("API didn't return JSON", call. = FALSE)
    }


    parsed_voterinfo <- jsonlite::fromJSON(
      httr::content(raw_voterinfo, "text"),
      simplifyDataFrame = TRUE
    )

    if (!is.null(parsed_voterinfo$error)) {

#      raw_voterinfo <- httr::RETRY(verb = "GET",
#                                   url = url_full,
#                                   query = list(
#                                     address = address,
#                                     electionId = 2000,
#                                     key = key
#                                   ))
      
      raw_voterinfo <- httr::GET(
                                   url = url_full,
                                   query = list(
                                     address = address,
                                     electionId = 2000,
                                     key = key
                                   ))

      parsed_voterinfo <- jsonlite::fromJSON(
        httr::content(raw_voterinfo, "text"),
        simplifyDataFrame = TRUE
      )

      if (!is.null(parsed_voterinfo$error)) {

        stop(paste0("Error code ",
                    parsed_voterinfo$error$code,
                    ": ",
                    parsed_voterinfo$error$message), call. = FALSE)

      }

      warning("Election ID empty, incorrect, or no upcoming elections found.")

      parsed_voterinfo <- parsed_voterinfo[c("pollingLocations", "state")]

    }

    if (!is.null(parsed_voterinfo$error)) {

      stop(paste0("Error code ",
                  parsed_voterinfo$error$code,
                  ": ",
                  parsed_voterinfo$error$message), call. = FALSE)

    }

    return(parsed_voterinfo)

  }
