# 'R/define_aoi.R'

#' Define Area of Interest
#'
#' @param lon Longitude of the central point.
#' @param lat Latitude of the central point.
#' @param buffer_distance Distance for the buffer around the central point in meters.
#' @return A bounding box string for the area of interest.
#' @importFrom sf st_sfc st_point st_transform st_buffer st_bbox st_crs
#' @importFrom units as_units
#' @export
define_aoi <- function(lon, lat, buffer_distance) {
  # Validate longitude and latitude
  if (!is.numeric(lon) || lon < -180 || lon > 180) {
    stop("Longitude must be a numeric value between -180 and 180.")
  }
  if (!is.numeric(lat) || lat < -90 || lat > 90) {
    stop("Latitude must be a numeric value between -90 and 90.")
  }

  # Validate buffer distance
  if (!is.numeric(buffer_distance) || buffer_distance <= 0) {
    stop("Buffer distance must be a positive numeric value.")
  }

  # Define central point
  central_point <- st_sfc(st_point(c(lon, lat)), crs = 4326) |>
    st_transform(st_crs("EPSG:7415"))

  # Define buffer distance as units
  aoi_distance <- as_units(buffer_distance, "m")
  aoi_buffer <- st_buffer(central_point, aoi_distance)
  aoi_bbox <- st_bbox(aoi_buffer)

  # Convert bounding box to string
  bbox_string <- paste(aoi_bbox[1], aoi_bbox[2], aoi_bbox[3], aoi_bbox[4], sep = ",")
  return(bbox_string)
}
