# **aframeinr: Creating and Visualizing 3D Models in R and A-Frame**

## Overview

`aframeinr` is an R package designed to facilitate the creation of 3D
visualizations and virtual reality (VR) scenes from geographic data and
A-Frame. This package allows you to define an area of interest, retrieve
3D building data, plot these buildings, and create interactive VR
scenes.

## Installation

To install the development version of `aframeinr` from GitHub, use:

\`\`\`R \# Install devtools if you haven't already
install.packages("devtools")

Install aframeinr from GitHub

devtools::install_github("yourusername/aframeinr")

## Usage

### Define Area of Interest

The `define_aoi` function allows you to define an area of interest based
on a central point and a buffer distance.

\`\`\`R

library(aframeinr)

\# Define area of interest

bbox_string \<- define_aoi(lon = 5.387200, lat = 52.155170,
buffer_distance = 1000)

print(bbox_string)

### Get 3DBag Data 

The get_3Dbag_items function retrieves 3D building data within the
defined area of interest.

\# Get 3DBag data

data \<- get_3Dbag_items(bbox_string)

### Plot 3DBag Buildings 

The plot_3Dbag_buildings function plots the 3D buildings within the
defined area of interest and returns a matrix of coordinates.

\# Plot 3DBag buildings

coords \<- plot_3Dbag_buildings(lon = 5.387200, lat = 52.155170,
buffer_distance = 100)

![](images/Screenshot 2024-06-21 at 10.45.22 AM.png){width="650"}

### Save 3D Model as GLB 

The save_model_as_glb function saves the 3D model as a GLB file, which
can be used for VR scenes.

#Save 3D model as GLB file

save_model_as_glb("buildings", coords)

### Create VR HTML 

The create_VR function generates an HTML file with an A-Frame VR scene
using the GLB model.

\# Create VR HTML

#create_VR("buildings.glb", "output.html")

![](images/Screenshot 2024-06-24 at 1.03.16 PM.png){width="650"}

create_VR("buildings.glb", "output.html", position = c(0, 2.5, -3),
scale = c(0.01, 0.01, 0.01), rotation = c(-75, 0, 0))

![](images/Screenshot 2024-06-24 at 1.06.06 PM.png){width="650"}

### Set VR Environment 

The set_VR_environment function updates the VR HTML file to add an
A-Frame environment component with specified parameters.

\# Set VR environment

#set_VR_environment("output.html", "tron")

![](images/Screenshot 2024-06-24 at 1.10.17 PM.png){width="650"}

set_VR_environment("output.html", "tron", skyType = "color", skyColor =
"pink")

## ![](images/Screenshot 2024-06-24 at 1.12.52 PM.png){width="650"}

### Rotate VR Model 

The rotate_VR function adds rotation to the VR model in the HTML file.

\# Rotate VR model

rotate_VR("output.html", TRUE, speed = 0.0002, clockwise = 0)

![](images/Screenshot 2024-06-24 at 1.17.39 PM.png){width="650"}

## Example Workflow

\`\`\`markdown \## Example Workflow

Here is an example workflow to create a VR scene from scratch:

\`\`\`R \# Load library library(aframeinr)

### Define area of interest

bbox_string \<- define_aoi(lon = 5.387200, lat = 52.155170,
buffer_distance = 1000)

### Get 3DBag data

data \<- get_3Dbag_items(bbox_string)

### Plot 3DBag buildings

coords \<- plot_3Dbag_buildings(5.387200, 52.155170, 1000)

### Save 3D model as GLB file

save_model_as_glb("buildings", coords)

### Create VR HTML

create_VR("buildings.glb", "output.html", position = c(0, 2.5, -3),
scale = c(0.01, 0.01, 0.01), rotation = c(-75, 0, 0))

### Set VR environment

set_VR_environment("output.html", "tron", skyType = "color", skyColor =
"pink")

### Rotate VR model

rotate_VR("output.html", TRUE, speed = 0.0002, clockwise = 0)

## Contributing

Please open an issue or submit a pull request if you find any bugs or
have suggestions for improvements.

### License

This package is licensed under the MIT License.

Development work by Abide Coskun-Setirek, project managed by Will Hurst (will.hurst@wur.nl). The project was funded by NWO OSF project OSF23.1.004.

<p align="center">
  <a href="https://www.linkedin.com/company/sct-lab"><img src="https://github.com/SCT-lab/DigiFungi/blob/main/images/SCT-WUR.png" alt="SCT Lab" width="100"></a>
  <a href="https://www.wur.nl/en.htm"><img src="https://github.com/SCT-lab/DigiFungi/blob/main/images/Wur-logo.png" alt="WUR" width="100"></a>
</p>
