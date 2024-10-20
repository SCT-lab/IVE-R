#' Set Up a Virtual Reality (VR) Environment in A-Frame
#'
#' Creates an HTML structure that defines a virtual reality environment using A-Frame, with customizable
#' environment presets, sky settings, and the option to add indoor structures. The output can be used to 
#' generate a complete VR scene that can be viewed in both desktop and VR headsets.
#'
#' @param environment_preset A character string specifying the environment preset to use. 
#'   Valid options are: "none", "default", "contact", "egypt", "checkerboard", "forest", 
#'   "goaland", "yavapai", "goldmine", "threetowers", "poison", "arches", "tron", 
#'   "japan", "dream", "volcano", "starry", "osiris", and "moon". Default is "forest".
#' @param skyType A character string specifying the type of sky to use. 
#'   Valid options are: "color", "gradient", or "atmosphere". Default is "atmosphere".
#' @param skyColor A character string specifying the color of the sky when `skyType` is "color" or "gradient". 
#'   If `skyType` is set to "atmosphere", this parameter is ignored. Default is "blue".
#' @param indoor A logical value. If `TRUE`, adds a default indoor structure to the VR scene. 
#'   Default is `FALSE`.
#'
#' @return A list containing the HTML structure as a character vector, which defines the VR environment 
#'   in A-Frame.
#'
#' @details 
#' This function generates an HTML file that initializes a VR environment using A-Frame, a framework for 
#' building virtual reality experiences in the browser. The user can specify various environment presets and 
#' sky configurations. Additionally, an indoor structure can be added if desired. The resulting HTML content 
#' can be saved and viewed on a desktop or a VR headset.
#' 
#' The `environment_preset` parameter controls the visual theme of the environment, such as a forest or 
#' moon landscape. The `skyType` and `skyColor` allow customization of the sky appearance, but `skyColor` 
#' is ignored if `skyType` is set to "atmosphere". The `indoor` parameter toggles the inclusion of an 
#' indoor structure in the environment.
#'
#' @note The `skyColor` is only used when `skyType` is set to "color" or "gradient". If `skyType` is set 
#'   to "atmosphere", `skyColor` will be ignored, and a warning will be issued.
#'
#' @examples
#' # Basic environment setup with default values
#' vr_env <- set_VR_environment()
#'
#' # Custom environment setup with a specific environment preset and sky color
#' vr_env <- set_VR_environment(environment_preset = "japan", skyType = "color", skyColor = "pink")
#'
#'
#' @export
set_VR_environment <- function(environment_preset = "forest", skyType = "atmosphere", skyColor = "blue", indoor = FALSE) {
  
  # Valid presets
  valid_presets <- c("none", "default", "contact", "egypt", "checkerboard", "forest", "goaland", "yavapai",
                     "goldmine", "threetowers", "poison", "arches", "tron", "japan", "dream", "volcano",
                     "starry", "osiris", "moon")
  
  # Check if environment_preset is valid
  if (!environment_preset %in% valid_presets) {
    stop("Invalid environment_preset. Valid values are: ", paste(valid_presets, collapse = ", "))
  }
  
  # Valid sky types
  valid_sky_types <- c("color", "gradient", "atmosphere")
  if (!skyType %in% valid_sky_types) {
    stop("Invalid skyType. Valid values are 'color', 'gradient', or 'atmosphere'.")
  }
  
  if (skyType == "atmosphere" && skyColor != "") {
    warning("skyColor is ignored when skyType is set to 'atmosphere'.")
  }
  
  # Check if skyColor is a valid string
  if (!validColor(skyColor)) {
    stop("skyColor must be a valid color.")
  }
  
  # Create the A-Frame HTML content as a character vector with each line as a separate element
  html_content <- c(
    "<!DOCTYPE html>",
    "<html>",
    "<head>",
    "    <meta charset=\"utf-8\">",
    "    <title>VR Environment</title>",
    "    <script src=\"https://aframe.io/releases/1.3.0/aframe.min.js\"></script>",
    "    <script src=\"https://unpkg.com/aframe-environment-component@1.3.3/dist/aframe-environment-component.min.js\"></script>",
    "</head>",
    "<body>",
    "    <a-scene>",
    "        <a-entity environment=\"preset: ", environment_preset, "; skyType: ", skyType, "; skyColor: ", skyColor, "\"></a-entity>",
    "        <a-sky color=\"#ECECEC\"></a-sky>",
    "        <a-light type=\"ambient\" color=\"#ffffff\" intensity=\"0.5\"></a-light>",
    "        <a-light type=\"directional\" color=\"#ffffff\" intensity=\"0.8\" position=\"-1 2 1\"></a-light>"
  )
  
  # Add indoor structure if 'indoor' is TRUE
  if (indoor) {
    indoor_content <- .indoor_environment_default()
    
    html_content <- c(html_content, indoor_content)
  }
  
  # Close the a-scene and html tags
  html_content <- c(html_content, "    </a-scene>", "</body>", "</html>")
  
  # Save the content in a list
  vr_env <- list(html_content = html_content)
  
  return(vr_env)
}
