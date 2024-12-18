% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/var_unit.R
\name{var_unit}
\alias{var_unit}
\alias{var_unit<-}
\alias{get_variable_units}
\alias{unit_attribute}
\alias{get_unit_attribute}
\alias{set_unit_attribute}
\alias{unit_attribute<-}
\title{Get / Set a unit of measure}
\usage{
var_unit(x, ...)

var_unit(x) <- value

get_variable_units(x, ...)

unit_attribute(x)

get_unit_attribute(x)

set_unit_attribute(x, value)

unit_attribute(x) <- value
}
\arguments{
\item{x}{A vector.}

\item{...}{Further potential parameters reserved for inherited classes.}

\item{value}{A character string or \code{NULL} to remove the unit of measure.}
}
\description{
Get / Set a unit of measure
}
\details{
\code{get_variable_units()} is identical to \code{var_unit()}.
}
\examples{
var_unit(iris$Sepal.Length)
var_unit(iris$Sepal.Length) <- "centimeter"
\dontrun{
View(iris)
}
# To remove a unit of measure
var_unit(iris$Sepal.Length) <- NULL
}
