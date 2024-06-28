# 'R/plot_3Dbag_buildings.R'
#'
#' @param final_coords A data frame of final coordinates used for 3D plotting.
#' @name plot_3Dbag_buildings
#' @title Plot 3DBag Buildings
#' @import dplyr
#' @importFrom rgl open3d triangles3d rglwidget
#' @export
plot_3Dbag_buildings <- function(final_coords) {
  tryCatch({
    open3d()
    triangles3d(final_coords$x, final_coords$y, final_coords$z, col = "blue")
  }, error = function(e) {
    stop("Failed to plot 3D model: ", e$message)
  })
}
