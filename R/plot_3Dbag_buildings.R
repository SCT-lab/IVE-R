# 'R/plot_3Dbag_buildings.R'

#' Plot 3DBag Buildings
#'
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
  bbox_string <- tryCatch({
    define_aoi(lon, lat, buffer_distance)
  }, error = function(e) {
    stop("Failed to define area of interest: ", e$message)
  })

  # Download 3DBag data
  data <- tryCatch({
    get_3Dbag_items(bbox_string)
  }, error = function(e) {
    stop("Failed to retrieve 3DBag data: ", e$message)
  })

  if (is.null(data) || !("features" %in% names(data))) {
    stop("No valid 3DBag data retrieved.")
  }

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
    result <- tryCatch({
      vertices <- do.call(rbind, feature$vertices)
      scale <- unlist(data$metadata$transform$scale)
      translate <- unlist(data$metadata$transform$translate)

      vertices <- apply(vertices, 2, as.numeric)
      vertices <- sweep(vertices, 2, translate, "+")
      vertices <- sweep(vertices, 2, scale, "*")
      list(vertices_df = as.data.frame(vertices), error = NULL)
    }, error = function(e) {
      warning("Failed to process a feature: ", e$message)
      list(vertices_df = NULL, error = e$message)
    })

    if (!is.null(result$error)) {
      next
    }

    vertices_df <- result$vertices_df
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
  if (length(valid_coords) == 0) {
    stop("No valid coordinates for 3D plotting.")
  }

  final_coords <- tryCatch({
    do.call(rbind, valid_coords)
  }, error = function(e) {
    stop("Failed to combine coordinates: ", e$message)
  })

  if (nrow(final_coords) == 0) {
    stop("No valid coordinates for 3D plotting.")
  }

  final_coords <- as.data.frame(final_coords)
  colnames(final_coords) <- c("x", "y", "z")

  # Calculate the center of the model
  center <- tryCatch({
    colMeans(final_coords, na.rm = TRUE)
  }, error = function(e) {
    stop("Failed to calculate the center of the model: ", e$message)
  })

  # Adjust the coordinates to center the pivot point
  final_coords <- tryCatch({
    sweep(final_coords, 2, center, "-")
  }, error = function(e) {
    stop("Failed to adjust coordinates to center the pivot point: ", e$message)
  })

  # Ensure columns are numeric
  final_coords <- tryCatch({
    mutate_all(final_coords, as.numeric)
  }, error = function(e) {
    stop("Failed to ensure final coordinates are numeric: ", e$message)
  })

  tryCatch({
    open3d()
    triangles3d(final_coords$x, final_coords$y, final_coords$z, col = "blue")
  }, error = function(e) {
    stop("Failed to plot 3D model: ", e$message)
  })

  return(final_coords)
}
