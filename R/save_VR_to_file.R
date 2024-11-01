#' @title Save VR Environment to HTML File
#'
#' @description 
#' This function saves a generated VR environment, defined as HTML content, to a specified file.
#' It writes the VR environment's HTML code to a file for later viewing or use.
#'
#' @param vr_env A list or object containing the HTML content of the VR environment. 
#'               It must have a field `html_content`, which is a character string containing the HTML code.
#' @param output_html A string specifying the file path where the HTML file will be saved.
#'
#' @return None. The function saves the VR environment to the file system and prints a message upon completion.
#'
#'
#' @examples
#' \dontrun{
#' vr_environment <- set_VR_environment()  # Example usage of a function that creates VR environment
#' save_VR_to_file(vr_env = vr_environment, output_html = "my_vr_scene.html")
#' }
#' @export
save_VR_to_file <- function(vr_env, output_html) {
  
  tryCatch(
    {
      # Check if filename is valid
      if (!is.character(output_html) || nchar(output_html) == 0) {
        stop("Filename must be a non-empty string.")
      }
      writeLines(vr_env$html_content, output_html)
      cat("VR environment saved to", output_html, "\n")
    },
    
    error = function(e) {
      stop("An error occurred: ", e$message)
    }
  )
}
