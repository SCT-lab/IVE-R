#' @title Adjust to Table Script for A-Frame VR
#'
#' @description 
#' This internal function generates a JavaScript script to register an A-Frame component called 
#' "adjust-to-table". The script adjusts the position and dimensions of a table entity based on 
#' the model loaded into the VR scene, ensuring the table is placed at the base of the model.
#' 
#' @details 
#' The component is automatically registered when the function is called, but the table is hidden 
#' by default and becomes visible once the model has been fully loaded. The table dimensions 
#' (width, depth, and height) are dynamically calculated to match the bounding box of the model 
#' and ensure proper positioning.
#' 
#' This function is intended to be used internally within the package and should not be 
#' directly called by users.
#' 
#' @return 
#' A string containing the JavaScript code to be inserted into an HTML document for A-Frame VR scenes.
#' 
#' @keywords internal
#' 
#' @examples
#' # This function is used internally within the package and does not require direct user interaction.
.adjust_to_table_script <- function(){
  '
       <!-- Register the component before the scene -->
    <script>
      AFRAME.registerComponent("adjust-to-table", {
        init: function () {
          const model = this.el;
          const scene = document.querySelector("a-scene");

          console.log("Initializing adjust-to-table component for:", model);

          // Create the table entity
          const table = document.createElement("a-box");
          table.setAttribute("id", "table");
          table.setAttribute("color", "#7f8274");
          table.setAttribute("depth", "1");
          table.setAttribute("width", "1");
          table.setAttribute("visible", "false");

          console.log("Table entity created:", table);

          // Append table to the scene
          scene.appendChild(table);

          console.log("Table appended to the scene");

          // Listen for the model-loaded event
          model.addEventListener("model-loaded", () => {
            console.log("Model loaded:", model);

            // Get models world bounding box
            const modelBoundingBox = new THREE.Box3().setFromObject(model.object3D);

            // Get the models world position in the scene
            const worldPosition = new THREE.Vector3();
            model.object3D.getWorldPosition(worldPosition);

            const modelHeight = modelBoundingBox.max.y - modelBoundingBox.min.y;
            const modelWidth = modelBoundingBox.max.x - modelBoundingBox.min.x;
            const modelDepth = modelBoundingBox.max.z - modelBoundingBox.min.z;

            console.log("Model dimensions - Height:", modelHeight, "Width:", modelWidth, "Depth:", modelDepth);
            console.log("Model world position:", worldPosition);

            // Set table dimensions based on the model
            table.setAttribute("depth", modelDepth);
            table.setAttribute("width", modelWidth);

            // Calculate table height (distance from model bottom to the floor)
            const tableHeight = Math.abs(modelBoundingBox.min.y);
            table.setAttribute("height", tableHeight);

            // Position the table exactly at the bottom of the model, expanding only downwards
            const tableYPosition = worldPosition.y + modelBoundingBox.min.y - tableHeight / 2;

            // Position the table directly below the model, ensuring it only expands downward
            table.setAttribute("position", `${worldPosition.x} ${modelBoundingBox.min.y - (tableHeight / 2)} ${worldPosition.z}`);

            console.log("Table positioned below the model at:", table.getAttribute("position"));

            // Make the table visible
            table.setAttribute("visible", "true");

            console.log("Table made visible");
          });
        }
      });
    </script>'
}