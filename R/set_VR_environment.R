# 'R/set_VR_environment.R'

#' Set VR Environment
#'
#' This function updates an existing VR HTML file to add an A-Frame environment component with specified parameters.
#'
#' @param input_html Path to the input HTML file.
#' @param environment_preset The environment preset to use for the A-Frame environment component.
#' @param skyType (Optional) The type of sky. Valid values: "color", "gradient", "atmosphere". Defaults to "atmosphere".
#' @param skyColor (Optional) The sky color. When skyType is "color" or "gradient", it sets the main sky color. Defaults to "blue".
#' @return Updates the input HTML file with the specified environment preset and sky settings for the 3D model.
#' @examples
#' \dontrun{
#' set_VR_environment("output.html", "forest")
#' set_VR_environment("output.html", "egypt", skyType = "color", skyColor = "red")
#' set_VR_environment("output.html", "japan", skyType = "gradient", skyColor = "#FFDD99")
#' }
#' @name set_VR_environment
#' @title Set VR Environment
#' @export
set_VR_environment <- function(input_html, environment_preset, skyType = "atmosphere", skyColor = "blue") {
  # Read the input HTML file
  html_content <- readLines(input_html)

  # Define the environment entity string with optional skyType and skyColor
  environment_entity <- glue::glue(
    '<a-entity environment="preset: {environment_preset}; skyType: {skyType}; skyColor: {skyColor}"></a-entity>',
    .open = "{", .close = "}"
  )

  # Insert the environment entity before the closing </a-scene> tag
  pattern <- '</a-scene>'
  updated_html_content <- gsub(pattern, paste0(environment_entity, "\n</a-scene>"), html_content)

  # Ensure the A-Frame and environment component scripts are included
  head_insert <- '

  <script src="https://unpkg.com/aframe-environment-component@1.3.3/dist/aframe-environment-component.min.js"></script>
  '
  updated_html_content <- gsub('</head>', paste0(head_insert, "\n</head>"), updated_html_content)

  # Write the updated content back to the input HTML file
  writeLines(updated_html_content, input_html)
  cat("HTML file updated successfully. Open '", input_html, "' in your browser to view the VR scene with the environment preset and sky settings.\n")
}
