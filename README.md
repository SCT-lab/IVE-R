# **aframeinr: Creating and Visualizing 3D Models in R and A-Frame**

## Overview

`aframeinr` is an R package designed to streamline the creation of 3D visualizations and immersive virtual reality (VR) scenes using geographic data and the A-Frame framework. This package provides a comprehensive set of tools to define areas of interest, retrieve 3D building data, visualize these buildings, and create interactive VR environments. Key features include defining spatial areas, extracting and plotting 3D building data, saving models in GLB format, and generating customizable VR scenes with environment settings and rotation capabilities.

## Installation

### R Package Dependencies

To install the development version of `aframeinr`:

```         
#Install packages
install.packages(c("sf", "glue","rgl", "dplyr", "httr", "units"))

#Install devtools if you haven't already
install.packages("devtools")

#Install aframeinr from GitHub
##devtools::install_github("SCT-lab/IVE-R")
```

## Usage

### Define Area of Interest

The `define_aoi` function allows you to define an area of interest based on a central point and a buffer distance.

```         
library(aframeinr)

# Define area of interest
bbox_string <- define_aoi(lon = 5.387200, lat = 52.155170, buffer_distance = 1000)

print(bbox_string)
```

### Get 3DBag Data

The `get_3Dbag_items` function retrieves 3D building data within the defined area of interest.

```         
# Get 3DBag data
data <- get_3Dbag_items(bbox_string)
```

### Plot 3DBag Buildings

The `plot_3Dbag_buildings` function gets 3DBag Data within the defined area of interest using the `define_aoi` and `get_3Dbag_items` functions, plots the 3D buildings and returns a matrix of coordinates.

```         
# Plot 3DBag buildings
coords <- plot_3Dbag_buildings(lon = 5.387200, lat = 52.155170, buffer_distance = 100)
```

<img src="https://github.com/SCT-lab/IVE-R/blob/main/figures/3Dplot.png" width="684"/> 

### Save 3D Model as GLB

The `save_model_as_glb` function saves the 3D model as a GLB file, which can be used for VR scenes.

```         
#Save 3D model as GLB file
save_model_as_glb("buildings", coords)
```

### Create VR HTML

The `create_VR function` generates an HTML file with an A-Frame VR scene using the GLB model.

```         
# Create VR HTML
`#create_VR("https://github.com/SCT-lab/IVE-R/buildings.glb", "output.html")`
```

<img src="https://github.com/SCT-lab/IVE-R/main/figures/create_VR.png" width="684"/>

```         
# Create VR HTML with optional parameters
create_VR("buildings.glb", "output.html", position = c(0, 2.5, -3), scale = c(0.01, 0.01, 0.01), rotation = c(-75, 0, 0))
```

<img src="https://github.com/SCT-lab/IVE-R/main/figures/create_VR_prop.png" width="684"/>

### Set VR Environment

The `set_VR_environment` function updates the VR HTML file to add an A-Frame environment component with specified parameters.

```         
# Set VR environment
set_VR_environment("output.html", "tron")
```

<img src="https://github.com/SCT-lab/IVE-R/main/figures/set_env_default.png" width="684"/>

```         
# Set VR environment with optional parameters
set_VR_environment("output.html", "tron", skyType = "color", skyColor = "pink")
```

<img src="https://github.com/SCT-lab/IVE-R/main/figures/set_evn_tron.png" width="684"/>

### Rotate VR Model

The `rotate_VR` function adds rotation to the VR model in the HTML file.

```         
# Rotate VR model
rotate_VR("output.html", TRUE, speed = 0.0002, clockwise = 0)
```

<img src="https://github.com/SCT-lab/IVE-R/main/figures/rotate.png" width="684"/>

## Example Workflow

Here is an example workflow to create a VR scene from scratch:

```         
# Load library
library(aframeinr)

# Plot 3DBag buildings
coords <- plot_3Dbag_buildings(5.387200, 52.155170, 1000)

# Save 3D model as GLB file
save_model_as_glb("buildings", coords)

# Create VR HTML
create_VR("buildings.glb", "output.html", position = c(0, 2.5, -3), scale = c(0.01, 0.01, 0.01), rotation = c(-75, 0, 0))

# Set VR environment
set_VR_environment("output.html", "tron", skyType = "color", skyColor = "pink")

# Rotate VR model
rotate_VR("output.html", TRUE, speed = 0.0002, clockwise = 0)
```

## Contributing

Please open an issue or submit a pull request if you find any bugs or have suggestions for improvements.

## License

This package is licensed under the MIT License.
