#' @title Add a 3D Object to the VR Environment
#'
#' @description 
#' This function adds a 3D object specified by an OBJ file to an existing 
#' VR environment. The object is positioned, rotated, and scaled according 
#' to the provided parameters. Optionally, it can also adjust the position 
#' of a table in relation to the object.
#'
#' @param vr_env A list representing the VR environment, containing the 
#'   `html_content` as a character string that holds the HTML for the VR scene.
#' @param obj_path A character string specifying the path to the OBJ file to be added.
#' @param position A numeric vector of length 3 specifying the position of the 
#'   object in the VR scene, given as `(x, y, z)`. Defaults to `(0, 0, 0)`.
#' @param rotation A numeric vector of length 3 specifying the rotation of the 
#'   object in the VR scene, given as `(x, y, z)` angles in degrees. Defaults to `(0, 0, 0)`.
#' @param scale A numeric vector of length 3 specifying the scale of the object 
#'   in the VR scene. Defaults to `(0.01, 0.01, 0.01)`.
#' @param adjust_to_table A logical indicating whether to automatically include
#'  table under the object. Defaults to `TRUE`.
#'
#' @details 
#' The function first checks if the specified OBJ file exists and constructs 
#' an MTL file path based on the OBJ file's name. It creates appropriate 
#' `<a-asset-item>` tags for the object and material and appends these to 
#' the VR environment's HTML content before the closing `</a-scene>` tag. 
#' If the table adjustment feature is enabled, the relevant JavaScript component 
#' is added to the HTML as well.
#'
#' @return 
#' A list representing the updated VR environment, with the newly added 
#' object and modified `html_content`.
#'
#' @examples
#' # Example of adding a 3D object to a VR environment
#' vr_env <- list(html_content = "<a-scene></a-scene>")
#' obj_path <- "path/to/your/object.obj"
#' updated_vr_env <- add_VR_object(vr_env, obj_path, position = c(1, 0, -3), 
#'                                  rotation = c(0, 180, 0), scale = c(0.1, 0.1, 0.1))
#' 
#' @export
add_VR_object <- function(vr_env, obj_path, position = c(0, 0, 0), 
                          rotation = c(0, 0, 0), scale = c(0.01, 0.01, 0.01), 
                          adjust_to_table = TRUE) {
  
  html_content <- vr_env$html_content
  
  # Check if the obj_path is valid
  if (!file.exists(obj_path)) {
    stop("The OBJ file does not exist.")
  }
  
  mtl_path <- sub("\\.obj$", ".mtl", obj_path)
  
  # Define the asset references
  obj_id <- tools::file_path_sans_ext(basename(obj_path))
  mtl_id <- paste0(tools::file_path_sans_ext(basename(obj_path)),"-mtl")
  
  # Define the asset item tags
  asset_items <- glue::glue(
    '<a-asset-item id="{obj_id}" src="{obj_path}"></a-asset-item>',
    if (!is.null(mtl_path)) glue::glue('<a-asset-item id="{mtl_id}" src="{mtl_path}"></a-asset-item>') else NULL,
    .open = "{", .close = "}"
  )
  
  # Define the <a-entity> tag for the 3D object
  obj_entity <- glue::glue(
    '<a-entity obj-model="obj: #{obj_id}; mtl: #{mtl_id}" position="{position[1]} {position[2]} {position[3]}" ',
    'rotation="{rotation[1]} {rotation[2]} {rotation[3]}" scale="{scale[1]} {scale[2]} {scale[3]}" ',
    if (adjust_to_table) 'adjust-to-table' else '', '></a-entity>',
    .open = "{", .close = "}"
  )
  
  # Define patterns for asset items and 3D objects
  asset_pattern <- paste0('<a-asset-item id="', obj_id, '" src="[^"]+"></a-asset-item>')
  if (!is.null(mtl_id)) {
    mtl_pattern <- paste0('<a-asset-item id="', mtl_id, '" src="[^"]+"></a-asset-item>')
  }
  obj_pattern <- paste0('<a-entity obj-model="obj: #', obj_id, '; mtl: #', mtl_id, '"[^>]*></a-entity>')
  
  # Check for existing asset items
  existing_assets <- any(grepl(asset_pattern, html_content)) || (is.null(mtl_id) || any(grepl(mtl_pattern, html_content)))
  
  existing_obj <- any(grepl(obj_pattern, html_content))
  
  # Prepare the HTML content
  if (!existing_assets) {
    # Insert asset items before the closing </a-scene> tag
    asset_insert_position <- which(grepl('</a-scene>', html_content))
    if (length(asset_insert_position) > 0) {
      html_content <- append(html_content, paste0(asset_items, collapse = "\n"), after = asset_insert_position - 1)
    }
  }
  
  if (!existing_obj) {
    # Insert the new OBJ entity before the closing </a-scene> tag
    obj_insert_position <- which(grepl('</a-scene>', html_content))
    if (length(obj_insert_position) > 0) {
      html_content <- append(html_content, obj_entity, after = obj_insert_position - 1)
    }
  }
  
  # Add the JavaScript component for adjusting the table
  script_tag <- .adjust_to_table_script()
  
  # Insert the script tag into the HTML content if not already present
  script_pattern <- 'AFRAME\\.registerComponent\\("adjust-to-table",'
  if (!any(grepl(script_pattern, html_content)) & adjust_to_table) {
    script_insert_position <- which(grepl('<body>', html_content))
    if (length(script_insert_position) > 0) {
      html_content <- append(html_content, script_tag, after = script_insert_position)
    }
  }
  
  # Write the updated content back to the input HTML file
  vr_env <- list(html_content = html_content)
  
  cat("OBJ file has been added or replaced in the VR environment.\n")
  
  return(vr_env)
}