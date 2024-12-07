
test_that("xsd_convert(x, idcols) works", {
  expect_equal(xsd_convert(head(iris)[1,1]), '\"5.1\"^^<xs:decimal>')
  expect_equal(unlist(xsd_convert(x=head(iris_dataset), idcol=1)[1,2]), c(Sepal.Length = '\"5.1\"^^<xs:decimal>' ))
})
