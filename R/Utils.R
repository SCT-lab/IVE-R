#' @title Validate Color
#'
#' @description
#' This function checks whether a given color is valid. It supports hex codes and a set of basic named colors.
#'
#' @param color A string representing the color (hex code or named color).
#' 
#' @return TRUE if the color is valid, otherwise FALSE.
#'
#' @examples
#' validColor("#FF5733")  # Returns TRUE
#' validColor("red")      # Returns TRUE
#' validColor("invalidColorName")  # Returns FALSE
#'
validColor <- function(x) {
  tryCatch(is.matrix(col2rgb(x)), 
           error = function(e) FALSE)
}