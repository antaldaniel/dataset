
sepal_length <- labelled_defined(iris$Sepal.Length,
                                 labels = NULL,
                                 label = "Sepal length",
                                 unit = "centimeters",
                                 definition = "https://www.wikidata.org/wiki/Property:P2043")

test_that("labelled_defined() works", {
  expect_equal(is.labelled_defined(sepal_length), TRUE)
  expect_equal(var_label(sepal_length), "Sepal length")
  expect_equal(var_unit(sepal_length), "centimeters")
  expect_equal(var_definition(sepal_length), "https://www.wikidata.org/wiki/Property:P2043")
  expect_true(all(as.character(sepal_length) == as.character(iris$Sepal.Length)))
})

test_that("labelled_defined() throws error", {
  expect_error(var_unit(sepal_length) <- c("cm", "mm"))
})

