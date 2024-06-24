# 'R/plot_3Dbag_buildings.R'

#' @param lon Longitude of the central point.
#' @param lat Latitude of the central point.
#' @param buffer_distance Distance for the buffer around the central point in meters.
#' @return A matrix of final coordinates used for 3D plotting.
#' @name plot_3Dbag_buildings
#' @title Plot 3DBag Buildings
#' @import dplyr
#' @importFrom rgl open3d triangles3d rglwidget
#' @export
plot_3Dbag_buildings <- function(lon, lat, buffer_distance) {

  # Define area of interest
  bbox_string <- define_aoi(lon, lat, buffer_distance)

  # Download 3DBag data
  data <- get_3Dbag_items(bbox_string)


  get_polygon_coords <- function(boundary, vertices_df) {
    if (is.matrix(boundary)) {
      coords <- vertices_df[boundary + 1, ]
    } else {
      coords <- vertices_df[unlist(boundary) + 1, ]
    }
    as.matrix(coords)
  }

  triangulate_polygon <- function(coords) {
    if (nrow(coords) < 3) {
      return(NULL)
    }

    triangles <- list()
    for (i in 2:(nrow(coords) - 1)) {
      triangle <- coords[c(1, i, i + 1), ]
      triangles[[length(triangles) + 1]] <- triangle
    }
    do.call(rbind, triangles)
  }

  all_coords <- list()
  for (feature in data$features) {
    vertices <- do.call(rbind, feature$vertices)
    scale <- unlist(data$metadata$transform$scale)
    translate <- unlist(data$metadata$transform$translate)

    vertices <- apply(vertices, 2, as.numeric)
    vertices <- sweep(vertices, 2, translate, "+")
    vertices <- sweep(vertices, 2, scale, "*")

    vertices_df <- as.data.frame(vertices)
    colnames(vertices_df) <- c("x", "y", "z")

    for (city_object_id in names(feature$CityObjects)) {
      city_object <- feature$CityObjects[[city_object_id]]

      for (geometry in city_object$geometry) {
        boundaries <- geometry$boundaries

        if (is.null(boundaries) || length(boundaries) == 0 || length(boundaries[[1]]) == 0) {
          next
        }

        polygon_coords <- lapply(boundaries, get_polygon_coords, vertices_df)
        triangulated_coords <- lapply(polygon_coords, triangulate_polygon)
        all_coords <- c(all_coords, triangulated_coords)
      }
    }
  }

  valid_coords <- all_coords[!sapply(all_coords, is.null)]
  final_coords <- do.call(rbind, valid_coords)

  final_coords <- as.data.frame(final_coords)
  colnames(final_coords) <- c("x", "y", "z")

  # Calculate the center of the model
  center <- colMeans(final_coords)

  # Adjust the coordinates to center the pivot point
  final_coords <- sweep(final_coords, 2, center, "-")

  # Ensure columns are numeric
  final_coords <- mutate_all(final_coords, as.numeric)

  open3d()
  triangles3d(final_coords$x, final_coords$y, final_coords$z, col = "blue")
  rgl::rglwidget()

  return(final_coords)
}

