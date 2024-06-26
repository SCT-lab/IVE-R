# 'R/save_model.R'

library(rgl)
#' Save 3D Model as OBJ and GLB Files
#'
#' @param filepath The path where the GLB file will be saved.
#' @param filename The name of the GLB file to save (without extension).
#' @param coords A data frame with columns x, y, and z.
#' @param color The color to be used for the 3D model. Default is "blue".
#' @name save_model
#' @title Save 3D Model as OBJ and GLB Files
#' @importFrom rgl open3d triangles3d writeOBJ
#' @importFrom grDevices col2rgb colors
#' @export
save_model <- function(filepath, filename, coords, color = "blue") {

  tryCatch({
    # Check if filepath is valid and writable
    if (!dir.exists(filepath)) {
      stop("The specified filepath does not exist.")
    }
    if (!file.access(filepath, 2) == 0) {
      stop("The specified filepath is not writable.")
    }

    # Check if filename is valid
    if (!is.character(filename) || nchar(filename) == 0) {
      stop("Filename must be a non-empty string.")
    }

    # Ensure coords is a data frame with the required columns
    if (!is.data.frame(coords) || !all(c("x", "y", "z") %in% colnames(coords))) {
      stop("Coords must be a data frame with columns 'x', 'y', and 'z'.")
    }

    # Ensure columns are numeric vectors
    coords$x <- as.numeric(coords$x)
    coords$y <- as.numeric(coords$y)
    coords$z <- as.numeric(coords$z)

    # Validate color input
    valid_colors <- colors()
    if (!color %in% valid_colors) {
      stop(paste("Invalid color:", color, "Choose from the following colors:", paste(valid_colors, collapse = ", ")))
    }

    # Calculate the center of the model
    center <- colMeans(coords, na.rm = TRUE)

    # Adjust the coordinates to center the pivot point
    coords <- sweep(coords, 2, center, "-")

    # Plot the 3D model with all buildings combined
    open3d()
    triangles3d(coords$x, coords$y, coords$z, col = color)

    # Save the 3D model as OBJ file using rgl
    obj_file <- file.path(filepath, paste0(filename, ".obj"))
    rgl::writeOBJ(obj_file)

    # Convert color to RGB
    rgb_color <- col2rgb(color)
    rgb_values <- rgb_color / 255

    # Create an MTL file to define the material properties
    mtl_file <- file.path(filepath, paste0(filename, ".mtl"))
    mtl_content <- sprintf("
newmtl Material
Ka 0.0 0.0 0.0
Kd %f %f %f
Ks 0.0 0.0 0.0
d 1.0
illum 1
", rgb_values[1], rgb_values[2], rgb_values[3])
    write(mtl_content, file = mtl_file)

    # Update the OBJ file to reference the MTL file
    obj_content <- readLines(obj_file)
    obj_content <- c(paste0("mtllib ", basename(mtl_file)), obj_content)
    writeLines(obj_content, con = obj_file)

    # Convert OBJ to GLB using obj2gltf
    glb_file <- file.path(filepath, paste0(filename, ".glb"))
    conversion_result <- system(paste("obj2gltf -i", obj_file, "-o", glb_file), wait = TRUE)

    # Check if the conversion was successful
    if (conversion_result != 0) {
      stop("Conversion to GLB failed. Please check the obj2gltf tool and try again.")
    }

  }, error = function(e) {
    stop("An error occurred: ", e$message)
  })
}
