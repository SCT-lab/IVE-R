library(httr)
library(jsonlite)
library(sf)

#' Get 3DBag Data
#'
#' @param bbox A bounding box string defining the area of interest.
#' @return A list containing the parsed JSON data from 3DBag.
#' @name get_3Dbag_items
#' @title Get 3DBag Items Data
#' @importFrom httr GET content http_type status_code modify_url
#' @export
get_3Dbag_items <- function(bbox) {

  api_3dbag <- "https://api.3dbag.nl/collections/pand/items"
  url <- httr::modify_url(api_3dbag, query = list(limit = 100, offset = 1, bbox = bbox))
  response <- httr::GET(url)

  if (httr::http_type(response) == "application/json") {
    data <- httr::content(response, as = "parsed")
  } else {
    stop("Failed to retrieve valid JSON data.")
  }
  return(data)
}
