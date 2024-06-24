# tests/testthat/test-save_model_as_obj.R
library(testthat)
library(aframeinr)

test_that("save_model_as_obj works correctly", {
  # Create a simple data frame of coordinates with a multiple of 3 rows
  coords <- data.frame(x = rnorm(9), y = rnorm(9), z = rnorm(9))

  # Define the output file name
  filename <- "test_model"

  # Run the function
  save_model_as_obj(filename, coords)

  # Check that the files were created
  expect_true(file.exists(paste0(filename, ".obj")))
  expect_true(file.exists(paste0(filename, ".mtl")))

  # Clean up created files
  file.remove(paste0(filename, ".obj"))
  file.remove(paste0(filename, ".mtl"))
})
