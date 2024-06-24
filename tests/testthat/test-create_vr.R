library(testthat)
library(glue)
library(aframeinr)

# Create a dummy GLB file for testing purposes
dummy_glb <- "dummy_model.glb"
file.create(dummy_glb)

test_that("create_vr generates correct HTML structure", {
  model_path <- dummy_glb
  output_html <- "test_vr_scene.html"
  create_VR(model_path, output_html)
  html_content <- readLines(output_html)
  expect_true(any(grepl(dummy_glb, html_content)))
})

test_that("create_vr handles non-existent model path gracefully", {
  non_existent_path <- "non_existent_model.glb"
  expect_error(create_VR(non_existent_path, "test_vr_scene.html"), "The file does not exist at the specified path:")
})


# Clean up dummy files after tests
file.remove(dummy_glb)
file.remove("test_vr_scene.html")

