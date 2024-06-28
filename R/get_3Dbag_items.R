#'R/get_3Dbag_items.R'

library(httr)
library(jsonlite)
library(sf)
library(dplyr)
library(rgl)

#' Get 3DBag Data
#'
#' @param bbox A bounding box string defining the area of interest.
#' @return A data frame of combined coordinates of all buildings for 3D plotting.
#' @name get_3Dbag_items
#' @title Get 3DBag Items Data
#' @importFrom httr GET content http_type status_code modify_url
#' @importFrom jsonlite write_json
#' @export
get_3Dbag_items <- function(bbox) {
  api_3dbag <- "https://api.3dbag.nl/collections/pand/items"
  offset <- 1
  limit <- 100
  all_coords <- list()
  file_index <- 1

 # Create inst/extdata folders if they don't exist
  data_dir <- "inst/extdata"
  if (!dir.exists(data_dir)) {
    dir.create(data_dir, recursive = TRUE)
  }

  repeat {
    url <- httr::modify_url(api_3dbag, query = list(limit = limit, offset = offset, bbox = bbox))
    response <- httr::GET(url)

    if (httr::http_type(response) != "application/json") {
      message("No valid/more JSON data returned.")
      break
    }

    data <- httr::content(response, as = "parsed")
    if (length(data$features) == 0) {
      break
    }

    # Write the data to a file
    file_name <- paste0("inst/extdata/3dbag_data_", file_index, ".json")
    write_json(data, file_name, auto_unbox = TRUE)
    file_index <- file_index + 1

    coords <- extract_3dbag_coords(data, plot = FALSE)
    all_coords <- c(all_coords, list(coords))

    offset <- offset + limit
  }

  if (length(all_coords) == 0) {
    message("No data retrieved for the specified bounding box.")
    return(NULL)
  } else {
    # Combine all coordinates
    all_coords_combined <- do.call(rbind, all_coords)
    return(all_coords_combined)
  }
}
