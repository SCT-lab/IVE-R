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
  # Validate bbox input
  if (!is.character(bbox) || nchar(bbox) == 0) {
    stop("Bounding box must be a non-empty string.")
  }

  bbox_parts <- unlist(strsplit(bbox, ","))

  # Check if bbox values are within valid ranges for longitude and latitude
  lon_min <- as.numeric(bbox_parts[1])
  lat_min <- as.numeric(bbox_parts[2])
  lon_max <- as.numeric(bbox_parts[3])
  lat_max <- as.numeric(bbox_parts[4])


  api_3dbag <- "https://api.3dbag.nl/collections/pand/items"
  url <- httr::modify_url(api_3dbag, query = list(limit = 100, offset = 1, bbox = bbox))
  response <- tryCatch({
    httr::GET(url)
  }, error = function(e) {
    stop("HTTP request failed: ", e$message)
  })

  # Check HTTP status
  if (httr::status_code(response) != 200) {
    stop("Failed to retrieve data: HTTP status code ", httr::status_code(response))
  }

  data <- tryCatch({
    if (httr::http_type(response) == "application/json") {
      httr::content(response, as = "parsed")
    } else {
      stop("Failed to retrieve valid JSON data.")
    }
  }, error = function(e) {
    stop("Error in processing response content: ", e$message)
  })

  return(data)
}
