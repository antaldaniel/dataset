
test_that("language() works", {
  expect_equal(language(iris_dataset), "en")
})

myiris <- iris_dataset
value <- "fr"
language(x=myiris) <- "fr"
test_that("language() works", {
  expect_equal(language(myiris), "fra")
})

language(x=myiris, iso_639_code = "639-1") <- "fr"
test_that("language() works", {
  expect_equal(language(myiris), "fr")
})
