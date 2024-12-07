test_that("creator() works", {
  expect_equal(creator(iris_dataset), person(given="Edgar", family="Anderson", role = "aut"))
})

iris_dataset_2 <- iris_dataset
creator(iris_dataset_2) <- person(given="Jane", family="Doe")
test_that("creator() <- value works with overwrite", {
  expect_equal(creator(iris_dataset_2), person(given="Jane", family="Doe"))
})

iris_dataset_3 <- iris_dataset
creator(x=iris_dataset_3, overwrite=FALSE) <- person("Jane", "Doe")

test_that("creator() <- value works without overwrite", {
  expect_equal(creator(iris_dataset_3),
               c(person(given="Edgar", family="Anderson", role = "aut"), person("Jane", "Doe")))
})
