
sepal_length <- defined(iris$Sepal.Length,
                        labels = NULL,
                        label = "Sepal length",
                        unit = "centimeters",
                        definition = "https://www.wikidata.org/wiki/Property:P2043")

labelled::to_labelled(iris$Species)

myspecies <- defined(x =iris$Species,
                     label = "Taxon name within the Iris genus",
                     definition = "https://npgsweb.ars-grin.gov/gringlobal/taxon/taxonomygenus?id=6074",
                     namespace = "Iris")

test_that("labelled_defined() works", {
  expect_equal(is.defined(sepal_length), TRUE)
  expect_equal(var_label(sepal_length), "Sepal length")
  expect_equal(var_unit(sepal_length), "centimeters")
  expect_equal(var_definition(sepal_length), "https://www.wikidata.org/wiki/Property:P2043")
  expect_equal(var_namespace(myspecies), "Iris")
  expect_true(all(as.character(sepal_length) == as.character(iris$Sepal.Length)))
})

test_that("labelled_defined() throws error", {
  expect_error(var_unit(sepal_length) <- c("cm", "mm"))
})


a <- defined(iris$Sepal.Length[1:3],
        labels = NULL,
        label = "Sepal length",
        unit = "centimeters",
        definition = "https://www.wikidata.org/wiki/Property:P2043")


b <- defined(iris$Sepal.Length[4:6],
             labels = NULL,
             label = "Sepal length",
             unit = "centimeters",
             definition = "https://www.wikidata.org/wiki/Property:P2043")

bmm <- defined(iris$Sepal.Length[7:9]*10,
             labels = NULL,
             label = "Sepal length",
             unit = "milimeters",
             definition = "https://www.wikidata.org/wiki/Property:P2043")


test_that("c() works", {
  expect_equal(is.defined(c(a,b)), TRUE)
  expect_equal(length(c(a,b)), 6)
  expect_error(c(a,bmm))
})


