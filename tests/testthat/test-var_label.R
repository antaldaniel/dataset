

library(testthat)
test_df <- dataset_df(a = 1:2, b=3:4)

test_that("var_label() works", {
  expect_equal(var_label(iris_dataset$Sepal.Length), "Length of the sepal in cm")
  expect_equal(class(var_label(iris_dataset, unlist=TRUE)), "character")
  expect_equal(var_label(test_df, unlist=TRUE, null_action = "fill" ), c(a = "a", b="b"))
  expect_equal(label_attribute(iris_dataset$Species), "Taxon name within the Iris genus")
})

test_that("var_label() throws error", {
  expect_error(var_label(test_df) <- c("A", "B"))
})


test_that("var_label.dataset_df() works", {
  expect_equal(length(var_label(iris_dataset, unlist=TRUE)), 6)
  expect_true(is.character(var_label(iris_dataset, unlist=TRUE)))
})


