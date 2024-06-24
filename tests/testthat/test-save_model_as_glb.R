# tests/testthat/test-save_model_as_glb.R
library(testthat)
library(rgl)
library(grDevices)
library(aframeinr)

# Mock the rgl::writeOBJ function
writeOBJ <- function(...) {
  cat("Mock writeOBJ called\n")
}

# Mock the system call to obj2gltf
system <- function(command, wait) {
  cat("Mock system call: ", command, "\n")
  return(0)
}


test_that("save_model_as_glb works correctly", {
  # Create a simple data frame of coordinates with a multiple of 3 rows
  coords <- data.frame(x = rnorm(9), y = rnorm(9), z = rnorm(9))

  # Define the output file name
  filename <- "test_model"

  # Run the function
  save_model_as_glb(filename, coords, color = "blue")

  # Check that the files were created
  expect_true(file.exists(paste0(filename, ".glb")))

  # Check if intermediate files were created and removed
  expect_false(file.exists(paste0(filename, ".obj")))
  expect_false(file.exists(paste0(filename, ".mtl")))

  # Clean up created files if any
  if (file.exists(paste0(filename, ".glb"))) {
    file.remove(paste0(filename, ".glb"))
  }
})
