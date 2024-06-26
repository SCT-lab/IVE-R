source("R/save_model.R")
source("R/set_VR_environment.R")

# Process and plot 3D data
coords <- plot_3Dbag_buildings(5.387200, 52.155170, 100)

# Save 3D model as obj and glb files
save_model("inst/","buildings", coords)

# Save 3D model as obj and glb files with a specific color
#save_model("inst/","buildings", coords, "gray")

# Create 3D model for A-frame
create_VR("inst/buildings.glb", "output.html")

# Create 3D model for A-frame with specific position, scale, and rotation values
#create_VR("inst/buildings.glb", "output.html",c(0, 2.5, -3),c(0.01, 0.01, 0.01),c(-75,0,0))

# Set VR environment
#Valid values: none, default, contact, egypt, checkerboard, forest, goaland, yavapai, goldmine, threetowers, poison, arches, tron, japan, dream, volcano, starry, osiris
set_VR_environment("output.html", "tron")

# Set VR environment with sky type (color, gradient) and color
#set_VR_environment("output.html", "tron", skyType = "color", skyColor = "pink")
#set_VR_environment("output.html", "japan", skyType = "gradient", skyColor = "#FFDD99")

# Rotate only glb models clockwise with default speed
#rotate_VR("output.html", TRUE)

# Rotate only glb models clockwise/counterclockwise with a specific speed
rotate_VR("output.html", TRUE, speed = 0.0002, clockwise = 0)

# Stop the glb model rotation
#rotate_VR("output.html", FALSE)
