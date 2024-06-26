# 'R/rotate_VR.R'

#' Add Rotation to VR Model
#'
#' This function updates an existing VR HTML file to add or remove a rotation component for the 3D model based on the provided parameters.
#'
#' @param input_html Path to the input HTML file.
#' @param rotate Logical value to enable/disable rotation. If TRUE, rotation is enabled.
#' @param speed (Optional) Numeric value for rotation speed. Defaults to 0.0001.
#' @param clockwise (Optional) Numeric value to set rotation direction. 1 for clockwise, 0 for counterclockwise. Defaults to 1.
#' @return Updates the input HTML file with the specified rotation settings for the 3D model.
#' @examples
#' \dontrun{
#' rotate_VR("input.html", TRUE)
#' rotate_VR("input.html", TRUE, speed = 0.0002, clockwise = 0)
#' rotate_VR("input.html", FALSE)
#' }
#' @export
rotate_VR <- function(input_html, rotate, speed = 0.0001, clockwise = 1) {
  # Read the input HTML file
  html_content <- readLines(input_html)

  # Check if the input HTML file exists
  if (!file.exists(input_html)) {
    stop("The specified input HTML file does not exist.")
  }

  # Check if rotate is a logical value
  if (!is.logical(rotate)) {
    stop("The 'rotate' parameter must be a logical value (TRUE or FALSE).")
  }

  # Check if speed is a numeric value
  if (!is.numeric(speed) || length(speed) != 1) {
    stop("The 'speed' parameter must be a single numeric value.")
  }

  # Check if clockwise is a numeric value (1 or 0)
  if (!is.numeric(clockwise) || length(clockwise) != 1 || !clockwise %in% c(0, 1)) {
    stop("The 'clockwise' parameter must be a single numeric value (1 for clockwise, 0 for counterclockwise).")
  }

  # Check if the model is GLB or GLTF
  if (!any(grepl('<a-entity gltf-model=', html_content))) {
    warning("Automatic rotation is only supported for GLB/GLTF models. The model will not rotate.")
    return(invisible(NULL))
  }


  # Define the rotation script
  rotation_script <- '
  <script>
    AFRAME.registerComponent("rotate-on-rt-toggle", {
      init: function () {
        const model = this.el;
        let rotationSpeed = ROTATION_SPEED;
        let isRotating = ROTATE;
        let rotationDirection = CLOCKWISE;  // 1 for clockwise, -1 for counterclockwise

        this.tick = function (time, deltaTime) {
          if (isRotating) {
            model.object3D.rotation.y += rotationSpeed * rotationDirection * deltaTime;
          }
        };
      }
    });
  </script>
  '

  # Replace placeholders with actual values
  rotation_script <- gsub("ROTATION_SPEED", speed, rotation_script)
  rotation_script <- gsub("ROTATE", ifelse(rotate, "true", "false"), rotation_script)
  rotation_script <- gsub("CLOCKWISE", ifelse(clockwise == 1, "1", "-1"), rotation_script)

  # Add or remove the rotation component
  if (rotate) {
    # Insert the rotation component script before the closing </body> tag
    pattern <- '</body>'
    updated_html_content <- gsub(pattern, paste0(rotation_script, "\n</body>"), html_content)

    # Add the rotation component to the model entity
    updated_html_content <- gsub('<a-entity gltf-model="#model"', '<a-entity gltf-model="#model" rotate-on-rt-toggle', updated_html_content)
  } else {
    # Remove the rotation component script and attribute if present
    updated_html_content <- gsub('<script>\\s*AFRAME.registerComponent\\("rotate-on-rt-toggle".*?</script>', '', html_content, perl = TRUE)
    updated_html_content <- gsub(' rotate-on-rt-toggle', '', updated_html_content)
  }

  # Ensure the A-Frame script is included if not already present
  if (!any(grepl('<script src="https://aframe.io/releases/1.2.0/aframe.min.js"></script>', html_content))) {
    head_insert <- '
    <script src="https://aframe.io/releases/1.2.0/aframe.min.js"></script>
    '
    updated_html_content <- gsub('</head>', paste0(head_insert, "\n</head>"), updated_html_content)
  }

  # Write the updated content back to the input HTML file
  writeLines(updated_html_content, input_html)
  cat("HTML file updated successfully. Open '", input_html, "' in your browser to view the VR scene with rotation settings.\n")
}
