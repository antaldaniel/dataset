
<!-- README.md is generated from README.Rmd. Please edit that file -->

# newdataset

<!-- badges: start -->
<!-- badges: end -->

The aim of the ‘dataset’ package is to make tidy datasets easier to
release, exchange and reuse. It organizes and formats data frame ‘R’
objects into well-referenced, well-described, interoperable datasets
into release and reuse ready form.

## Installation

You can install the development version of newdataset like so:

``` r
# FILL THIS IN! HOW CAN PEOPLE INSTALL YOUR DEV PACKAGE?
```

## Example

“Tidy datasets provide a standardised way to link the structure of a
dataset (its physical layout) with its semantics (its meaning).
[tidyr](https://cran.r-project.org/web/packages/tidyr/vignettes/tidy-data.html)”
While the tidyverse packages have made it easier to structure dataset
into a tidy format, the semantics of the data are often remain at such a
minimal level that it does not allow a meaningful reuse of the dataset.
Often the only information we have about the meaning of the dataset is a
column heading as a variable name, and a sequential `row.number` as an
observation identifier. There is no way we can find out if a data
subject is observed multiple times. Without a unit of measure
information we may add together miles and kilometers, kilograms and
tons, euros and dollars.

The aim of the dataset package is to improve the semantic infrastructure
of tidy datasets beyond the current capabilities of the tidyverse
packages.

    #> Anderson E (1935). "Iris Dataset." doi:10.5281/zenodo.10396807
    #> <https://doi.org/10.5281/zenodo.10396807>.
    #>    Sepal.Length Petal.Length Sepal.Width Petal.Width Species   
    #>    <hvn_lbl_>   <hvn_lbl_>   <hvn_lbl_>  <hvn_lbl_>  <hvn_lbl_>
    #>  1 5.1          5.1          3.5         0.2         1         
    #>  2 4.9          4.9          3           0.2         1         
    #>  3 4.7          4.7          3.2         0.2         1         
    #>  4 4.6          4.6          3.1         0.2         1         
    #>  5 5            5            3.6         0.2         1         
    #>  6 5.4          5.4          3.9         0.4         1         
    #>  7 4.6          4.6          3.4         0.3         1         
    #>  8 5            5            3.4         0.2         1         
    #>  9 4.4          4.4          2.9         0.2         1         
    #> 10 4.9          4.9          3.1         0.1         1         
    #> # ℹ 140 more rows

To foster the findability, interoperability and reusability of a
dataset, we attach standard metadata to the R object itself. Other
metadata packages add this information to a separate CSV or JSON file,
however, there is no guarantee that the next user will receive an intact
R object and a separate metadata file. Therefore we attach this
information to the native R object.

``` r
print(get_bibentry(iris_dataset), "Bibtex")
#> @Misc{,
#>   title = {Iris Dataset},
#>   author = {Edgar Anderson},
#>   year = {1935},
#>   doi = {https://doi.org/10.5281/zenodo.10396807},
#> }
```

How can we work with the famous `iris` dataset, add new observations, or
make calculations if we do not happen to know that the numeric variables
are all measured in centimeters? Do we know exactly how to tell a
`setosa` observation from a `virginica`, if we do not know that the
`Species` variable refers to species in the *Iris* genus, and `setosa`
stands for *Iris setosa*?

Can you divide the sepal length variable with sepal width? Technically
you can, because they have the same numeric class.

``` r
iris_dataset$Sepal.Length[1:3] / iris_dataset$Sepal.Width[1:3]
#> [1] 1.457143 1.633333 1.468750
```

But does it makes sense? With most statistical datasets, you only know
if adding, subtracting, dividing and multiplying makes sense if you know
the unit of measure. You may want to compare centimetres with
centimetres, and avoid adding GDP values measured in dollars to GDP
values measured in euros or yen.

So, we ensure that the unit of the variables remains attached in the
attributes:

``` r
#needs to be corrected!
var_label(iris_dataset, unlist=TRUE)
```

``` r
var_unit(iris_dataset$Sepal.Length)
#> [1] "centimeter"
```

``` r
var_definition(iris_dataset$Species)
```

``` r
var_namespace(iris_dataset$Species)
```

Last, but not least, how can we know that this `iris_dataset` is that
`iris` dataset? What happened with the dataset since creation? We record
and attach to the object data provenance information.

    #> <https://doi.org/10.5281/zenodo.10396807> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://purl.org/linked-data/cube#DataSet> .
    #> <https://orcid.org/0000-0001-7513-6760> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.w3.org/ns/prov#Agent> .
    #> <https://doi.org/10.5281/zenodo.6703764.> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.w3.org/ns/prov#SoftwareAgent> .
