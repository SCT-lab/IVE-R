#' @title Generate Default Indoor VR Environment Elements
#' 
#' @description 
#' This internal function generates a list of A-Frame HTML elements that define a default indoor environment. 
#' These elements include walls, ceiling, and other structures typically found in an indoor setting.
#' 
#' @details
#' The function returns a vector of HTML strings representing 3D objects such as boxes and cylinders that 
#' form the structure of an indoor room. The objects are designed to simulate walls, floors, and supports.
#' These elements are not visible to the end user directly but are used internally to construct the indoor
#' VR environment.
#' 
#' @return A character vector containing HTML strings of A-Frame elements for the indoor VR environment.
#' 
#' @keywords internal
#' @noRd
#' 
#' @examples
#' # Example usage within another function:
#' # elements <- .indoor_environment_default()
#' # html <- paste(elements, collapse = "\n")
#'
.indoor_environment_default <- function(){
  
  c(
    '<a-box position=\"4.5 0 -7\" width=\"6\" height=\"0.5\" depth=\"0.1\" material=\"color: #b5b1a5\"></a-box>',
    '<a-box position=\"-4.5 0 -7\" width=\"6\" height=\"0.5\" depth=\"0.1\" material=\"color: #b5b1a5\"></a-box>',
    '<a-box position=\"0 5 -7\" width=\"15\" height=\"1\" depth=\"0.1\" material=\"color: #b5b1a5\"></a-box>',
    '<a-box position=\"4.5 0 -7\" width=\"6\" height=\"10\" depth=\"0.1\" material=\"color: #b5b1a5; transparent: true; opacity: 0.5\"></a-box>',
    '<a-box position=\"-4.5 0 -7\" width=\"6\" height=\"10\" depth=\"0.1\" material=\"color: #b5b1a5; transparent: true; opacity: 0.5\"></a-box>',
    
    '<a-box position=\"0 0 7\" width=\"15\" height=\"1\" depth=\"0.1\" material=\"color: #b5b1a5\"></a-box>',
    '<a-box position=\"0 5 7\" width=\"15\" height=\"1\" depth=\"0.1\" material=\"color: #b5b1a5\"></a-box>',
    '<a-box position=\"0 0 7.1\" width=\"15\" height=\"10\" depth=\"0.1\" material=\"color: #ffffff; transparent: true; opacity: 0.5\"></a-box>',
    
    '<a-box position=\"7.5 0 0\" width=\"0.1\" height=\"1\" depth=\"15\" material=\"color: #b5b1a5\"></a-box>',
    '<a-box position=\"7.5 5 0\" width=\"0.1\" height=\"1\" depth=\"15\" material=\"color: #b5b1a5\"></a-box>',
    '<a-box position=\"7.6 0 0\" width=\"0.1\" height=\"10\" depth=\"15\" material=\"color: #ffffff; transparent: true; opacity: 0.5\"></a-box>',
    
    '<a-box position=\"-7.5 0 0\" width=\"0.1\" height=\"1\" depth=\"15\" material=\"color: #b5b1a5\"></a-box>',
    '<a-box position=\"-7.5 5 0\" width=\"0.1\" height=\"1\" depth=\"15\" material=\"color: #b5b1a5\"></a-box>',
    '<a-box position=\"-7.6 0 0\" width=\"0.1\" height=\"10\" depth=\"15\" material=\"color: #ffffff; transparent: true; opacity: 0.5\"></a-box>',
    
    '<a-box position=\"0 5 7\" width=\"15\" height=\"0.25\" depth=\"0.25\" material=\"color: #e1dfdc\"></a-box>',
    '<a-box position=\"0 5 6\" width=\"15\" height=\"0.25\" depth=\"0.25\" material=\"color: #e1dfdc\"></a-box>',
    '<a-box position=\"0 5 5\" width=\"15\" height=\"0.25\" depth=\"0.25\" material=\"color: #e1dfdc\"></a-box>',
    '<a-box position=\"0 5 4\" width=\"15\" height=\"0.25\" depth=\"0.25\" material=\"color: #e1dfdc\"></a-box>',
    '<a-box position=\"0 5 3\" width=\"15\" height=\"0.25\" depth=\"0.25\" material=\"color: #e1dfdc\"></a-box>',
    '<a-box position=\"0 5 2\" width=\"15\" height=\"0.25\" depth=\"0.25\" material=\"color: #e1dfdc\"></a-box>',
    '<a-box position=\"0 5 1\" width=\"15\" height=\"0.25\" depth=\"0.25\" material=\"color: #e1dfdc\"></a-box>',
    '<a-box position=\"0 5 0\" width=\"15\" height=\"0.25\" depth=\"0.25\" material=\"color: #e1dfdc\"></a-box>',
    '<a-box position=\"0 5 -1\" width=\"15\" height=\"0.25\" depth=\"0.25\" material=\"color: #e1dfdc\"></a-box>',
    '<a-box position=\"0 5 -2\" width=\"15\" height=\"0.25\" depth=\"0.25\" material=\"color: #e1dfdc\"></a-box>',
    '<a-box position=\"0 5 -3\" width=\"15\" height=\"0.25\" depth=\"0.25\" material=\"color: #e1dfdc\"></a-box>',
    '<a-box position=\"0 5 -4\" width=\"15\" height=\"0.25\" depth=\"0.25\" material=\"color: #e1dfdc\"></a-box>',
    '<a-box position=\"0 5 -5\" width=\"15\" height=\"0.25\" depth=\"0.25\" material=\"color: #e1dfdc\"></a-box>',
    '<a-box position=\"0 5 -6\" width=\"15\" height=\"0.25\" depth=\"0.25\" material=\"color: #e1dfdc\"></a-box>',
    '<a-box position=\"0 5 -7\" width=\"15\" height=\"0.25\" depth=\"0.25\" material=\"color: #e1dfdc\"></a-box>',
    
    '<a-box position=\"-7.5 5 0\" width=\"0.25\" height=\"0.25\" depth=\"15\" material=\"color: #e1dfdc\"></a-box>',
    '<a-box position=\"-6.5 5 0\" width=\"0.25\" height=\"0.25\" depth=\"15\" material=\"color: #e1dfdc\"></a-box>',
    '<a-box position=\"-5.5 5 0\" width=\"0.25\" height=\"0.25\" depth=\"15\" material=\"color: #e1dfdc\"></a-box>',
    '<a-box position=\"-4.5 5 0\" width=\"0.25\" height=\"0.25\" depth=\"15\" material=\"color: #e1dfdc\"></a-box>',
    '<a-box position=\"-3.5 5 0\" width=\"0.25\" height=\"0.25\" depth=\"15\" material=\"color: #e1dfdc\"></a-box>',
    '<a-box position=\"-2.5 5 0\" width=\"0.25\" height=\"0.25\" depth=\"15\" material=\"color: #e1dfdc\"></a-box>',
    '<a-box position=\"-1.5 5 0\" width=\"0.25\" height=\"0.25\" depth=\"15\" material=\"color: #e1dfdc\"></a-box>',
    '<a-box position=\"-0.5 5 0\" width=\"0.25\" height=\"0.25\" depth=\"15\" material=\"color: #e1dfdc\"></a-box>',
    '<a-box position=\"0.5 5 0\" width=\"0.25\" height=\"0.25\" depth=\"15\" material=\"color: #e1dfdc\"></a-box>',
    '<a-box position=\"1.5 5 0\" width=\"0.25\" height=\"0.25\" depth=\"15\" material=\"color: #e1dfdc\"></a-box>',
    '<a-box position=\"2.5 5 0\" width=\"0.25\" height=\"0.25\" depth=\"15\" material=\"color: #e1dfdc\"></a-box>',
    '<a-box position=\"3.5 5 0\" width=\"0.25\" height=\"0.25\" depth=\"15\" material=\"color: #e1dfdc\"></a-box>',
    '<a-box position=\"4.5 5 0\" width=\"0.25\" height=\"0.25\" depth=\"15\" material=\"color: #e1dfdc\"></a-box>',
    '<a-box position=\"5.5 5 0\" width=\"0.25\" height=\"0.25\" depth=\"15\" material=\"color: #e1dfdc\"></a-box>',
    '<a-box position=\"6.5 5 0\" width=\"0.25\" height=\"0.25\" depth=\"15\" material=\"color: #e1dfdc\"></a-box>',
    '<a-box position=\"7.5 5 0\" width=\"0.25\" height=\"0.25\" depth=\"15\" material=\"color: #e1dfdc\"></a-box>',
    '<a-cylinder position=\"7.5 0 7.0\" radius=\"0.1\" height=\"10\" material="color:#b5b1a5"></a-cylinder>',
    '<a-cylinder position=\"-7.5 0 7.0\" radius=\"0.1\" height=\"10\" material="color:#b5b1a5"></a-cylinder>',
    ' <a-cylinder position=\"7.5 0 -7.0\" radius=\"0.1\" height=\"10\" material="color:#b5b1a5"></a-cylinder>',
    '<a-cylinder position=\"-7.5 0 -7.0\" radius=\"0.1\" height=\"10\" material="color:#b5b1a5"></a-cylinder>'
  )
  
}