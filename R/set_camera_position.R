#' Set Camera Position in a VR Environment
#'
#' This function sets or updates the position of the camera in a given VR environment.
#'
#' @param vr_env A list containing the HTML content of the VR environment. The list should have an element named `html_content`.
#' @param camera_position A numeric vector of length 3 specifying the camera's position in the format \code{c(x, y, z)}. Defaults to \code{c(0, 2, 5)}.
#' 
#' @return A modified list containing the updated HTML content of the VR environment.
#' @export
#' 
#' 
set_camera_position <- function(vr_env, camera_position = c(0, 2, 5)) {
  
  # Read the input HTML file
  html_content <- vr_env$html_content
  
  # Define the camera entity tag
  camera_entity <- glue::glue(
    '<a-camera position="{camera_position[1]} {camera_position[2]} {camera_position[3]}"></a-camera>',
    .open = "{", .close = "}"
  )
  
  # Insert or replace the camera entity
  camera_pattern <- '<a-camera[^>]*></a-camera>'
  if (any(grepl(camera_pattern, html_content))) {
    html_content <- gsub(camera_pattern, camera_entity, html_content)
  } else {
    scene_insert_position <- which(grepl('</a-scene>', html_content))
    if (length(scene_insert_position) > 0) {
      html_content <- append(html_content, camera_entity, after = scene_insert_position - 1)
    }
  }
  
  vr_env <- list(html_content = html_content)
  cat("Camera position has been updated in the VR environment.\n")
  return(vr_env)
}
