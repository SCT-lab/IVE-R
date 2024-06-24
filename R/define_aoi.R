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
  central_point <- st_sfc(st_point(c(lon, lat)), crs = 4326) |>
    st_transform(st_crs("EPSG:7415"))

  aoi_distance <- as_units(buffer_distance, "m")
  aoi_buffer <- st_buffer(central_point, aoi_distance)
  aoi_bbox <- st_bbox(aoi_buffer)

  bbox_string <- paste(aoi_bbox[1], aoi_bbox[2], aoi_bbox[3], aoi_bbox[4], sep = ",")
  return(bbox_string)
}

