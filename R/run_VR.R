source("R/save_model_as_glb.R")
source("R/set_VR_environment.R")

# Process and plot 3D data
coords <- plot_3Dbag_buildings(5.387200, 52.155170, 100)

# Save 3D model as glb file
#save_model_as_glb("inst/","buildings", coords)
save_model_as_glb("inst/","buildings", coords, "gray")


# Create 3D model for A-frame
#create_VR("inst/buildings.glb", "output.html")
create_VR("inst/buildings.glb", "output.html",c(0, 2.5, -3),c(0.01, 0.01, 0.01),c(-75,0,0))

# set environment: Example usage
#set_VR_environment("output.html", "tron")
#Valid values: none, default, contact, egypt, checkerboard, forest, goaland, yavapai, goldmine, threetowers, poison, arches, tron, japan, dream, volcano, starry, osiris
set_VR_environment("output.html", "tron", skyType = "color", skyColor = "pink")
#set_VR_environment("output.html", "japan", skyType = "gradient", skyColor = "#FFDD99")

# rotate VR model: Example usage
#rotate_VR("output.html", TRUE)
rotate_VR("output.html", TRUE, speed = 0.0002, clockwise = 0)
#rotate_VR("output.html", FALSE)





