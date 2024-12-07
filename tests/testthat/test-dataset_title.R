test_that("dataset_title() works", {
  expect_equal(dataset_title(iris_dataset), "Iris Dataset")
})
iris_dataset_2 <- iris_dataset
value <- "The Famous Iris Dataset"
dataset_title(x=iris_dataset_2, overwrite = TRUE) <-"The Famous Iris Dataset"

test_that("dataset_title() <- value works with overwrite", {
  expect_equal(dataset_title(iris_dataset_2), "The Famous Iris Dataset")
})

test_that("dataset_title() <- value works without overwrite", {
  expect_warning(dataset_title(x=iris_dataset_2, overwrite = FALSE) <-"The Most Famous Iris Dataset")
})

