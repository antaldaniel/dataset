small_country_dataset <- dataset_df(
  country_name = labelled_unit(c("Andorra", "Lichtenstein"), label  = "Country"),
  gdp = labelled_unit(c(3897, 7365),
                      label = "Gross Domestic Product",
                      unit = "million dollars")
)

var_definition(small_country_dataset$country_name) <- "http://data.europa.eu/bna/c_6c2bb82d"


test_that("var_definition() works", {
  expect_equal(var_definition(small_country_dataset$country_name), "http://data.europa.eu/bna/c_6c2bb82d")
})
