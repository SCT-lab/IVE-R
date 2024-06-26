# 'R/create_VR.R'

#' Create VR HTML File for Rayshader Model
#'
#' This function takes a path to a GLB, GLTF, or OBJ model file and generates an HTML file with an A-Frame scene.
#' Optional position, scale, and rotation parameters can be provided to customize the model's appearance.
#' @param model_path Path to the GLB, GLTF, or OBJ file.
#' @param output_html Path to save the generated HTML file.
#' @param position (Optional) Position as a vector of three elements (x, y, z). Defaults to c(0, 0, 0).
#' @param scale (Optional) Model scale as a vector of three elements (x, y, z). Defaults to c(1, 1, 1).
#' @param rotation (Optional) Rotation as a vector of three elements (x, y, z). Defaults to c(0, 0, 0).
#' @return Creates an HTML file for A-Frame visualization of a 3D model.
#' @examples
#' \dontrun{
#' create_VR("path/model.glb", "output.html")
#' create_VR("path/model.obj", "output.html",
#'           position = c(0, 1, 0), scale = c(1, 1, 1), rotation = c(0, 180, 0))
#' }
#' @export
create_VR <- function(model_path, output_html,
                      position = c(0, 0, 0), scale = c(1, 1, 1), rotation = c(0, 0, 0)) {
  # Ensure position has three elements
  if (!is.null(position) && length(position) != 3) {
    stop("Position parameter must include three elements: x, y, and z coordinates.")
  }

  # Ensure scale has three elements
  if (!is.null(scale) && length(scale) != 3) {
    stop("Scale parameter must include three elements: x, y, and z scaling factors.")
  }

  # Ensure rotation has three elements
  if (!is.null(rotation) && length(rotation) != 3) {
    stop("Rotation parameter must include three elements: x, y, and z rotation values.")
  }

  # Set default values if parameters are NULL
  position <- if (is.null(position)) c(0, 0, 0) else position
  scale <- if (is.null(scale)) c(1, 1, 1) else scale
  rotation <- if (is.null(rotation)) c(0, 0, 0) else rotation

  # Prepare HTML content using glue and dynamic variables
  html_template <- '
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Rayshader 3D Model in VR</title>
    <script src="https://aframe.io/releases/1.2.0/aframe.min.js"></script>
    <script src="https://cdn.rawgit.com/supermedium/superframe/master/components/aframe-orbit-controls-component.min.js"></script>
</head>
<body>
    <a-scene>
        <a-sky color="#ECECEC"></a-sky>
        <a-entity position="0 1.6 0">
            <a-camera orbit-controls="autoRotate: false; target: 0 0 0"></a-camera>
        </a-entity>
        <a-assets>
            <a-asset-item id="model" src="{model_path}"></a-asset-item>
        </a-assets>
        <a-entity {model_tag} position="{pos_x} {pos_y} {pos_z}" scale="{scale_x} {scale_y} {scale_z}" rotation="{rot_x} {rot_y} {rot_z}"></a-entity>
    </a-scene>
</body>
</html>'

  pos_x <- position[1]
  pos_y <- position[2]
  pos_z <- position[3]

  scale_x <- scale[1]
  scale_y <- scale[2]
  scale_z <- scale[3]

  rot_x <- rotation[1]
  rot_y <- rotation[2]
  rot_z <- rotation[3]

  # Determine the model tag based on file extension
  model_extension <- tools::file_ext(model_path)
  model_tag <- ifelse(model_extension == "obj", 'obj-model="obj: #model"', 'gltf-model="#model"')

  html_content <- glue::glue(html_template,
                             .open = "{", .close = "}",
                             model_path = model_path,
                             model_tag = model_tag,
                             pos_x = pos_x,
                             pos_y = pos_y,
                             pos_z = pos_z,
                             scale_x = scale_x,
                             scale_y = scale_y,
                             scale_z = scale_z,
                             rot_x = rot_x,
                             rot_y = rot_y,
                             rot_z = rot_z)

  # Checking if the file exists
  if (!file.exists(model_path)) {
    stop("The file does not exist at the specified path: ", model_path)
  }

  writeLines(html_content, output_html)
  cat("HTML file created successfully. Open '", output_html, "' in your browser to view the VR scene.\n")
}
