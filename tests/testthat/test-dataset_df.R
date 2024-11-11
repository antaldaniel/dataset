
test_that("subsetting works", {
  expect_equal(ncol(iris_dataset[, 1]), 1)
  expect_equal(nrow(iris_dataset[1,2]), 1)
  expect_equal(iris$Sepal.Length[1], as.numeric(iris_dataset[1,2]) )
})


iris_dataset1 <- iris_dataset
iris_dataset2 <- iris_dataset

test_that("rbind works", {
  expect_equal(nrow(rbind(iris_dataset1, iris_dataset2)), 300)
})


iris_dataset
iris_dataset_petals <- iris_dataset[, c(1,2,4,6)]
iris_dataset_sepals <- iris_dataset[, c(1,3,5,6)]
library(dplyr)

iris_dataset_petals %>% left_join (iris_dataset_sepals, by=c("rowid","Species"))
