
<!-- README.md is generated from README.Rmd. Please edit that file -->

# newdataset

<!-- badges: start -->

[![Codecov test
coverage](https://codecov.io/gh/antaldaniel/dataset/graph/badge.svg)](https://app.codecov.io/gh/antaldaniel/dataset)
<!-- badges: end -->

The aim of the ‘dataset’ package is to make tidy datasets easier to
release, exchange and reuse. It organizes and formats data frame ‘R’
objects into well-referenced, well-described, interoperable datasets
into release and reuse ready form.

## Installation

You can install the development version of new_dataset like so:

``` r
# FILL THIS IN! HOW CAN PEOPLE INSTALL YOUR DEV PACKAGE?
```

## Example

“Tidy datasets provide a standardised way to link the structure of a
dataset (its physical layout) with its semantics (its meaning).
[tidyr](https://cran.r-project.org/web/packages/tidyr/vignettes/tidy-data.html)”

While the tidyverse packages have made it easier to structure datasets
into a tidy format, the semantics of these datasets are not sufficiently
rich for data exchange or publication, and often, they pose a difficulty
for the same user if they take on work with the same dataset after a
longer time.

The dataset package aims to create extensions of the modernised
data.frame, i.e., tibble that contains rich semantic information for
data exchange and reuse. It adds standardised information to the
attributes (metadata) of the columns and the data frame as a whole, and
it supports standard XML serialisations for statistical data exchange.

    #> Anderson E (1935). "Iris Dataset." doi:10.5281/zenodo.10396807
    #> <https://doi.org/10.5281/zenodo.10396807>.
    #>    rowid      Sepal.Length Petal.Length Sepal.Width Petal.Width Species   
    #>    <hvn_lbl_> <hvn_lbl_>   <hvn_lbl_>   <hvn_lbl_>  <hvn_lbl_>  <hvn_lbl_>
    #>  1 #1         5.1          1.4          3.5         0.2         1 [setosa]
    #>  2 #2         4.9          1.4          3           0.2         1 [setosa]
    #>  3 #3         4.7          1.3          3.2         0.2         1 [setosa]
    #>  4 #4         4.6          1.5          3.1         0.2         1 [setosa]
    #>  5 #5         5            1.4          3.6         0.2         1 [setosa]
    #>  6 #6         5.4          1.7          3.9         0.4         1 [setosa]
    #>  7 #7         4.6          1.4          3.4         0.3         1 [setosa]
    #>  8 #8         5            1.5          3.4         0.2         1 [setosa]
    #>  9 #9         4.4          1.4          2.9         0.2         1 [setosa]
    #> 10 #10        4.9          1.5          3.1         0.1         1 [setosa]
    #> # ℹ 140 more rows

Our `dataset_df` class adds a `utils::bibentry` object to the attributes
of the data.frame, and fills it up with the standard unassigned values
of DataCite, an important open data publication standard.

``` r
print(get_bibentry(iris_dataset), "Bibtex")
#> @Misc{,
#>   title = {Iris Dataset},
#>   author = {Edgar Anderson},
#>   publisher = {American Iris Society},
#>   year = {1935},
#>   resourcetype = {Dataset},
#>   identifier = {https://doi.org/10.5281/zenodo.10396807},
#>   version = {0.1.0},
#>   description = {The famous (Fisher's or Anderson's) iris data set.},
#>   language = {en},
#>   format = {application/r-rds},
#>   rights = {:unas},
#>   doi = {https://doi.org/10.5281/zenodo.10396807},
#>   source = {https://doi.org/10.1111/j.1469-1809.1936.tb02137.x},
#> }
```

We created the `defined` class, an extension of `haven::labelled` from
tidyverse, that goes beyond adding variable labels to the columns of a
tidy dataset, and value ables to the categorical variables. We add two
more crucial metadata: a unit of measure and a definition, with the
ability to use statistical and web exchange standards to provide such
information with linked open data.

``` r
gdp <- defined(
    c(3897, 7365), 
    label = "Gross Domestic Product", 
    unit = "million dollars", 
    definition = "http://data.europa.eu/83i/aa/GDP")

attributes(gdp)
#> $label
#> [1] "Gross Domestic Product"
#> 
#> $class
#> [1] "haven_labelled_defined" "haven_labelled"         "vctrs_vctr"            
#> [4] "double"                
#> 
#> $unit
#> [1] "million dollars"
#> 
#> $definition
#> [1] "http://data.europa.eu/83i/aa/GDP"
```

A semantic application or a human user can look up the definition at
[http://data.europa.eu/83i/aa/GDP](https://data.europa.eu/83i/aa/GDP).

Some packages, for example, dataspice, help to add further information
about the semantics of the dataset as a whole and some of its contents,
but they detach such information from the data.frame that contains the
data. Our aim was to retain all the critical information to publish,
find, extend, join the dataset with other information in the R object
itself.

``` r
saveRDS(iris_dataset, file = tempfile())
```
