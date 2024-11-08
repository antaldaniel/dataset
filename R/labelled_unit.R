#' @title Create a labelled vector with defined unit of measure
#' @param x A vector to label. Must be either numeric (integer or double) or
#'   character.
#' @param labels A named vector or `NULL`. The vector should be the same type
#'   as `x`. Unlike factors, labels don't need to be exhaustive: only a fraction
#'   of the values might be labelled.
#' @param label A short, human-readable description of the vector.
#' @param unit The unit of measure described with a character string of length one.
#' @importFrom haven labelled
#' @export

labelled_unit <- function(x = double(), labels = NULL, label = NULL, unit = NULL) {
  x <- vec_data(x)
  labels <- vec_cast_named(labels, x, x_arg = "labels", to_arg = "x")
  new_labelled_unit(x, labels = labels, label = label, unit = unit)
}

#' @rdname labelled_unit
is.labelled_unit <- function(x) inherits(x, "haven_labelled_unit")


#' From haven
#' @keywords internal
vec_cast_named <- function (x, to, ...)
{
  stats::setNames(vec_cast(x, to, ...), names(x))
}

#' @importFrom tibble new_tibble
#' @keywords internal
new_labelled_unit <- function(x = double(),
                              labels = NULL,
                              label = NULL,
                              unit = NULL) {

  if (!is.null(unit) && (!is.character(unit) || length(unit) != 1)) {
    stop("labelled_unit(..., unit): 'unit' must be a character vector of length one.")
  }

  tmp <- labelled(x, labels=labels, label=label)

  attr(tmp, "unit") <- unit
  attr(tmp, "class") <- c("haven_labelled_unit", class(tmp))

  tmp
}

#' @rdname labelled_unit
#' @export
as.character.haven_labelled_unit <- function(x, ...) {
  NextMethod()
}

#' @rdname labelled_unit
#' @export
summary.haven_labelled_unit <- function(object, ...) {

  title <- ifelse(nchar(var_label(object))>1, var_label(object), "")

  title <- ifelse(nchar(var_unit(object)) & nchar(title)>1,
                  paste0(title, " (", var_unit(object), ")\n"),
                  paste0(title, "\n"))
  cat(title)
  NextMethod()
}
